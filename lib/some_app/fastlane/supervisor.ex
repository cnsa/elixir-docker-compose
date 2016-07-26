defmodule SomeApp.Fastlane.Supervisor do
  use Supervisor

  @redis_pool_size 5
  @defaults [host: "127.0.0.1", port: 6379]

  def start_link(name, opts) do
    supervisor_name = Module.concat(name, Supervisor)
    Supervisor.start_link(__MODULE__, [name, opts], name: supervisor_name)
  end

  @doc false
  def init([server_name, opts]) do
    pool_size = Keyword.fetch!(opts, :pool_size)

    opts = Keyword.merge(@defaults, opts)
    redis_opts = Keyword.take(opts, [:host, :port, :password, :database])

    pool_name   = Module.concat(server_name, Pool)
    server_opts = Keyword.merge(opts, pool_name: pool_name,
                                      name: server_name,
                                      server_name: server_name,
                                      namespace: server_name)

    pool_opts = [
      name: {:local, pool_name},
      worker_module: Redix,
      size: pool_size || @redis_pool_size,
      max_overflow: 0
    ]

    children = [
      worker(SomeApp.Fastlane.Server, [server_opts]),
      :poolboy.child_spec(pool_name, pool_opts, redis_opts),
    ]

    supervise children, strategy: :rest_for_one
  end
end
