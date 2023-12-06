import math


def discriminant(a, b, c):
    return math.sqrt(math.pow(b, 2) - (4 * a * c))


def find_roots(a, b, c):
    discriminant = b**2 - 4 * a * c

    if discriminant > 0:
        root1 = (-b + math.sqrt(discriminant)) / (2 * a)
        root2 = (-b - math.sqrt(discriminant)) / (2 * a)
        return root1, root2
    elif discriminant == 0:
        root = -b / (2 * a)
        return (root,)
    else:
        real_part = -b / (2 * a)
        imag_part = math.sqrt(abs(discriminant)) / (2 * a)
        root1 = complex(real_part, imag_part)
        root2 = complex(real_part, -imag_part)
        return root1, root2


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
            (lo, hi) = find_roots(1, -1 * times[idx], target)

            ways = abs(math.floor(hi) - math.ceil(lo) + 1)
            total_ways = total_ways * ways
    return total_ways * -1


print(f"Part1 example  {solve('example.txt')}")

print(f"Part1 {solve('input.txt')}")
