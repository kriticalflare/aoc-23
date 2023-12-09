package com.kriticalflare.part1

import com.kriticalflare.readInput


val CardTypes: HashMap<Char, Int> = hashMapOf(
    'A' to 14, 'K' to 13, 'Q' to 12 , 'J' to 11,
    'T' to 10, '9' to 9, '8' to 8, '7' to 7,
    '6' to 6, '5' to 5 , '4' to 4, '3' to 3, '2' to 2
)

enum class HandType(val strength: Int) {
    FiveOfaKind(strength = 6), // where all five cards have the same label: AAAAA
    FourOfaKind(strength = 5), // where four cards have the same label and one card has a different label: AA8AA
    FullHouse(strength = 4), // where three cards have the same label, and the remaining two cards share a different label: 23332
    ThreeOfaKind(strength = 3), // where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
    TwoPair(strength = 2), //where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
    OnePair(strength = 1), // where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
    HighCard(strength = 0), // where all cards' labels are distinct: 23456
}

fun getCard(input: String): Hand {
    val bid = input.split(" ").last().toInt()
    val cards = input.split(" ").first().groupingBy { it }.eachCount()
    when (cards.keys.count()) {
        1 -> {
            return Hand(hand = input, kind = HandType.FiveOfaKind, bid)
        }

        2 -> {
            return if(cards.values.any{ it == 4}) {
                Hand(hand = input, kind = HandType.FourOfaKind, bid)
            } else {
                Hand(hand = input, kind = HandType.FullHouse, bid)
            }
        }

        3 -> {
            return if(cards.values.any{ it == 3}) {
                Hand(hand = input, kind = HandType.ThreeOfaKind, bid)
            } else {
                Hand(hand = input, kind = HandType.TwoPair, bid)
            }
        }

        4 -> {
            return Hand(hand = input, kind = HandType.OnePair, bid)
        }

        5 -> {
            return Hand(hand = input, kind = HandType.HighCard, bid)
        }

        else -> { throw Exception("illegal hand ${input.split(" ").first()}")}
    }
}

data class Hand(val hand: String, val kind: HandType, val bid: Int)


fun SolvePart1(input: String): Int{
   return readInput(input).map {
        getCard(it)
    }.sortedWith(comparator = Comparator { hand1, hand2 ->
        if (hand1.kind.strength != hand2.kind.strength) {
            return@Comparator hand1.kind.strength - hand2.kind.strength
        }
        val diff = hand1.hand.zip(hand2.hand).first { it.first != it.second }
        return@Comparator CardTypes[diff.first]!! - CardTypes[diff.second]!!
    }).foldIndexed(0) { idx, acc, curr ->
        acc + (idx + 1) * curr.bid
    }
}