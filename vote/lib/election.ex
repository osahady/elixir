defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Will Ferrel"),
      Candidate.new(2, "Kristen Wigg")
    ],
    next_id: 3
  )

  def view_header(election) do
    [
      "Election for: #{election.name}\n"
    ]
  end

  def view_body(election) do
    election.candidates
    |> sort_candidates_by_votes_desc()
    |> candidates_to_strings()
    |> prepend_candidates_header()
  end

  def view_footer() do
    [
      "\n",
      "commands: (n)ame <election>, (a)dd <candidate>, (v)ote <id>, (q)uit\n"
    ]
  end

  defp prepend_candidates_header(candidates) do
    [
      "ID\tVotes\tName\n",
      "---------------------------\n"
      | candidates
    ]
  end

  defp candidates_to_strings(candidates) do
    candidates
    |> Enum.map(&"#{&1.id}\t#{&1.votes}\t#{&1.name}\n")
  end

  defp sort_candidates_by_votes_desc(candidates) do
    candidates
    |> Enum.sort(&(&1.votes >= &2.votes))
  end
end
