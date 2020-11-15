defmodule ControlFlow do
  @moduledoc """
  Contains functions using control flow sentences
  """

  @spec fizz_buzz :: :ok
  def fizz_buzz do
    1..100
    |> Enum.each( fn number ->
      cond do
        rem(number, 3) == 0 and rem(number, 5) == 0 -> "FizzBuzz"
        rem(number, 3) == 0 -> "Fizz"
        rem(number, 5) == 0 -> "Buzz"
        true -> number
      end
      |> IO.puts()
    end)
  end

end
