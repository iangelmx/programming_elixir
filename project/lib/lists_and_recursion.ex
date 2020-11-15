defmodule ListsAndRecursion do
  @moduledoc """
  Documentation for OwnList.
  """

  @doc """
  Implements the reduce function for the OwnList module.
  Receives a list, the initial value and the function to apply.
  Returns the reduce list with the applied function
  ListsAndRecursions-0

  ## Examples:

      iex> reduce([1,2,3], 0, &(&1+&2))
      6

      iex> reduce([1,2], 1, fn a,b -> a*b end)
      2
  """
  @spec reduce(list(), any, function()) :: any
  def reduce([], value, _func), do: value

  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  @doc """
  Returns a function that sum the current value to the function applied
  on the given list.

  ListsAndRecursions-1

  ## Examples:

      iex> mapsum([1,2,3], 1, &(&1*&1))
      14
  """
  @spec mapsum(list(), any, function()) :: number()
  def mapsum([], value, _func), do: value

  def mapsum([head | tail], value, func) do
    mapsum(tail, func.(head) + value, func)
  end

  @doc """
  Returns the maximum number of the given list
  ListsAndRecursions-2

  ## Examples:

      iex>max([1,2,3,4,5])
      5

      iex>max([1,2,30,4,5])
      30
  """
  @spec max(list()) :: number()
  def max([head | tail]), do: do_max(head, tail)

  defp do_max(value, []), do: value

  defp do_max(value, [head | tail]) do
    do_max(Kernel.max(value, head), tail)
  end

  @doc """
  Returns an altered charlist adding the number provided to each
  character.
  ListsAndRecursions-3

  ## Examples:

      iex>caesar('cat',1)
      'dbs'
  """
  @spec caesar(charlist(), any) :: charlist()
  def caesar([], _n), do: []

  def caesar([head | tail], n) do
    [wraping_letters(head, n) | caesar(tail, n)]
  end

  defp wraping_letters(base, n) do
    to_add = rem(n, 26)

    cond do
      base + to_add > 122 -> 97 + rem(base + to_add, 123)
      true -> base + to_add
    end
  end

  @doc """
  Returns an ordered list from the from value up to to.

  ListsAndRecursions-4

  ## Examples:

      iex> span(5, 10)
      [5,6,7,8,9,10]

      iex> span(5, -1)
      [-1,0,1,2,3,4,5]
  """
  @spec span(integer(), integer()) :: list()
  def span(from, to) when is_integer(from) and is_integer(to) do
    {from, to} = checks_higher(from, to)
    do_list_from_to([], from, to)
  end

  defp checks_higher(a, b) when a < b, do: {a, b}
  defp checks_higher(a, b) when b < a, do: {b, a}
  defp do_list_from_to([], from, to), do: do_list_from_to([to], from, to)

  defp do_list_from_to([head | tail], from, to) when head > from do
    do_list_from_to([head - 1, head | tail], from, to)
  end

  defp do_list_from_to(list = [head | _tail], from, _to) when head <= from, do: list

  @spec all?(list(), function()) :: boolean
  def all?(list, function) do
    check_if_all_values(list, true, function)
  end

  defp check_if_all_values([], true, _func), do: true

  defp check_if_all_values([head | tail], true, func) do
    if func.(head) do
      check_if_all_values(tail, true, func)
    else
      check_if_all_values(head, false, func)
    end
  end

  defp check_if_all_values(_, false, _func), do: false

  def each(list, function) do
    apply_each(list, function, [])
  end

  defp apply_each([], _func, acum) do
    IO.inspect(acum)
    :ok
  end

  defp apply_each([head | tail], func, acum) do
    acum = acum ++ [func.(head)]
    apply_each(tail, func, acum)
  end

  @spec take(list(), integer()) :: []
  def take(list, number) when is_integer(number) do
    take_only_from_list(list, number, [])
  end

  def list_lenght([]), do: 0
  def list_lenght([_head | tail]) when tail == [], do: 1

  def list_lenght([_head | tail]) do
    1 + list_lenght(tail)
  end

  defp take_only_from_list([], _number, acum), do: acum

  defp take_only_from_list([head | tail], number, acum) do
    if list_lenght(acum) < number do
      new = acum ++ [head]
      take_only_from_list(tail, number, new)
    else
      acum
    end
  end
end
