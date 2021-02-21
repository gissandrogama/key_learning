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
       loading: false,
       matches: []
     )}
  end

  @impl true
  def handle_event("options-available", %{"search" => search}, socket) do
    options_courses =
      search
      |> School.list_courses()
      |> Enum.map(& &1.name)

    {:noreply, socket |> assign(matches: options_courses)}
  end

  @impl true
  def handle_event("search", %{"search" => search}, socket) do
    send(self(), {:search_filter, search})
    {:noreply, socket |> assign(courses: [], search: search, matches: [], loading: true)}
  end

  @impl true
  def handle_info({:search_filter, search}, socket) do
    :timer.sleep(2000)

    search
    |> School.list_courses()
    |> case do
      [] ->
        socket =
          socket
          |> put_flash(:error, "Course does not exist")
          |> assign(courses: [], search: search, matches: [], loading: false)

        {:noreply, socket}

      courses ->
        {:noreply,
         socket |> assign(courses: courses, search: search, matches: [], loading: false)}
    end
  end
end
