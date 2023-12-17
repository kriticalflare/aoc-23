package com.kriticalflare;


//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        System.out.printf("Part1 example1 %d\n",Part1.solve("./src/input/example.txt"));
        System.out.printf("Part1 example2 %d\n",Part1.solve("./src/input/example2.txt"));
        System.out.printf("Part1 input %d\n",Part1.solve("./src/input/input.txt"));
        System.out.printf("Part2 example1 %d\n",Part2.solve("./src/input/example.part2.txt"));
        System.out.printf("Part2 input %d\n",Part2.solve("./src/input/input.txt"));
    }
}