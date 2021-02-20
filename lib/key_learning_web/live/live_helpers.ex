defmodule KeyLearningWeb.LiveHelpers do
  import Phoenix.LiveView
  alias KeyLearning.Accounts
  alias KeyLearning.Accounts.User

  def assign_default(session, socket) do
    assign_new(socket, :current_user, fn ->
      find_current_user(session)
    end)
  end

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token) do
      user
    end
  end
end
