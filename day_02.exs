defmodule Submarine do
    # Recursively do the list of commands, passing on the position and depth
    def do_commands([head | tail], pos, depth) do
        [command, number] = String.split(head, " ") 
        number = String.to_integer(number)
        case command do
            "forward" ->
                do_commands(tail, pos + number, depth)
            "down" ->
                do_commands(tail, pos, depth + number)
            "up" ->
                do_commands(tail, pos, depth - number)
        end
    end
    def do_commands([], pos, depth) do
        {pos, depth}
    end

    # For part 2, now up/down change the aim, while forward changes both pos and depth
    def do_aim_commands([head | tail], pos, depth, aim) do
        [command, number] = String.split(head, " ") 
        number = String.to_integer(number)
        case command do
            "forward" ->
                do_aim_commands(tail, pos + number, depth + (aim * number), aim)
            "down" ->
                do_aim_commands(tail, pos, depth, aim + number)
            "up" ->
                do_aim_commands(tail, pos, depth, aim - number)
        end
    end
    def do_aim_commands([], pos, depth, _aim) do
        {pos, depth}
    end
end

# Read file into list of commands
com_list = File.read!("input_02.txt") |> String.split("\n", trim: true) |> Enum.filter(fn(x) -> String.length(x) > 0 end)

Submarine.do_commands(com_list, 0, 0) |> Tuple.product |> IO.puts()

Submarine.do_aim_commands(com_list, 0, 0, 0) |> Tuple.product |> IO.puts()
