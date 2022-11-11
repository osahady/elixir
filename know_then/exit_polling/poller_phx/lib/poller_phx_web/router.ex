defmodule PollerPhxWeb.Router do
  use PollerPhxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PollerPhxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PollerPhxWeb.Plugs.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PollerPhxWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/auth", PollerPhxWeb do
    pipe_through :browser

    get "/login", AuthController, :new
    post "/login", AuthController, :create
    delete "/logout", AuthController, :delete
  end

  scope "/districts", PollerPhxWeb do
    pipe_through [:browser, :valid_user, :admin_user]

    resources "/", DistrictController, except: [:show]
    resources "/:district_id/questions", QuestionController, except: [:show]
    resources "/:district_id/questions/:question_id/choices", ChoiceController, except: [:show]
  end

  # Other scopes may use custom stacks.
  scope "/api", PollerPhxWeb.Api do
    pipe_through :api

    get "/districts", DistrictController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PollerPhxWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
