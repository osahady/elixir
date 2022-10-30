defmodule Comm do
  def sum(a, b) do
    other_than_iex_process = self()

    receive do
      {:work, me, _pid} ->
        # code
        IO.puts("I'm #{inspect(other_than_iex_process)}")
        IO.puts("working on: #{a} + #{b}")
        send(me, a + b)
        sum(a, b)
    end
  end
end
