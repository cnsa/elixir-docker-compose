defmodule SomeApp.WelcomeController do
  use SomeApp.Web, :controller
  require Logger
  import SomeApp.{MainHelper, OtherHelper}

  def index(conn, _params) do
    SomeApp.Fastlane.Server.subscribe "user:123", SomeApp.Actor, [555]
    SomeApp.Fastlane.Server.publish   "user:123", %{id: 123, name: "Shane"}

    messages =
        Process.info(self)[:messages]
        |> Enum.filter(fn
          {id, _} -> id == :user_update
          {id, _, :subscribed, _} -> id == :redix_pubsub
          {id, _, :message, _} -> id == :redix_pubsub
        end)
    count = Enum.count(messages)

    Logger.info "Messages size: #{count}"
    render conn, "index.html"
  end
end
