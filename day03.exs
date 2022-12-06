defmodule Day03 do
  @items_priority ?a..?z
                  |> Enum.concat(?A..?Z)
                  |> Enum.with_index()
                  |> Enum.map(fn {item, priprity} -> {item, priprity + 1} end)
                  |> Enum.into(%{})

  def part_1(input) do
    sum_of_priorities =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn item ->
        item
        |> String.length()
        |> div(2)
        |> then(&String.split_at(item, &1))
      end)
      |> Enum.map(fn {first_compartment, second_compartment} ->
        first_compartment = first_compartment |> String.to_charlist() |> MapSet.new()
        second_compartment = second_compartment |> String.to_charlist() |> MapSet.new()

        priority_letter =
          first_compartment |> MapSet.intersection(second_compartment) |> Enum.at(0)

        Map.get(@items_priority, priority_letter)
      end)
      |> Enum.sum()

    IO.puts("The sum of the priorities items is: #{sum_of_priorities}")
  end

  def part_2(input) do
    bagdges_sum =
      input
      |> String.split("\n", trim: true)
      |> Enum.chunk_every(3)
      |> Enum.map(fn [elf1, elf2, elf3] ->
        elf1 = elf1 |> String.to_charlist() |> MapSet.new()
        elf2 = elf2 |> String.to_charlist() |> MapSet.new()
        elf3 = elf3 |> String.to_charlist() |> MapSet.new()

        priority_letter =
          elf1
          |> MapSet.intersection(elf2)
          |> MapSet.intersection(elf3)
          |> Enum.at(0)

        Map.get(@items_priority, priority_letter)
      end)
      |> Enum.sum()

    IO.puts("The badges sum is: #{bagdges_sum}")
  end
end

input = IO.read(:stdio, :all)

Day03.part_1(input)

Day03.part_2(input)
