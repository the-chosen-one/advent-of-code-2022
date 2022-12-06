%HTTPoison.Response{status_code: 200, body: body} =
  HTTPoison.get!("https://adventofcode.com/2022/day/4/input", %{},
    hackney: [cookie: [session_cookie]]
  )
defmodule CheckRanges do
  def check_two_subsets([first, second]) do
    first_map = parse_string_to_maps(first)
    second_map = parse_string_to_maps(second)

    MapSet.subset?(first_map, second_map) ||
    MapSet.subset?(second_map, first_map)
  end

  def check_two_intersects([first, second]) do
    first_map = parse_string_to_maps(first)
    second_map = parse_string_to_maps(second)
    overlaps = MapSet.intersection(first_map, second_map) |> MapSet.size

    overlaps > 0
  end

  defp parse_string_to_maps(pair) do
    [first_num, last_num] = pair
    |> String.split("-", trim: true)
    |> Enum.map(&String.to_integer(&1))

    MapSet.new(first_num..last_num)
  end
end

processed_input = body
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, ",", trim: true))

overlap_count = processed_input
|> Enum.map(&CheckRanges.check_two_subsets(&1))
|> Enum.count(&(&1))

intersection_count = processed_input
|> Enum.map(&CheckRanges.check_two_intersects(&1))
|> Enum.count(&(&1))
