defmodule Stack.Structure do
  @moduledoc """
  This module is the implementation of a Right-Stack structure.
  If starts as [1,2,3], the top will be "1".

  With call :pop it returns top of the stack ([head|_])
  With call :get_stack it returns the current stack

  """
  use GenServer

  @doc """
  Recieves an list and builds the initial stack
  """
  @spec init( list() ) :: any()
  def init(initial_stack) when is_list(initial_stack) do
    { :ok, initial_stack }
  end
  def init(_), do: {:error, "The input given is not a list"}

   def handle_call(:pop, _from, [top | tail_stack]) do
     {:reply, top, tail_stack }
   end

   def handle_call(:get_stack, _from, current_stack) do
     {:reply, current_stack, current_stack }
   end


end
