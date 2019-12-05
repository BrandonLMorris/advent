package dev.brandonlmorris.advent.eighteen

object Day4 extends App {
  val input = Util.getInput("04")
  println(s"Part 1 solution: ${part1Solution(input)}")
  println(s"Part 2 solution: ${part2Solution(input)}")

  def part1Solution(input: Seq[String]): Int = {
    val shifts: Map[Date, Int] = input flatMap parseShift toMap
    val naps = collapseNaps(input.flatMap(parseNap(_, shifts)))
    val sleepyGuard = sleepiestGuard(naps)
    val sleepyMin = sleepiestMin(naps.filter(_.gid == sleepyGuard))
    sleepyGuard * sleepyMin
  }

  def part2Solution(input: Seq[String]): Int = {
    val shifts: Map[Date, Int] = input flatMap parseShift toMap
    val naps = collapseNaps(input.flatMap(parseNap(_, shifts)))
    val napsByGuard = naps.groupBy(_.gid)
    val guardMinuteCounts = napsByGuard.map(g => (g._1 -> minuteCounts(g._2)))
    val maxGuard = guardMinuteCounts.reduceLeft((g1, g2) => if (g1._2.max > g2._2.max) g1 else g2)
    val sleepiestMin = maxGuard._2.zipWithIndex.max._2
    maxGuard._1 * sleepiestMin
  }

  case class Date(month: Int, day: Int)
  case class Shift(gid: Int, date: Date)
  case class Nap(date: Date, gid: Int, start: Int, end: Int)

  // Find the guard who has slept the most minutes
  def sleepiestGuard(naps: Seq[Nap]): Int = {
    @annotation.tailrec
    def loop(naps: Seq[Nap], guardToSleep: Map[Int, Int]): Map[Int, Int] = {
      if (naps.isEmpty)
        guardToSleep
      else {
        val nap = naps.head
        val sleep = nap.end - nap.start
        loop(naps.tail, guardToSleep + (nap.gid -> (guardToSleep.getOrElse(nap.gid, 0) + sleep)))
      }
    }
    val guardsToSleep = loop(naps, Map())
    val sleepiest = guardsToSleep.maxBy(_._2)
    sleepiest._1
  }

  def minuteCounts(naps: Seq[Nap]): IndexedSeq[Int] = {
    val counts = Vector.fill(60)(0)
    @annotation.tailrec
    def loop(naps: Seq[Nap], c: IndexedSeq[Int]): IndexedSeq[Int] = {
      if (naps.isEmpty)
        c
      else {
        val nap = naps.head
        val incremented = for (idx <- c.indices) yield {
          if (idx >= nap.start && idx < nap.end) c(idx) + 1 else c(idx)
        }
        loop(naps.tail, incremented)
      }
    }
    loop(naps, counts)
  }

  def sleepiestMin(naps: Seq[Nap]): Int = {
    minuteCounts(naps).zipWithIndex.maxBy(_._1)._2
  }

  def parseShift(l: String): Option[(Date, Int)] = {
    if (l contains "Guard") {
      // Example line: [1518-03-19 00:02] Guard #647 begins shift
      val pattern = raw"\[\d*-(\d*)-(\d*) (\d*):\d\d\].*#(\d*).*".r
      // Edge case: If shift started before midnight, need to bump up day. If last day of month, need to reset day/month
      l match {
        case pattern(m, d, h, g) => {
          val (month, day, hour, gid) = (m.toInt, d.toInt, h.toInt, g.toInt)
          if (hour != 0) {
            if ((day == 31 && List(1, 3, 5, 7, 8, 10).contains(month)) ||
                (day == 30 && List(4, 6, 9, 11).contains(month)) ||
                (day == 28 && month == 2)) {
              // Need to reset day, add month
              Some((Date(month+1, 1), gid))
            } else {
              Some((Date(month, day + 1), gid)) // Just bump day
            }
          } else {
            Some((Date(month, day), gid))
          }
        }
        case _ => throw new RuntimeException(s"Couldn't match shift pattern: $l")
      }
    } else None
  }

  def parseNap(l: String, shifts: Map[Date, Int]): Option[Nap] = {
    // Example line: [1518-11-04 00:24] falls asleep
    if (!l.contains("Guard")) {
      val pattern = raw"\[\d*-(\d*)-(\d*) \d*:(\d*)\] (.*)".r
      l match {
        case pattern(m, d, min, txt) => {
          val date = Date(m.toInt, d.toInt)
          val gid = shifts(date)
          if (txt.contains("wakes"))
            Some(Nap(date, gid, -1, min.toInt))
          else
            Some(Nap(date, gid, min.toInt, -1))
        }
      }
    } else None
  }

  def collapseNaps(naps: Seq[Nap]): Seq[Nap] = {
    (for (dateToNap <- naps.groupBy(_.date)) yield {
      val allNaps = dateToNap._2.sortBy(n => Math.max(n.start, n.end))
      (for (napPair <- allNaps.grouped(2)) yield {
        val start = napPair.filter(_.start != -1).head.start
        val end = napPair.filter(_.end != -1).head.end
        val n = napPair.head
        Nap(n.date, n.gid, start, end)
      }).toSeq
    }).toSeq.flatten
  }
}
