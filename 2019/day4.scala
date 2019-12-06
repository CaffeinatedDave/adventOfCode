case class ValidFold(containsDouble: Boolean = false, isRising: Boolean = true)

def isValid(x: Int): Boolean = {
  val result = x.toString.split("").foldLeft((ValidFold(), 0))((f, x) => {
    (ValidFold(f._1.containsDouble || f._2 == x.toInt, f._1.isRising && f._2 <= x.toInt), x.toInt)
  })
  result._1.containsDouble && result._1.isRising
}

def isValid2(x: Int): Boolean = {
  x.toString.groupBy(identity).mapValues(_.length).exists(x => x._2 == 2)
}

val ans1 = (256310 to 732736).filter(isValid)

ans1.length

val ans2 = ans1.filter(isValid2)

ans2.length



