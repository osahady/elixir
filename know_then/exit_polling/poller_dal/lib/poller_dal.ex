defmodule PollerDal do
  use Application

  @impl true
  def start(_arg, _type) do
    children = [
      {PollerDal.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: PollerDal.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
