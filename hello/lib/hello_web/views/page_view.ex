defmodule HelloWeb.PageView do
  use HelloWeb, :view

  def render("index.json", %{pages: pages}) do
    %{data: Enum.map(pages, fn page -> %{title: page.title} end)}
  end

  def render("show.json", %{page: page}) do
    %{data: %{title: page.title}}
  end
end
