defmodule SomeApp.Actor do
  require Logger

  def fastlane(message, options) do
    Logger.info "Actor fastlane"

    IO.inspect message.channel
    IO.inspect message.payload
    IO.inspect Poison.decode(message.payload)
    IO.inspect options
  end
end
