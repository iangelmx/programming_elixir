defmodule OwnList do
  @moduledoc """
  Documentation for OwnList.
  """

  @doc """
  Implements the reduce function for the OwnList module.
  Receives a list, the initial value and the function to apply.
  Returns the reduce list with the applied function
  """
  @spec reduce(list(), any, function()) :: any
  def reduce([], value, _func), do: value
  def reduce( [head | tail], value, func ) do
    reduce( tail, func.(head, value), func )
  end

  @doc """
  Returns a function that sum the current value to the function applied
  on the given list.
  """
  @spec mapsum(list(), any, function()) :: number()
  def mapsum([], value, _func), do: value
  def mapsum([head | tail], value, func) do
    mapsum( tail, func.( head )+value, func )
  end

  @spec max(list()) :: number()
  def max([head | tail]), do: do_max(head, tail)

  defp do_max( value, [] ), do: value

  defp do_max( value, [head | tail] ) do
    do_max( Kernel.max( value, head ), tail )
  end


end
