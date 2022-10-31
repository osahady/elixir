defmodule Counter do
  def init(intial_count) do
    {:ok, intial_count}
  end

  def handle_call(:inc, _from, count) do
    # IO.puts("from: #{inspect(from)}") from represents iex
    updated_count = count + 1
    {:reply, updated_count, updated_count}
  end

  def handle_call(:dec, _from, count) do
    updated_count = count - 1
    {:reply, updated_count, updated_count}
  end

  def handle_call(:current, _from, count) do
    {:reply, count, count}
  end
end
