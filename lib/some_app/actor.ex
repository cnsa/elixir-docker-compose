defmodule SomeApp.Actor do
  require Logger

  def fastlane(payload, options) do
    Logger.info "Actor fastlane"

    IO.inspect payload
    IO.inspect options
  end
end
