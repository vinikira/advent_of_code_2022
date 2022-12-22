defmodule Day06 do
  def part_1(input) do
    first_marker_index = find_uniq_marker(input, 4)

    IO.puts("The start of package marker appears after #{first_marker_index}")
  end

  def part_2(input) do
    first_message_marker_index = find_uniq_marker(input, 14)

    IO.puts("The message marker appears after #{first_message_marker_index}")
  end

  defp find_uniq_marker(input, n_uniq) do
    input
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {char, index}, acc ->
      if index >= n_uniq - 1 do
        acc = [char | acc]

        tmp = Enum.take(acc, n_uniq)

        if Enum.uniq(tmp) == tmp do
          {:halt, index + 1}
        else
          {:cont, acc}
        end
      else
        {:cont, [char | acc]}
      end
    end)
  end
end

input = IO.read(:stdio, :all)

Day06.part_1(input)
Day06.part_2(input)
