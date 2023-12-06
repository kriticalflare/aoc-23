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
        time = int("".join(time_input.split()))

        dist_input = file.readline()
        dist_input = dist_input.split(":")[1]
        target = int("".join(dist_input.split()))

        (lo, hi) = find_roots(1, -1 * time, target)
        ways = abs(math.floor(hi) - math.ceil(lo) + 1)
    return ways


print(f"Part2 example  {solve('example.txt')}")

print(f"Part2 {solve('input.txt')}")
