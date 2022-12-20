defmodule Day04 do
  def part_1(input) do
    assigments = parse_input(input)

    overlaps =
      Enum.count(assigments, fn {a, b} ->
        MapSet.subset?(a, b) ||
          MapSet.subset?(b, a)
      end)

    IO.puts("There are #{overlaps} full overlaps.")
  end

  def part_2(input) do
    assigments = parse_input(input)

    overlaps =
      Enum.count(assigments, fn {a, b} ->
        a
        |> MapSet.intersection(b)
        |> MapSet.size()
        |> Kernel.>(0)
      end)

    IO.puts("There are #{overlaps} partial overlaps.")
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn i ->
      [assigment_a, assigment_b] = String.split(i, ",")

      [start_a, ending_a] = String.split(assigment_a, "-")
      [start_b, ending_b] = String.split(assigment_b, "-")

      a = MapSet.new(Range.new(String.to_integer(start_a), String.to_integer(ending_a)))
      b = MapSet.new(Range.new(String.to_integer(start_b), String.to_integer(ending_b)))

      {a, b}
    end)
  end
end

input = IO.read(:stdio, :all)

Day04.part_1(input)
Day04.part_2(input)
