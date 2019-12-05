package dev.brandonlmorris.advent.eighteen

import Day2._

import org.scalatest.FunSuite

class Day2Test extends FunSuite {

  test("testGetChecksum") {
    assert(getChecksum(Seq("abcdef")) == 0)
  }

  test("testGetChecksum2") {
    assert(getChecksum(Seq("babac")) == 1)
  }

  test("testCheckTwo") {
    assert(countTwo(Seq("babac")) == 1)
  }

  // Day 2 tests
  test("hammingDistTest") {
    assert(hammingDist("first", "firth") == 2)
  }

  test("findCorrectTest") {
    val boxes = Seq("first", "firsh")
    assert(findCorrectBoxes(boxes) == ("first", "firsh"))
  }

  test("indexOfDiffTest") {
    val (s1, s2) = ("first", "firsh")
    assert(indexOfDiff(s1, s2) == 4)
  }
}
