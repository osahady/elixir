defmodule Pingpong do
  def mailbox() do
    IO.inspect(self())

    receive do
      {:ping, pid} ->
        :timer.sleep(500)
        IO.puts("ping!")
        send(pid, {:pong, pid})
        5 + 5
        mailbox()

      {:pong, pid} ->
        :timer.sleep(500)
        IO.puts("pong!")
        send(pid, {:ping, pid})
        1 + 4
        mailbox()
    end
  end
end
