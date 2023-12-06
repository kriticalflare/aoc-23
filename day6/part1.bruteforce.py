def solve(input_path: str):
    with open(input_path, "r") as file:
        time_input = file.readline()
        time_input = time_input.split(":")[1]
        time_input = time_input.split()
        times = list(map(lambda time: int(time), time_input))

        dist_input = file.readline()
        dist_input = dist_input.split(":")[1]
        dist_input = dist_input.split()
        distances = list(map(lambda dist: int(dist), dist_input))

        total_ways = -1
        for idx, target in enumerate(distances):
            ways = 0
            for time_pressed in range(1, times[idx]):
                distance = time_pressed * (times[idx] - time_pressed)
                if distance > target:
                    ways = ways + 1
            total_ways = total_ways * ways
    return total_ways * -1


print(f"Part1 example  {solve('example.txt')}")

print(f"Part1 {solve('input.txt')}")
