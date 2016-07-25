defmodule SomeApp.Router do
  use SomeApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Plug.Logger, log: :debug
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SomeApp do
    pipe_through [:browser]

    get "/", WelcomeController, :index
  end

  scope "/api", SomeApp do
    pipe_through :api
  end
end
