defmodule SomeApp.Actor do
  use GenServer

  require Logger

  @doc """
  Starts the server
  """
  def start_link(name, opts) do
    GenServer.start_link(__MODULE__, [name, opts], name: name)
  end

  @doc """
  Initializes the server.
  """
  def init([name, opts]) do
    state = %{
      server_name: name,
      opts: opts
    }
    {:ok, state}
  end

  def lookup(name), do: GenServer.call(name, :lookup)

  def fastlane(from, message, options) do
    Logger.info "Actor fastlane"

    Logger.info "#{inspect from}"
    Logger.info "#{inspect message.channel}"
    Logger.info "#{inspect message.payload}"
    Logger.info "#{inspect options}"
    :ok
  end

  def handle_call(:lookup, _from, state) do
    {:reply, self(), state}
  end
end
