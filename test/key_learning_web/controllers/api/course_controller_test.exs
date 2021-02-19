defmodule KeyLearningWeb.Api.CourseControllerTest do
  use KeyLearningWeb.ConnCase

  alias KeyLearning.School
  alias KeyLearning.School.Course

  @create_attrs %{
    image_path: "some image_path",
    name: "some name"
  }
  @update_attrs %{
    image_path: "some updated image_path",
    name: "some updated name"
  }
  @invalid_attrs %{image_path: nil, name: nil}

  def fixture(:course) do
    {:ok, course} = School.create_course(@create_attrs)
    course
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all courses", %{conn: conn} do
      conn = get(conn, Routes.api_course_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create course" do
    setup :register_and_sign_in_for_jwt

    test "renders course when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_course_path(conn, :create), course: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_course_path(conn, :show, id))

      assert %{
               "id" => id,
               "image_path" => "some image_path",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_course_path(conn, :create), course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update course" do
    setup [:create_course, :register_and_sign_in_for_jwt]

    test "renders course when data is valid", %{conn: conn, course: %Course{id: id} = course} do
      conn = put(conn, Routes.api_course_path(conn, :update, course), course: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_course_path(conn, :show, id))

      assert %{
               "id" => id,
               "image_path" => "some updated image_path",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, course: course} do
      conn = put(conn, Routes.api_course_path(conn, :update, course), course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete course" do
    setup [:create_course, :register_and_sign_in_for_jwt]

    test "deletes chosen course", %{conn: conn, course: course} do
      conn = delete(conn, Routes.api_course_path(conn, :delete, course))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_course_path(conn, :show, course))
      end
    end
  end

  defp create_course(_) do
    course = fixture(:course)
    %{course: course}
  end
end
