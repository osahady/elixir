defmodule PollerPhxWeb.AuthController do
  alias PollerDal.Users
  use PollerPhxWeb, :controller

  def new(conn, _params), do: render(conn, "new.html")

  def create(conn, %{"email" => email, "password" => password}) do
    conn
    |> login_by_email_and_password(email, password)
    |> handle_login_response()
  end

  defp login_by_email_and_password(conn, email, password) do
    case Users.authenticate(email, password) do
      {:ok, user} -> {:ok, login(conn, user)}
      {:error, reason} -> {:error, reason, conn}
    end
  end

  defp login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  defp handle_login_response({:ok, conn}) do
    conn
    |> put_flash(:info, "Welcome")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp handle_login_response({:error, :bad_email, conn}) do
    conn
    |> put_flash(:error, "Unkown email address")
    |> render("new.html")
  end

  defp handle_login_response({:error, :bad_password, conn}) do
    conn
    |> put_flash(:error, "Invalid password!")
    |> render("new.html")
  end
end