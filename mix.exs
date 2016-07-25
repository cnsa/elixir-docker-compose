defmodule SomeApp.Mixfile do
  use Mix.Project

  def project do
    [app: :some_app,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {SomeApp, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :phoenix_pubsub_redis, :poolboy, :cowboy,
                    :logger, :gettext]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_pubsub_redis, "~> 2.1.2", github: "merqlove/phoenix_pubsub_redis", branch: "fastlane-detection"},
     {:phoenix_html, "~> 2.6"},
     {:gettext, "~> 0.11"},
     {:poolboy, "~> 1.5.1"},
     {:cowboy, "~> 1.0"},
     {:exrm, "~> 1.0"}]
  end
end
