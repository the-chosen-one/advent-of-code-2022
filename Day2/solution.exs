defmodule RockPaperScissors do
  def match1("A X"), do: 4
  def match1("A Y"), do: 8
  def match1("A Z"), do: 3
  def match1("B X"), do: 1
  def match1("B Y"), do: 5
  def match1("B Z"), do: 9
  def match1("C X"), do: 7
  def match1("C Y"), do: 2
  def match1("C Z"), do: 6
  def match1(_), do: 0

  def match2("A X"), do: 3
  def match2("A Y"), do: 4
  def match2("A Z"), do: 8
  def match2("B X"), do: 1
  def match2("B Y"), do: 5
  def match2("B Z"), do: 9
  def match2("C X"), do: 2
  def match2("C Y"), do: 6
  def match2("C Z"), do: 7
  def match2(_), do: 0
end

{:ok, input} = File.read("input.txt")

matchesList = String.split(input, "\n")
part1Total = matchesList
|> Enum.map(&RockPaperScissors.match1(&1))
|> Enum.sum()

part2Total = matchesList
|> Enum.map(&RockPaperScissors.match2(&1))
|> Enum.sum()

IO.puts "Part 1 total #{part1Total}"
IO.puts "Part 2 total #{part2Total}"
