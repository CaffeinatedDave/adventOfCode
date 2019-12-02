val input = "1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,19,5,23,1,23,5,27,2,27,10,31,1,31,9,35,1,35,5,39,1,6,39,43,2,9,43,47,1,5,47,51,2,6,51,55,1,5,55,59,2,10,59,63,1,63,6,67,2,67,6,71,2,10,71,75,1,6,75,79,2,79,9,83,1,83,5,87,1,87,9,91,1,91,9,95,1,10,95,99,1,99,13,103,2,6,103,107,1,107,5,111,1,6,111,115,1,9,115,119,1,119,9,123,2,123,10,127,1,6,127,131,2,131,13,135,1,13,135,139,1,9,139,143,1,9,143,147,1,147,13,151,1,151,9,155,1,155,13,159,1,6,159,163,1,13,163,167,1,2,167,171,1,171,13,0,99,2,0,14,0"


class ProgramAlarm1202(message: String) extends RuntimeException

def processCommand(memory: Array[Int], address: Int): Array[Int] = {
  val command = memory(address)
  val pos1 = memory(address + 1)
  val pos2 = memory(address + 2)
  val ansPos = memory(address + 3)

  command match {
    case 1 => {
      memory.updated(ansPos, memory(pos1) + memory(pos2))
    }
    case 2 => {
      memory.updated(ansPos, memory(pos1) * memory(pos2))
    }
    case _ => throw new ProgramAlarm1202("Boom.")
  }
}

// Yuck.
var pos = 0
var memory = input.split(",").map(_.toInt)

while (memory(pos) != 99) {
  memory = processCommand(memory, pos)
  pos += 4
}

println(s"${memory(0)}")

val desired = 19690720

for (noun <- 0 to 99) {
  for (verb <- 0 to 99) {
    var memory = input.split(",").map(_.toInt).updated(1, noun).updated(2, verb)
    var pos = 0

    while (memory(pos) != 99) {
      memory = processCommand(memory, pos)
      pos += 4
    }

    if (memory(0) == desired) {
      println(noun * 100 + verb)
    }
  }
}

