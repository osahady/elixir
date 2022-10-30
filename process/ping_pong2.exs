defmodule Pingpong do
  def mailbox() do
    receive do
      {:ping, process1, process2} ->
        :timer.sleep(500)
        IO.puts("Ping!")
        send(process2, {:pong, process1, process2})
        mailbox()

      {:pong, process1, process2} ->
        :timer.sleep(500)
        IO.puts("Pong!")
        send(process1, {:ping, process1, process2})
        mailbox()
    end
  end
end
