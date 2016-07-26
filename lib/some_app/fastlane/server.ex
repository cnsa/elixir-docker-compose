defmodule SomeApp.Fastlane.Server do
  use GenServer
  require Logger

  @redix_opts [:host, :port, :password, :database]

  defmodule Subscription do
    defstruct parent: nil, options: [], channel: nil
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: FastlaneRedis)
  end

  def init(opts) do
    Process.flag(:trap_exit, true)
    channels = :ets.new(opts[:pool_name], [:set, :named_table, {:read_concurrency, true}])
    state = %{server_name: Keyword.fetch!(opts, :server_name),
              channels: channels,
              opts: opts,
              connected: false,
              pool_name: Keyword.fetch!(opts, :pool_name),
              namespace: Keyword.fetch!(opts, :namespace),
              redix_pid: nil}

    {:ok, establish_conn(state)}
  end

  def lookup, do: GenServer.call(FastlaneRedis, :lookup)

  def find(channel), do: GenServer.call(FastlaneRedis, {:find, channel})

  defp find(channels, channel) do
    case :ets.lookup(channels, channel) do
      [{^channel, subscription}] -> {:ok, %{ id: channel, subscription: subscription}}
      [] -> :error
    end
  end

  def subscribe(channel, parent, options), do: GenServer.call(FastlaneRedis, {:subscribe, channel, parent, options})
  def subscribe(channel), do: GenServer.call(FastlaneRedis, {:subscribe, channel, nil, []})

  def publish(channel, message), do: GenServer.call(FastlaneRedis, {:publish, channel, message})

  def drop(channel), do: GenServer.cast(FastlaneRedis, {:drop, channel})

  def handle_call({:publish, channel, message}, _from, state) do
    {:reply, _publish(channel, message, state.pool_name), state}
  end

  def handle_call(:lookup, _from, state) do
    {:reply, self(), state}
  end

  def handle_call({:find, channel}, _from, %{channels: channels} = state) do
    result = find(channels, channel)

    {:reply, result, state}
  end

  def handle_call({:subscribe, channel, parent, options}, {pid, _ref}, %{channels: _, redix_pid: _} = state) do
    if parent do
      subscription = %Subscription{parent: parent, options: options, channel: channel}
      subscribe_to_channel(state, channel, subscription)

      {:reply, subscription, state}
    else
      subscribe_to_channel(state, channel, pid)
      {:reply, :ok, state}
    end
  end

  def handle_cast({:drop, channel}, %{channels: channels} = state) do
    true = :ets.delete(channels, channel)

    {:noreply, state}
  end

  def handle_info({:redix_pubsub, redix_pid, :subscribed, _}, %{redix_pid: redix_pid} = state) do
    {:noreply, state}
  end

  def handle_info({:redix_pubsub, redix_pid, :message, %{payload: payload, channel: id}}, %{channels: channels, redix_pid: redix_pid} = state) do
    case find(channels, id) do
      {:ok, channel} ->
        channel.subscription.parent.fastlane(payload, channel.subscription.options)
        drop(id)
      _ -> nil
    end

    {:noreply, state}
  end

  defp _publish(channel, message, pool_name) do
    message_json = Poison.encode!(message)
    :poolboy.transaction pool_name, fn(redix_pid) ->
      case Redix.command(redix_pid, ["PUBLISH", channel, message_json]) do
        {:ok, _} -> :ok
        {:error, reason} -> {:error, reason}
      end
    end
  end

  defp subscribe_to_channel(%{connected: true, redix_pid: redix_pid, channels: channels}, channel, %Subscription{} = subscription) do
    true = :ets.insert(channels, {channel, subscription})
    :ok  = Redix.PubSub.subscribe(redix_pid, channel, self())
  end
  defp subscribe_to_channel(%{connected: true, redix_pid: redix_pid}, channel, pid) do
    :ok  = Redix.PubSub.subscribe(redix_pid, channel, pid)
  end
  defp subscribe_to_channel(_, _, _), do: :error

  defp establish_conn(state) do
    redis_opts = Keyword.take(state.opts, @redix_opts)
    case Redix.PubSub.start_link(redis_opts) do
      {:ok, redix_pid} -> %{state | redix_pid: redix_pid, connected: true}
      {:error, _} -> Logger.error("No connection to Redis")
    end
  end
end
