defmodule KeyLearningWeb.EnsureRolePlug do
  import Plug.Conn
  alias KeyLearning.Accounts
  alias KeyLearning.Accounts.User
  alias Phoenix.Controller

  def init(roles) do
    roles
  end

  def call(conn, roles) do
    user_token = get_session(conn, :user_token)

    (user_token &&
       Accounts.get_user_by_session_token(user_token))
    |> has_role?(roles)
    |> maybe_halt(conn)

    conn
  end

  defp has_role?(user, roles) when is_list(roles) do
    Enum.any?(roles, &has_role?(user, &1))
  end

  defp has_role?(%User{role: role}, role), do: true
  defp has_role?(_user, _role), do: false

  defp maybe_halt(true, conn), do: conn

  defp maybe_halt(false, conn) do
    conn
    |> Controller.put_flash(:error, "Unanuthorised")
    |> Controller.redirect(to: "/")
    |> halt()
  end
end
