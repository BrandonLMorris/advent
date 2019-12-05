package dev.brandonlmorris.advent.eighteen

import scala.io.Source

object Util {
  def getInput(day: String): Seq[String] = {
    Source.fromResource(f"2018-$day.txt").getLines.toSeq
  }
}
