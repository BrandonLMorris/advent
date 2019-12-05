package dev.brandonlmorris.advent.eighteen

import Day5._

import org.scalatest.FunSuite

class Day5Test extends FunSuite {
  val realInput: Seq[String] = Util.getInput("05")
  val sampleInput: String = "dabAcCaCBAcCcaDA"

  test("testPart1Solution") {
    assert(part1Solution(realInput) == 9390)
  }

  test("testPart2Solution") {
    assert(part2Solution(realInput) == 5898)
  }

  test("testSamplePart1") {
    assert(part1Solution(Seq(sampleInput)) == 10)
  }

  test("testReduce") {
    assert(reduce(sampleInput) == "dabCBAcaDA")
  }

}
