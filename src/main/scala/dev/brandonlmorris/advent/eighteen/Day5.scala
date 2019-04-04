package dev.brandonlmorris.advent.eighteen


object Day5 extends App {
  val input = Util.getInput("05")
  println(s"Part 1 solution: ${part1Solution(input)}")
  println(s"Part 2 solution: ${part2Solution(input)}")

  def part1Solution(polymer: Seq[String]): Int = {
    assert(polymer.size == 1)
    reduce(polymer.head.trim).length
  }

  def part2Solution(polymers: Seq[String]): Int = {
    assert(polymers.size == 1)
    val polymer = polymers.head.trim
    val lengths = for (c: Char <- polymer.toLowerCase.toSet) yield {
      val removed = polymer.replaceAll(c.toString, "").replaceAll(c.toUpper.toString, "")
      reduce(removed).length
    }
    lengths.min
  }

  def reduce(polymer: Seq[Char]): String = {
    @annotation.tailrec
    def reduceInner(polymer: Seq[Char], reducedSoFar: Seq[Char] = Seq()): String = {
      if (polymer.isEmpty)
        reducedSoFar.mkString
      else if (polymer.size < 2)
        (reducedSoFar :+ polymer.head).mkString
      else {
        val (first, second) = (polymer.head, polymer.tail.head)
        if (first != second && first.toLower == second.toLower) {
          // Activate the reaction
          val toReduce = polymer.tail.tail
          if (reducedSoFar.nonEmpty)
            // Back up a character in case this reaction unlocks another one
            reduceInner(reducedSoFar.last +: toReduce, reducedSoFar.init)
          else
            reduceInner(toReduce, reducedSoFar)
        } else
          // No reaction, move forward one
          reduceInner(polymer.tail, reducedSoFar :+ polymer.head)
      }
    }
    reduceInner(polymer)
  }
}
