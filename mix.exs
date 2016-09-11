defmodule SomeApp.Mixfile do
  use Mix.Project

  def project do
    [app: :some_app,
     version: "0.0.4",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {SomeApp, []},
     applications: [:logger, :phoenix, :phoenix_pubsub, :redix_pubsub_fastlane, :phoenix_html,
                    :gettext,
                    :poolboy, :cowboy,
                    :p1_utils, :iconv, :distillery]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:redix_pubsub_fastlane, "~> 0.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:gettext, "~> 0.11"},
     {:poison, "~> 2.0"},
     {:iconv, "~> 1.0", github: "processone/iconv", tag: "1.0.2", compile: "./configure; ~/.mix/rebar get-deps compile"},
     {:p1_utils, "~> 1.0"},
     {:poolboy, "~> 1.5.1"},
     {:cowboy, "~> 1.0"},
     {:excoveralls, "~> 0.5", only: :test},
     {:distillery, "~> 0.9.9"}]
    #  {:distillery, "~> 0.8.0", github: "hammerandchisel/distillery", ref: "8566dd0bad3d6e4f997e81770588af7a4252807e"}]
  end
end
