package dev.brandonlmorris.advent.eighteen

object Day1 extends App {
  val lines = Util.getInput("01")

  val part1Solution = applyFrequencyChanges(lines)
  println(s"Part 1 solution: $part1Solution")

  val part2Solution = findFirstDoubleFrequency(lines)
  println(s"Part 2 solution: $part2Solution")

  def applyFrequencyChanges(frequencies: Seq[String]): Int = {
    frequencies.map(_.toInt).sum
  }


  def findFirstDoubleFrequency(frequencies: Seq[String]): Int = {
    val freqStream = Stream.continually(frequencies.map(_.toInt)).flatten
    @annotation.tailrec
    def loop(currentFreq: Int, haveSeen: Set[Int], toSee: Seq[Int]): Int = {
      val current = currentFreq + toSee.head
      if (haveSeen contains current)
        current
      else
        loop(current, haveSeen + current, toSee.tail)
    }
    loop(0, Set[Int](0), freqStream)
  }
}

