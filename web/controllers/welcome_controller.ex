defmodule SomeApp.WelcomeController do
  use SomeApp.Web, :controller
  require Logger
  alias SomeApp.Schema
  import SomeApp.{MainHelper, OtherHelper}

  def index(conn, _params) do
    actor_pid = SomeApp.Actor.lookup(:some_actor)
    :ok = Redix.PubSub.Fastlane.psubscribe :some_app_redis,  "user*",   {actor_pid, SomeApp.Actor, [555]}
    :ok = Redix.PubSub.Fastlane.subscribe  :some_app_redis,  "tuser:7", {actor_pid, SomeApp.Actor, [555]}
    :ok = Redix.PubSub.Fastlane.psubscribe :other_app_redis, "muser*",  {actor_pid, SomeApp.Actor, [556]}
    :ok = Redix.PubSub.Fastlane.psubscribe :other_app_redis, "nuser*",  {actor_pid, SomeApp.Actor, [556]}

    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "user:123",  %Schema{event: "123", data: "Shane"}
    :ok = Redix.PubSub.Fastlane.publish    :some_app_redis, "tuser:7",   %Schema{event: "7", data: "Tuser"}
    :ok = Redix.PubSub.Fastlane.publish    :other_app_redis, "muser:453", "Lane"
    :ok = Redix.PubSub.Fastlane.publish    :other_app_redis, "nuser:554", "SuperNuser"

    # _user_list  = Redix.PubSub.Fastlane.Server.list(:some_app_redis, "user*")
    # _tuser_list = Redix.PubSub.Fastlane.Server.list(:some_app_redis, "tuser:7")
    # _muser_list = Redix.PubSub.Fastlane.Server.list(:other_app_redis, "muser*")
    # _nuser_list = Redix.PubSub.Fastlane.Server.list(:other_app_redis, "nuser*")

    # :ok = Redix.PubSub.Fastlane.punsubscribe :some_app_redis, "user*"
    # :ok = Redix.PubSub.Fastlane.unsubscribe  :some_app_redis, "tuser:7"
    # :ok = Redix.PubSub.Fastlane.punsubscribe :other_app_redis, "muser*"
    # :ok = Redix.PubSub.Fastlane.punsubscribe :other_app_redis, "nuser*"

    render conn, "index.html"
  end
end
