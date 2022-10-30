defmodule Counter do
  def start_link(intial \\ 0) when is_integer(intial) do
    spawn_link(Counter, :run, [intial])
  end

  def increment(pid) when is_pid(pid) do
    send(pid, :increment)
  end

  def decrement(pid) when is_pid(pid) do
    send(pid, :decrement)
  end

  def count(pid) when is_pid(pid) do
    send(pid, {:count, self()})

    receive do
      {^pid, count} ->
        count
    end
  end

  # --------new process call--------------
  def run(count) do
    receive do
      msg ->
        handle(msg, count)
    end
    # |> IO.inspect(label: "Count")
    |> run()
  end

  def handle(:increment, count), do: count + 1
  def handle(:decrement, count), do: count - 1

  def handle({:count, callerPid}, count) do
    send(callerPid, {self(), count})
    count
  end

  def handle(msg, count) do
    IO.inspect(msg, label: "Unknown Msg")
    count
  end
end
