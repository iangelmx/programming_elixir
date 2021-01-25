defmodule Stack.Server do

  use GenServer
  alias Stack.Impl

  def init(initial_stack) do
    {:ok, initial_stack}
  end

  def handle_call(:pop, _from, [top | _] = current_stack) do
    {:reply, top, Impl.pop(current_stack)}
  end

  def handle_call(:show, _from, current_stack) do
    {:reply, current_stack, current_stack}
  end

  def handle_cast({:push, element}, current_stack ) do
    {:noreply, Impl.push(element, current_stack)}
  end

end
