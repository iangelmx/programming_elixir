defmodule Stack.Impl do

  def pop([_top | tail_stack]) do
    tail_stack
  end

  def push(element, current_stack) do
    [element | current_stack]
  end

end
