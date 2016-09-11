defmodule SomeApp.LayoutView do
  @version Mix.Project.config[:version]

  use SomeApp.Web, :view

  def app_version do
    hostname = case :inet.gethostname do
      {:ok, hostname} -> "::" <> List.to_string(hostname)
      _               -> ""
    end
    @version <> hostname
  end
end
