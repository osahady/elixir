defmodule HelloWeb.LayoutView do
  use HelloWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def title() do
    "THERE IS NO GOD BUT ALLAH"
  end
end
