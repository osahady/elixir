defmodule PollerDal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:admin, :boolean, default: false)

    timestamps()
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 5)
    |> email_to_downcase()
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  def admin_changeset(user, attrs) do
    user
    |> cast(attrs, [:admin])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hash_md5(password))

      _ ->
        changeset
    end
  end

  defp hash_md5(password) do
    :crypto.hash(:md5, password)
    |> Base.encode16()
  end

  def email_to_downcase(changeset) do
    case get_field(changeset, :email) do
      nil -> changeset
      email -> put_change(changeset, :email, String.downcase(email))
    end
  end
end
