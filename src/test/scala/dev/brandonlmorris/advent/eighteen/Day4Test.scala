package dev.brandonlmorris.advent.eighteen

import org.scalatest.FunSuite

import Day4._

class Day4Test extends FunSuite {
  val actualInput: Seq[String] = Util.getInput("04")
  val sampleInput: Seq[String] =
    """[1518-11-01 00:00] Guard #10 begins shift
      |[1518-11-01 00:05] falls asleep
      |[1518-11-01 00:25] wakes up
      |[1518-11-01 00:30] falls asleep
      |[1518-11-01 00:55] wakes up
      |[1518-11-01 23:58] Guard #99 begins shift
      |[1518-11-02 00:40] falls asleep
      |[1518-11-02 00:50] wakes up
      |[1518-11-03 00:05] Guard #10 begins shift
      |[1518-11-03 00:24] falls asleep
      |[1518-11-03 00:29] wakes up
      |[1518-11-04 00:02] Guard #99 begins shift
      |[1518-11-04 00:36] falls asleep
      |[1518-11-04 00:46] wakes up
      |[1518-11-05 00:03] Guard #99 begins shift
      |[1518-11-05 00:45] falls asleep
      |[1518-11-05 00:55] wakes up""".stripMargin.split('\n')

  test("testPart1Solution") {
    // The actual answer to my specific input
    assert(part1Solution(actualInput) == 8421)
  }

  test("testPart2Solution") {
    assert(part2Solution(actualInput) == 83359)
  }

  test("testParseNap") {
    val str = "[1518-09-24 00:30] falls asleep"
    val date = Date(9, 24)
    val nap = parseNap(str, Map(date -> 0)).get
    assert(nap == Nap(date, 0, 30, -1))
  }

  test("testParseNap2") {
    val str = "[1518-09-24 00:30] wakes up"
    val date = Date(9, 24)
    val nap = parseNap(str, Map(date -> 0)).get
    assert(nap == Nap(date, 0, -1, 30))
  }

  test("testSleepiestMin") {
    val date = Date(9, 24)
    val naps = List(Nap(date, 0, 15, 45), Nap(date, 0, 45, 60), Nap(date, 0, 10, 16), Nap(date, 0, 0, 16))
    assert(sleepiestMin(naps) == 15)
  }

  test("testParseShift") {
    val str = "[1518-03-19 00:02] Guard #647 begins shift"
    val (date, gid) = parseShift(str).get
    assert(date == Date(3, 19))
    assert(gid == 647)
  }

  test("testParseShiftHourShift") {
    val str = "[1518-03-19 23:58] Guard #647 begins shift"
    val (date, gid) = parseShift(str).get
    assert(date == Date(3, 20))
    assert(gid == 647)
  }

  test("testParseShiftMonthShift") {
    val str = "[1518-03-31 23:58] Guard #647 begins shift"
    val (date, gid) = parseShift(str).get
    assert(date == Date(4, 1))
    assert(gid == 647)
  }

  test("testSleepiestGuard") {
    val date = Date(9, 13)
    val naps = List(Nap(date, 0, 0, 10), Nap(date, 1, 0, 20), Nap(date, 2, 0, 60), Nap(date, 1, 0, 10))
    assert(sleepiestGuard(naps) == 2)
  }

  test("testCollapseNaps") {
    val date1 = Date(9, 13)
    val date2 = Date(2, 22)
    val naps = List(Nap(date1, 0, -1, 30), Nap(date2, 0, 23, -1), Nap(date1, 0, 14, -1), Nap(date2, 0, -1, 25))
    val expected = List(Nap(date1, 0, 14, 30), Nap(date2, 0, 23, 25))
    assert(collapseNaps(naps).toSet == expected.toSet)
  }

  test("part1Sample") {
    assert(part1Solution(sampleInput) == 240)
  }
}
