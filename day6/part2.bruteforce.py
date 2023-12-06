def solve(input_path: str):
    with open(input_path, "r") as file:
        time_input = file.readline()
        time_input = time_input.split(":")[1]
        time = int("".join(time_input.split()))

        dist_input = file.readline()
        dist_input = dist_input.split(":")[1]
        target = int("".join(dist_input.split()))

        total_ways = 0
        for time_pressed in range(1, time):
            distance = time_pressed * (time - time_pressed)
            if distance > target:
                total_ways = total_ways + 1
    return total_ways


print(f"Part2 example  {solve('example.txt')}")

print(f"Part2 {solve('input.txt')}")
