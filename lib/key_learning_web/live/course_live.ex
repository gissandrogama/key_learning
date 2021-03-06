defmodule KeyLearningWeb.CourseLive do
  use KeyLearningWeb, :live_view
  alias KeyLearning.School

  @impl true
  def mount(%{"id" => id}, session, socket) do
    socket = KeyLearningWeb.LiveHelpers.assign_default(session, socket)
    course = id |> School.get_course!()
    {:ok, socket |> assign(course: course)}
  end
end
