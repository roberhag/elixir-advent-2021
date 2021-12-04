defmodule Submarine do
    # Returns 1 if the first tail of the list is greater than the given head
    def tail_gt_head_int(head, [first_tail | _tail]) do
        if first_tail > head do
            1
        else
            0
        end
    end
    def tail_gt_head_int(_head, []) do
        0
    end


    # Recursively sum how many times the next element is greater than the first
    def sum_incr([head | tail], accumulator) do
        sum_incr(tail, accumulator + tail_gt_head_int(head, tail))
    end
    def sum_incr([], accumulator) do
        accumulator
    end
    def sum_incr(list) do
        sum_incr(list, 0)
    end
end

# Read file into list of integers
int_list = File.read!("input_01.txt") |> String.split("\n", trim: true) |> Enum.filter(fn(x) -> String.length(x) > 0 end) |> Enum.map(&String.to_integer/1)

# Part 1, count how many increments we have
int_list |> Submarine.sum_incr() |> IO.puts()

# Part 2, chunk a moving wihdow of size 3, sum the window before counting the increments
int_list |> Enum.chunk_every(3, 1, :discard) |> Enum.map(&Enum.sum/1) |> Submarine.sum_incr() |> IO.puts()
