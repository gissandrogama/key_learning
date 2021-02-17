defmodule KeyLearningWeb.Api.SessionController do
  use KeyLearningWeb, :controller

  def create(conn, %{"email" => nil}) do
    conn
    |> put_status(401)
    |> render("error.json", message: "You could not be authenticated")
  end
end
