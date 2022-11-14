defmodule Poller.PollServer do
  use GenServer

  alias Poller.Poll
  alias PollerDal.{Questions, Choices}
  @save_time 10 * 60 * 1000

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
  # ten minutes after starting this GenServer,
  # a save message will get sent from
  # this GenServer process to this GenServer Process
  @impl true
  def init(district_id) do
    schedule_save()
    poll = init_poll(district_id)

    {:ok, poll}
  end

  defp init_poll(district_id) do
    questions = Questions.list_questions_by_district_id(district_id)

    district_id
    |> Poll.new()
    |> Poll.add_questions(questions)
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

  def save_votes(poll) do
    poll.votes
    |> Map.keys()
    |> Choices.list_choices_by_choice_ids()
    |> Enum.each(fn choice ->
      current_votes = Map.get(poll.votes, choice.id, choice.votes)

      if current_votes != choice.votes do
        Choices.update_choice(choice, %{votes: current_votes})
      end
    end)
  end

  def schedule_save(), do: Process.send_after(self(), :save, @save_time)

  @impl true
  def handle_info(:save, poll) do
    save_votes(poll)

    schedule_save()
    {:noreply, poll}
  end

  @impl true
  def terminate(_reason, poll), do: save_votes(poll)
end
