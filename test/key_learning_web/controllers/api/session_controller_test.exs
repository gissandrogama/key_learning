defmodule KeyLearningWeb.Api.SessionContollerTest do
  use KeyLearningWeb.ConnCase

  import KeyLearning.AccountsFixtures

  test "error: send email nil", %{conn: conn} do
    conn = post(conn, Routes.api_session_path(conn, :create), %{"email" => nil})

    assert json_response(conn, 401) == %{
             "data" => %{},
             "message" => "You could not be authenticated",
             "status" => "not_found"
           }
  end

  test "send email valid and password valid", %{conn: conn} do
    user = user_fixture()

    conn =
      post(conn, Routes.api_session_path(conn, :create), %{
        "email" => user.email,
        "password" => valid_user_password()
      })

    assert %{
             "data" => %{
               "jwt" => "" <> _user_token
             },
             "message" => "You log in successfuly",
             "status" => "ok"
           } = json_response(conn, 200)
  end
end
