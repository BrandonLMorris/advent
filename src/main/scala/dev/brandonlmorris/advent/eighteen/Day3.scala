package dev.brandonlmorris.advent.eighteen

import scala.io.Source

object Day3 extends App {
  val filename = "2018-03.txt"
  val lines = Source.fromResource(filename).getLines.toSeq

  val part1Solution = part1(lines)
  println(s"Solution to part 1: $part1Solution")
  val part2Solution = part2(lines)
  println(s"Solution to part 2: $part2Solution")

  def part1(input: Seq[String]): Int = {
    val board = markBoard(input)
    countDoubleClaimed(board)
  }

  def part2(input: Seq[String]): Int = {
    val board = markBoard(input)
    val claims = input.map(parseLine)
    val overwrites = claims.map(didOverwrite(board, _))
    assert(overwrites.count(_ == false) == 1) // Should only be one claim that doesn't overlap
    claims(overwrites.indexOf(false)).id
  }

  def markBoard(input: Seq[String]): Array[Array[Int]] = {
    val board = Array.ofDim[Int](1000, 1000)
    val claims = input.map(parseLine)
    claims.foreach(markClaim(board, _))
    board
  }

  case class Claim(id: Int, col: Int, row: Int, width: Int, height: Int)

  def parseLine(line: String): Claim = {
    val linePattern = raw"#(\d*) @ (\d*),(\d*): (\d*)x(\d*)".r
    line match {
      case linePattern(i, c, r, w, h) => Claim(i.toInt, c.toInt, r.toInt, w.toInt, h.toInt)
      case _ => throw new IllegalArgumentException(s"Invalid line format: $line")
    }
  }

  /**
    * Overrite postitions claimed on the board with the claim's id. If that position is already claimed,
    * mark with -1
    * @param board
    * @param claim
    */
  def markClaim(board: Array[Array[Int]], claim: Claim): Unit = {
    for (row <- claim.row until claim.row + claim.height;
         col <- claim.col until claim.col + claim.width) {
      board(row)(col) = if (board(row)(col) == 0) claim.id else -1
    }
  }

  def didOverwrite(board: Array[Array[Int]], claim: Claim): Boolean = {
    val overwrites = for (row <- claim.row until claim.row + claim.height;
                           col <- claim.col until claim.col + claim.width) yield {
     board(row)(col) == -1
    }
    overwrites.max
  }

  def countDoubleClaimed(board: Array[Array[Int]]): Int = board.flatten.count(_ == -1)
}

