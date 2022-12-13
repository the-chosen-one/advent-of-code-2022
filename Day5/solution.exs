%HTTPoison.Response{status_code: 200, body: body} =
  HTTPoison.get!("https://adventofcode.com/2022/day/5/input", %{},
    hackney: [cookie: [session_cookie]]
  )

defmodule CraneMoveCalculator do
  def create_map(crane_list) do
    crane_map =
      crane_list
      |> Enum.at(8)
      |> String.split(" ", trim: true)
      |> Map.new(fn x -> {x, []} end)

    crane_list
    |> Enum.take(8)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&trim_crates(&1))
    |> Enum.reverse()
    |> Enum.map(&add_crates_to_map(crane_map, &1))
    |> Enum.reduce(crane_map, fn x, acc ->
      Map.merge(acc, x, fn _k, v1, v2 -> v1 ++ v2 end)
    end)
  end

  def move_crates(crate_map, count, start, finish) do
    take_integer = String.to_integer(count)
    reversed_final_crates = crate_map[start] |> Enum.take(-take_integer) |> Enum.reverse()

    crate_map
    |> Map.put(finish, crate_map[finish] ++ reversed_final_crates)
    |> Map.put(start, Enum.drop(crate_map[start], -take_integer))
  end

  def move_crates_v2(crate_map, 1, start, finish) do
    crate = crate_map[start] |> Enum.take(1)

    crate_map
    |> Map.put(finish, crate_map[finish] ++ crate)
    |> Map.put(start, Enum.drop(crate_map[start], -1))
  end

  def move_crates_v2(crate_map, count, start, finish) do
    take_integer = String.to_integer(count)
    final_crates = crate_map[start] |> Enum.take(-take_integer)

    crate_map
    |> Map.put(finish, crate_map[finish] ++ final_crates)
    |> Map.put(start, Enum.drop(crate_map[start], -take_integer))
  end

  defp trim_crates(crates) do
    {_, row} =
      crates
      |> Enum.reduce({0, []}, fn x, acc ->
        case {x, acc} do
          {"", {3, crates}} -> {0, crates ++ [x]}
          {"", {spaces, crates}} -> {spaces + 1, crates}
          {_, {spaces, crates}} -> {spaces, crates ++ [x]}
        end
      end)

    row
  end

  defp add_crates_to_map(crane_map, crates) do
    crates
    |> Enum.with_index()
    |> Enum.reduce(crane_map, fn {crate, idx}, acc ->
      idx_string = Integer.to_string(idx + 1)

      case crate do
        "" -> acc
        _ -> Map.put(acc, idx_string, acc[idx_string] ++ [crate])
      end
    end)
  end
end

{crane_data, moves} =
  body
  |> String.split("\n", trim: true)
  |> Enum.split(9)

crane_map =
  crane_data
  |> Enum.take(9)
  |> CraneMoveCalculator.create_map()

parsed_moves = Enum.map(moves, &String.split(&1, " "))

part_1_answer =
  parsed_moves
  |> Enum.reduce(crane_map, fn [_, count, _, start, _, finish], new_map ->
    CraneMoveCalculator.move_crates(new_map, count, start, finish)
  end)
  |> Enum.map(fn {_, v} ->
    Enum.at(v, -1)
  end)

part_2_answer =
  parsed_moves
  |> Enum.reduce(crane_map, fn [_, count, _, start, _, finish], new_map ->
    CraneMoveCalculator.move_crates_v2(new_map, count, start, finish)
  end)
  |> Enum.map(fn {_, v} ->
    Enum.at(v, -1)
  end)
