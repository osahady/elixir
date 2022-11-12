defmodule Poller.PollServer do
  use GenServer
  alias Poller.Poll
  # client
  def start_link(district_id) do
    name = district_name(district_id)
    GenServer.start_link(__MODULE__, district_id, name: name)
  end

  def district_name(district_id), do: :"district#{district_id}"

  def add_question(district_id, question) do
    name = district_name(district_id)
    GenServer.call(name, {:question, question})
  end

  def vote(district_id, choice_id) do
    name = district_name(district_id)
    GenServer.call(name, {:vote, choice_id})
  end

  def get_poll(district_id) do
    name = district_name(district_id)
    GenServer.call(name, {:current_poll})
  end

  # server

  @impl true
  def init(district_id) do
    poll = Poll.new(district_id)
    {:ok, poll}
  end

  # {:reply, reply, new_state}. The first element of the tuple, :reply, indicates that the server should send a reply back to the client. The second element, reply, is what will be sent to the client while the third, new_state is the new server state.
  @impl true
  def handle_call({:question, question}, _from, poll) do
    poll = Poll.add_question(poll, question)
    {:reply, poll, poll}
  end

  @impl true
  def handle_call({:vote, choice_id}, _from, poll) do
    poll = Poll.vote(poll, choice_id)
    {:reply, poll, poll}
  end

  @impl true
  def handle_call({:current_poll}, _from, poll) do
    {:reply, poll, poll}
  end
end
