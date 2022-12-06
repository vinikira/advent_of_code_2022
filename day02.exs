defmodule Day02.Part1 do
  @rock_score 1
  @paper_score 2
  @scissors_score 3

  @loss_score 0
  @draw_score 3
  @win_score 6

  @rock ~w(A X)
  @paper ~w(B Y)
  @scissors ~w(C Z)

  def run(input) do
    total_score =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn item ->
        [opponent_move, your_move] = String.split(item, " ")

        process_round(opponent_move, your_move)
      end)
      |> Enum.sum()

    IO.puts("Your total score will be: #{total_score}")
  end

  defp process_round(opponent_move, your_move)
       when your_move in @rock and opponent_move in @scissors,
       do: @rock_score + @win_score

  defp process_round(opponent_move, your_move)
       when your_move in @rock and opponent_move in @rock,
       do: @rock_score + @draw_score

  defp process_round(opponent_move, your_move)
       when your_move in @rock and opponent_move in @paper,
       do: @rock_score + @loss_score

  defp process_round(opponent_move, your_move)
       when your_move in @paper and opponent_move in @rock,
       do: @paper_score + @win_score

  defp process_round(opponent_move, your_move)
       when your_move in @paper and opponent_move in @paper,
       do: @paper_score + @draw_score

  defp process_round(opponent_move, your_move)
       when your_move in @paper and opponent_move in @scissors,
       do: @paper_score + @loss_score

  defp process_round(opponent_move, your_move)
       when your_move in @scissors and opponent_move in @paper,
       do: @scissors_score + @win_score

  defp process_round(opponent_move, your_move)
       when your_move in @scissors and opponent_move in @scissors,
       do: @scissors_score + @draw_score

  defp process_round(opponent_move, your_move)
       when your_move in @scissors and opponent_move in @rock,
       do: @scissors_score + @loss_score
end

defmodule Day02.Part2 do
  @rock_score 1
  @paper_score 2
  @scissors_score 3

  @loss_score 0
  @draw_score 3
  @win_score 6

  @rock "A"
  @paper "B"
  @scissors "C"

  @need_to_win "Z"
  @need_to_loss "X"
  @need_to_draw "Y"

  def run(input) do
    total_score =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn item ->
        [opponent_move, how_round_need_end] = String.split(item, " ")

        process_round(opponent_move, how_round_need_end)
      end)
      |> Enum.sum()

    IO.puts("Your total score will be: #{total_score}")
  end

  defp process_round(@rock, @need_to_win), do: @paper_score + @win_score
  defp process_round(@rock, @need_to_loss), do: @scissors_score + @loss_score
  defp process_round(@rock, @need_to_draw), do: @rock_score + @draw_score

  defp process_round(@paper, @need_to_win), do: @scissors_score + @win_score
  defp process_round(@paper, @need_to_loss), do: @rock_score + @loss_score
  defp process_round(@paper, @need_to_draw), do: @paper_score + @draw_score

  defp process_round(@scissors, @need_to_win), do: @rock_score + @win_score
  defp process_round(@scissors, @need_to_loss), do: @paper_score + @loss_score
  defp process_round(@scissors, @need_to_draw), do: @scissors_score + @draw_score
end

input = IO.read(:stdio, :all)

Day02.Part1.run(input)

Day02.Part2.run(input)
