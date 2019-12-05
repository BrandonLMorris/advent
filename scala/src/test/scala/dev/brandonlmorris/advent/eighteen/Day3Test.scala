package dev.brandonlmorris.advent.eighteen

import Day3._
import org.scalatest.FunSuite

class Day3Test extends FunSuite {
  val actualInput: Seq[String] = Util.getInput("03")

  // Part 1 tests
  test("testPart1") {
    // Solution to my input
    assert(part1(actualInput) == 117505)
  }

  test("testParseLine") {
    val input = "#1 @ 2,3: 4x5"
    val claim = parseLine(input)
    assert(claim.id == 1)
    assert(claim.col == 2)
    assert(claim.row == 3)
    assert(claim.width == 4)
    assert(claim.height == 5)
  }

  test("testParseLineMultiDigit") {
    val input = "#10 @ 20,30: 40x50"
    val claim = parseLine(input)
    assert(claim.id == 10)
    assert(claim.col == 20)
    assert(claim.row == 30)
    assert(claim.width == 40)
    assert(claim.height == 50)
  }

  test("testMarkClaim") {
    val board = Array(
      Array(0, 0, 0),
      Array(0, 0, 0),
      Array(0, 0, 0)
    )
    markClaim(board, Claim(7, 1, 0, 2, 3))
    val expectedBoard =  Array(
      Array(0, 7, 7),
      Array(0, 7, 7),
      Array(0, 7, 7)
    )
    board.zip(expectedBoard).foreach(x => assert(x._1 sameElements x._2))
  }

  test("testMarkClaim2") {
    val board = Array(
      Array(0, 0, 0),
      Array(0, 3, 3),
      Array(0, 3, 0)
    )
    markClaim(board, Claim(7, 1, 0, 2, 3))
    val expectedBoard =  Array(
      Array(0, 7, 7),
      Array(0, -1, -1),
      Array(0, -1, 7)
    )
    board.zip(expectedBoard).foreach(x => assert(x._1 sameElements x._2))
  }

  test("testCountDoubleClaimed") {
    val board =  Array(
      Array(0, 7, 7),
      Array(0, -1, -1),
      Array(0, -1, 7)
    )
    assert(countDoubleClaimed(board) == 3)
  }

  // Part 2 test
  test("testPart2") {
    // Solution to my input
    assert(part2(actualInput) == 1254)
  }

  test("testDidOverwrite") {
    val board = Array(
      Array(0, 7, 7),
      Array(0, -1, -1),
      Array(0, -1, 7)
    )
    assert(didOverwrite(board, Claim(7, 1, 0, 2, 3)))
  }
}
