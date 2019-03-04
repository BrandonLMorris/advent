package dev.brandonlmorris.advent.eighteen

import scala.io.Source

object Day2 extends App {
  val filename = "2018-02.txt"
  val lines = Source.fromResource(filename).getLines.toSeq

  val part1Sol = getChecksum(lines)
  val part2Sol = part2Solution(lines)
  println(s"Solution to part 1: $part1Sol")
  println(s"Solution to part 2: $part2Sol")

  def getChecksum(lines: Seq[String]): Int = countTwo(lines) * countThree(lines)

  def exactlyN(n: Int, s: String): Boolean = {
    s.groupBy(identity).mapValues(_.size).valuesIterator.contains(n)
  }

  def countN(n: Int)(boxIds: Seq[String]) = boxIds.map(exactlyN(2, _)).count(identity)
  def countTwo: Seq[String] => Int = countN(2)
  def countThree: Seq[String] => Int =countN(3)

  def hammingDist(s1: String, s2: String): Int = {
    assert(s1.length == s2.length, "Strings not the same size")
    s1.length - s1.zip(s2).map(x => x._1 == x._2).count(identity)
  }

  def findCorrectBoxes(boxIds: Seq[String]): (String, String) = {
    val cross = for (first <- boxIds; second <- boxIds) yield (first, second)
    val correct = cross.filter(x => hammingDist(x._1, x._2) == 1)
    assert(correct.size == 2, s"Too many 'correct' boxes were found: ${correct}")
    correct.head
  }

  def indexOfDiff(s1: String, s2: String): Int = {
    assert(s1.length == s2.length, "Strings of different length")
    s1.zip(s2).map(x => x._1 == x._2).indexOf(false)
  }

  def cutOutDiff(s: String, diffIdx: Int): String = s.slice(0, diffIdx) + s.slice(diffIdx + 1, s.length())

  def part2Solution(lines: Seq[String]): String = {
    val (box1, box2) = findCorrectBoxes(lines)
    val diffIdx = indexOfDiff(box1, box2)
    cutOutDiff(box1, diffIdx)
  }
}
