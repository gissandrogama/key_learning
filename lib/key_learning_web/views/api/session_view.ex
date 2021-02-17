defmodule KeyLearningWeb.Api.SessionView do
  use KeyLearningWeb, :view

  def render("error.json", %{message: message}) do
    %{status: :not_found, data: %{}, message: message}
  end
end
