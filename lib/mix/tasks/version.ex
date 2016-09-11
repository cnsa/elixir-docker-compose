defmodule Mix.Tasks.SomeApp.Version do
  use Mix.Task

  @shortdoc "Projects version"

  def run(_) do
    IO.puts Mix.Project.config[:version]
  end
end
