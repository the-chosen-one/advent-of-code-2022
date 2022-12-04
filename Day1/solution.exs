{:ok, body} = File.read("input.txt")
listOfCalories = body
|> String.split("\n\n")
|> Enum.map(fn calories ->
  String.split(calories)
  |> Enum.map(fn calorie -> String.to_integer(calorie) end)
  |> Enum.sum end)

maxCalories = Enum.max(listOfCalories)

sumOfTopThree = listOfCalories
|> Enum.sort(&(&1 >= &2))
|> Enum.take(3)
|> Enum.sum()

IO.puts "The Max is #{maxCalories} "
IO.puts "The Sum of top 3 is #{sumOfTopThree} "
