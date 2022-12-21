defmodule Day05 do
  def part_1(input) do
    {stacks, commands} = parse_input(input)

    new_stacks =
      for {qty, from, to} <- commands,
          _times <- 1..qty,
          reduce: stacks do
        new_stacks ->
          {moving_item, new_stacks} =
            Map.get_and_update(new_stacks, from, fn [head | rest] ->
              {head, rest}
            end)

          Map.update(new_stacks, to, [], fn existing_stack ->
            [moving_item | existing_stack]
          end)
      end

    print_top_each_stack(new_stacks)
  end

  def part_2(input) do
    {stacks, commands} = parse_input(input)

    new_stacks =
      Enum.reduce(commands, stacks, fn {qty, from, to}, new_stacks ->
        {moving_items, new_stacks} =
          Map.get_and_update(new_stacks, from, fn stack ->
            moving_items = Enum.take(stack, qty)

            new_stack = Enum.drop(stack, qty)

            {moving_items, new_stack}
          end)

        Map.update(new_stacks, to, [], fn existing_stack ->
          moving_items ++ existing_stack
        end)
      end)

    print_top_each_stack(new_stacks)
  end

  defp parse_input(input) do
    [part_1, part2] = String.split(input, "\n\n")

    {stack_numbers, crates} =
      part_1
      |> String.split("\n")
      |> List.pop_at(-1)

    crates_parsed =
      crates
      |> Enum.map(fn str ->
        str
        |> String.replace(:binary.compile_pattern(["[", "]"]), "")
        |> String.split(:binary.compile_pattern([" ", "    "]))
      end)
      |> transpose()
      |> Enum.map(fn item ->
        Enum.reject(item, &Kernel.==(&1, ""))
      end)

    stack_parsed =
      stack_numbers
      |> String.split(" ", trim: true)
      |> Map.new(fn stack_number ->
        index = String.to_integer(stack_number)
        {stack_number, Enum.at(crates_parsed, index - 1)}
      end)

    commands =
      part2
      |> String.split("\n", trim: true)
      |> Enum.map(fn str ->
        [_rest, qty, from, to] = Regex.run(~r/^move (.+) from (.+) to (.+)$/, str)

        {String.to_integer(qty), from, to}
      end)

    {stack_parsed, commands}
  end

  defp transpose([[] | _]), do: []

  defp transpose(matrix) do
    [Enum.map(matrix, &hd/1) | transpose(Enum.map(matrix, &tl/1))]
  end

  defp print_top_each_stack(stacks) do
    top_of_each_stack =
      Enum.map_join(stacks, fn
        {_id, []} -> ""
        {_id, [head | _tail]} -> head
      end)

    IO.puts("The top of each stack is #{top_of_each_stack}.")
  end
end

input = IO.read(:stdio, :all)

Day05.part_1(input)
Day05.part_2(input)
