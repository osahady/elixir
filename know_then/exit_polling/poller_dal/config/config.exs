import Config

config :poller_dal, PollerDal.Repo,
  database: "poller_#{Mix.env()}",
  username: "postgres",
  password: "doyouknow",
  hostname: "localhost",
  port: "5433"

config :poller_dal, ecto_repos: [PollerDal.Repo]
