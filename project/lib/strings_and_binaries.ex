defmodule StringsAndBinaries do
  @moduledoc """
  Contains functions logic of sugested problems in Programming ELixir 1.6
  book.
  """

  @spec center(list(String.t())) :: no_return()
  def center(string_list) do
    sorted_list = Enum.sort(string_list, &(byte_size(&1) <= byte_size(&2)))

    max_lenght =
      Enum.at(sorted_list, -1)
      |> String.length()

    center_line = round(max_lenght / 2)

    sorted_list
    |> Enum.each(fn word ->
      center_word_at(word, center_line)
      |> IO.puts()
    end)
  end

  defp center_word_at(word_to_center, center) do
    word_length = String.length(word_to_center) - 1

    leading =
      word_length
      |> get_center_of_word_from(center)

    String.pad_leading(word_to_center, leading + word_length)
  end

  defp get_center_of_word_from(word_length, center) do
    center - round(word_length / 2)
  end
end
