defmodule SomeApp.WelcomeController do
  use SomeApp.Web, :controller
  require Logger
  import SomeApp.{MainHelper, OtherHelper}

  def index(conn, _params) do
    Phoenix.PubSub.subscribe :some_app_redis, "user:123"
    Phoenix.PubSub.broadcast :some_app_redis, "user:123", {:user_update, %{id: 123, name: "Shane"}}

    messages =
        Process.info(self)[:messages]
        |> Enum.filter(fn({id, _}) -> id == :user_update end)
    count = Enum.count(messages)

    if count > 30, do: Phoenix.PubSub.unsubscribe :some_app_redis, "user:123"

    Logger.info "Messages size: #{count}"
    render conn, "index.html"
  end
end
