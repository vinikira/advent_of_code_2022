defmodule Day01 do
  def run(input) do
    highest_amounts =
      input
      |> String.split("\n\n")
      |> Enum.map(fn item ->
        item
        |> String.split("\n", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()
      end)
      |> Enum.sort(:desc)
      |> Enum.take(3)

      [first, second, third] = highest_amounts
      sum_of_top_three = Enum.sum(highest_amounts)

    IO.puts("The highest amount of calories transported is: #{first}")
    IO.puts("The 2nd highest amount of calories transported is: #{second}")
    IO.puts("The 3rd highest amount of calories transported is: #{third}")
    IO.puts("The sum of the top 3 is: #{sum_of_top_three}")
  end
end

Day01.run(IO.read(:stdio, :all))
