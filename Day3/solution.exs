%HTTPoison.Response{status_code: 200, body: body} =
  HTTPoison.get!("https://adventofcode.com/2022/day/3/input", %{},
    hackney: [cookie: [session_cookie]]
  )

defmodule CheckRuckSacks do

  def calculate_common_value(elves) do
    elves
    |> Enum.map(&MapSet.new(&1))
    |> Enum.reduce(fn sack, acc -> MapSet.intersection(sack,acc) end)
    |> Enum.at(0)
    |> String.to_charlist()
    |> Enum.at(0)
    |> calculate_priority
  end

  def calculate_sack_value({first, second}) do
    first_mapset = MapSet.new(first)
    second_mapset = MapSet.new(second)

    MapSet.intersection(first_mapset, second_mapset)
    |> Enum.at(0)
    |> String.to_charlist()
    |> Enum.at(0)
    |> calculate_priority
  end

  defp calculate_priority(letter) when letter >= 97, do: letter-96
  defp calculate_priority(letter), do: letter-38
end

part_1 = body
  |> String.split("\n", trim: true)
  |> Enum.map(fn sack -> String.split_at(sack, trunc(String.length(sack) / 2)) end)
  |> Enum.map(fn {first, second} ->
    {String.split(first, "", trim: true), String.split(second, "", trim: true)}
  end)
  |> Enum.map(&CheckRuckSacks.calculate_sack_value(&1))
  |> Enum.sum

part_2 = body
  |> String.split("\n", trim: true)
  |> Enum.map(fn sack -> String.split(sack,"", trim: true) |> MapSet.new()  end)
  |> Enum.chunk_every(3)
  |> Enum.map(&CheckRuckSacks.calculate_common_value(&1))
  |> Enum.sum
