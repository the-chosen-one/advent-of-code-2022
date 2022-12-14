
%HTTPoison.Response{status_code: 200, body: body} =
  HTTPoison.get!("https://adventofcode.com/2022/day/6/input", %{},
    hackney: [cookie: [session_cookie]]
  )

defmodule PacketProcessor do
  def detect_marker(window) when length(window) == 4 do
    unique_characters = Enum.uniq(window) |> Enum.count()
    unique_characters == 4
  end
  def detect_marker(window) when length(window) > 4 do
    most_recent_four = Enum.take(window, -4)
    detect_marker(most_recent_four)
  end
  def detect_marker(_), do: false

  def detect_marker_v2(window) when length(window) == 14 do
    unique_characters = Enum.uniq(window) |> Enum.count()
    unique_characters == 14
  end
  def detect_marker_v2(window) when length(window) > 14 do
    most_recent_four = Enum.take(window, -14)
    detect_marker_v2(most_recent_four)
  end
  def detect_marker_v2(_), do: false

end

%{ chars_read: chars_read_part_1 } = body
|> String.split("", trim: true)
|> Enum.reduce_while(%{ window: [], chars_read: [] }, fn x, %{ window: current_window, chars_read: old_chars } ->
  case PacketProcessor.detect_marker(current_window ++ [x]) do
    true  -> {:halt, %{ window: current_window, chars_read: old_chars ++ [x] } }
    false -> {:cont, %{ window: current_window ++ [x], chars_read: old_chars ++ [x] }}
  end
end)

part_1 = Enum.count(chars_read_part_1)

%{ chars_read: chars_read_part_2 } = body
|> String.split("", trim: true)
|> Enum.reduce_while(%{ window: [], chars_read: [] }, fn x, %{ window: current_window, chars_read: old_chars } ->
  case PacketProcessor.detect_marker_v2(current_window ++ [x]) do
    true  -> {:halt, %{ window: current_window, chars_read: old_chars ++ [x] } }
    false -> {:cont, %{ window: current_window ++ [x], chars_read: old_chars ++ [x] }}
  end
end)

part_2 = Enum.count(chars_read_part_2)
