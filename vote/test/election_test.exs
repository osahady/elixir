defmodule ElectionTest do
  use ExUnit.Case
  doctest(Election)

  setup do
    %{election: %Election{}}
  end

  test "updating struct election from a command", ctx do
    command = "name Afrin General Mayor"
    election = ctx.election |> Election.update(command)
    assert election == %Election{name: "Afrin General Mayor"}
  end

  test "adding a new candidate from a command", ctx do
    command = "add Osama Abdelhady"
    election = ctx.election |> Election.update(command)

    assert election == %Election{
             name: "",
             candidates: [%Candidate{id: 1, name: "Osama Abdelhady", votes: 0}],
             next_id: 2
           }
  end

  test "voting for a candidate from a command", ctx do
    command = "add Osama Abdelhady"
    election = ctx.election |> Election.update(command)
    command = "vote 1"

    election =
      election
      |> Election.update(command)

    assert election == %Election{
             name: "",
             candidates: [%Candidate{id: 1, name: "Osama Abdelhady", votes: 1}],
             next_id: 2
           }
  end

  test "quitting the app by command", ctx do
    command = "quit"
    election = ctx.election |> Election.update(command)
    assert election == :quit
  end
end
