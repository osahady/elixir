voting_machines_ips = [
  "10.0.1.1",
  "10.0.1.2",
  "10.0.1.3",
  "10.0.1.4",
  "10.0.1.5",
  "10.0.1.6",
  "10.0.1.7",
  "10.0.1.8",
  "10.0.1.9",
  "10.0.1.10"
]

simulating_api_call = fn
  "10.0.1.5" ->
    raise "Unable to connect"

  _ip ->
    votes = Enum.random(255..275)
    :timer.sleep(votes)
    votes
end

defmodule Worker do
  def start(fun) do
    parent_caller = self()

    spawn_link(fn ->
      send(parent_caller, {self(), fun.()})
    end)
  end

  def wait(spawned_pid) do
    receive do
      {^spawned_pid, value} ->
        value
    after
      2_000 -> {:error, "Receive Timeout"}
    end
  end
end

voting_machines_ips
|> Enum.map(&Worker.start(fn -> simulating_api_call.(&1) end))
|> IO.inspect()
|> Enum.map(&Worker.wait/1)
|> Enum.sum()
|> IO.inspect()

:timer.sleep(300)
Process.info(self(), :messages) |> IO.inspect()
