package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

var rgbMap = map[string]int64{
	"red":   12,
	"green": 13,
	"blue":  14,
}

func part1(path string) (int, error) {
	file, err := os.Open(path)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	possibleGameSum := 0

	for scanner.Scan() {
		gameStr := scanner.Text()
		game := strings.Split(gameStr, ":")
		gameInfo := game[0]
		gameId, err := strconv.ParseInt(strings.Split(gameInfo, " ")[1], 10, 0)
		if err != nil {
			return 0, err
		}
		gameState := game[1]
		games := strings.Split(gameState, "; ")

		possible := true

		for _, g := range games {
			balls := strings.Split(g, ",")
			for _, ball := range balls {
				ballState := strings.Split(strings.Trim(ball, " "), " ")
				count, err := strconv.ParseInt(ballState[0], 10, 0)
				if err != nil {
					return 0, err
				}
				color := ballState[1]
				if rgbMap[color] < count {
					possible = false
				}
			}
		}
		if possible {
			possibleGameSum += int(gameId)
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return possibleGameSum, nil
}

func part2(path string) (int, error) {
	file, err := os.Open(path)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	possibleGameSum := 0

	for scanner.Scan() {
		gameStr := scanner.Text()
		game := strings.Split(gameStr, ":")
		gameState := game[1]
		games := strings.Split(gameState, "; ")
		rgbCountMap := make(map[string]int)

		power := 1
		for _, g := range games {
			balls := strings.Split(g, ",")
			for _, ball := range balls {
				ballState := strings.Split(strings.Trim(ball, " "), " ")
				count, err := strconv.ParseInt(ballState[0], 10, 0)
				if err != nil {
					return 0, err
				}
				color := ballState[1]
				if rgbCountMap[color] < int(count) {
					rgbCountMap[color] = int(count)
				}
			}
		}
		for _, v := range rgbCountMap {
			power = power * v
		}
		possibleGameSum += int(power)
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	return possibleGameSum, nil
}

func main() {
	output1, err := part1("part1.example.txt")
	if err != nil {
		fmt.Println(err.Error())
	}
	fmt.Printf("Part1 example: %v \n", output1)

	output2, err := part1("part1.txt")
	if err != nil {
		fmt.Println(err.Error())
	}
	fmt.Printf("Part1: %v \n", output2)

	output3, err := part2("part2.example.txt")
	if err != nil {
		fmt.Println(err.Error())
	}
	fmt.Printf("Part2 example: %v \n", output3)

	output4, err := part2("part2.txt")
	if err != nil {
		fmt.Println(err.Error())
	}
	fmt.Printf("Part2: %v \n", output4)
}
