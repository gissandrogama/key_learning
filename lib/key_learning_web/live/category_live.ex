defmodule KeyLearningWeb.CategoryLive do
  use KeyLearningWeb, :live_view
  alias KeyLearning.School

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       courses: School.list_courses(),
       search: "",
       loading: false
     )}
  end

  @impl true
  def handle_event("search", %{"search" => search}, socket) do
    send(self(), {:search_filter, search})
    {:noreply, socket |> assign(courses: [], loading: true)}
  end

  @impl true
  def handle_info({:search_filter, search}, socket) do
    search
    |> School.list_courses()
    |> case do
      [] ->
        socket =
          socket
          |> put_flash(:error, "Course does not exist")
          |> assign(courses: [], loading: false)
        {:noreply, socket}

      courses ->
        {:noreply, socket |> assign(courses: courses, loading: false)}
    end
  end
end
