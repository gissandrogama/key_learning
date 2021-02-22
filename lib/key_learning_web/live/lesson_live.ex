defmodule KeyLearningWeb.LessonLive do
  use KeyLearningWeb, :live_view
  alias KeyLearning.School

  @impl true
  def mount(%{"id" => id}, session, socket) do
    socket = KeyLearningWeb.LiveHelpers.assign_default(session, socket)
    lecture = id |> School.get_lecture!()
    {:ok, socket |> assign(lecture: lecture)}
  end
end
