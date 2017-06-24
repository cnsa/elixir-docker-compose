defmodule Mix.Tasks.SomeApp.ErlangVersion do
  use Mix.Task

  @shortdoc "Erlang/Elixir version"

  def run(_) do
    IO.puts :erlang.system_info(:system_version) |> List.to_string
    IO.puts System.version()
  end
end
