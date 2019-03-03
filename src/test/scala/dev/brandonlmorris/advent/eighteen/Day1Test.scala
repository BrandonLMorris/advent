package dev.brandonlmorris.advent.eighteen

import Day1.{applyFrequencyChanges, findFirstDoubleFrequency}

class Day1Test extends org.scalatest.FunSuite {
  // Tests for part 1
  test("Summing across two numbers") {
    val freqs = Seq[String]("+1", "-1")
    assert(0 == applyFrequencyChanges(freqs))
  }

  test("All negative numbers") {
    val freqs = Seq("-1", "-10", "-100")
    assert(-111 == applyFrequencyChanges(freqs))
  }

  // Tests for part 2
  test("Simple zero twice") {
    val freqs: Seq[String] = "+1 -1" split " "
    assert(findFirstDoubleFrequency(freqs) == 0)
  }

  test("Slightly longer example; requires looping") {
    val freqs: Seq[String] = "+3 +3 +4 -2 -4" split " "
    assert(findFirstDoubleFrequency(freqs) == 10)
  }

  test("Another slightly longer example") {
    val freqs: Seq[String] = "-6, +3, +8, +5, -6" split ", "
    assert(findFirstDoubleFrequency(freqs) == 5)
  }

  test("Another another slightly longer example") {
    val freqs: Seq[String] = "+7, +7, -2, -7, -4" split ", "
    assert(findFirstDoubleFrequency(freqs) == 14)
  }
}
