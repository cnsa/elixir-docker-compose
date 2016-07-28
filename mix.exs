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
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html,
                    :poolboy, :cowboy, :redix_pubsub_fastlane,
                    :logger, :gettext, :p1_utils, :iconv]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:redix_pubsub_fastlane, "~> 0.1", github: "merqlove/redix_pubsub_fastlane"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:gettext, "~> 0.11"},
     {:poison, "~> 2.0"},
     {:iconv, "~> 1.0", github: "processone/iconv", ref: "1.0.1", compile: "./configure; ~/.mix/rebar get-deps compile"},
     {:p1_utils, "~> 1.0"},
     {:poolboy, "~> 1.5.1"},
     {:cowboy, "~> 1.0"},
     {:exrm, "~> 1.0"}]
  end
end
