defmodule SomeApp.WelcomeController do
  use SomeApp.Web, :controller
  require Logger
  import SomeApp.{MainHelper, OtherHelper}

  def index(conn, _params) do
    :ok = Redix.PubSub.Fastlane.psubscribe :some_app_redis, "user*",   {SomeApp.Actor, [555]}
    :ok = Redix.PubSub.Fastlane.subscribe  :some_app_redis, "tuser:7", {SomeApp.Actor, [555]}
    :ok = Redix.PubSub.Fastlane.psubscribe :some_app_redis, "muser*",  {nil, [556]}
    :ok = Redix.PubSub.Fastlane.psubscribe :some_app_redis, "nuser*",  {SomeApp.Actor, [556]}

    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "user:123",  {&Poison.encode!/1, %{id: 123, name: "Shane"}}
    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "tuser:7",   {&Poison.encode!/1, %{id: 7, name: "Tuser"}}
    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "muser:453", "Lane"
    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "nuser:554", "SuperNuser"

    {:ok, _user_data}  = Redix.PubSub.Fastlane.Server.find(:some_app_redis, "user*")
    {:ok, _tuser_data} = Redix.PubSub.Fastlane.Server.find(:some_app_redis, "tuser:7")
    {:ok, _muser_data} = Redix.PubSub.Fastlane.Server.find(:some_app_redis, "muser*")
    {:ok, _nuser_data} = Redix.PubSub.Fastlane.Server.find(:some_app_redis, "nuser*")

    render conn, "index.html"
  end
end
