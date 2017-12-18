input = "set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 952
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19"

instructions = input.split("\n")

lastPlayed = -1
store = {}
store.default = 0
ptr = 0

def getValFor(val, store)
  if val.to_i == 0
    return store[val].to_i
  else
    return val.to_i
  end
end

while true
  i = instructions[ptr]
  todo = i.split("\s")

  nextCmd = 1

  case todo[0]
    when 'snd'
      lastPlayed = getValFor(todo[1], store)
    when 'set'
      store[todo[1]] = getValFor(todo[2], store)
    when 'add'
      store[todo[1]] += getValFor(todo[2], store)
    when 'mul'
      store[todo[1]] *= getValFor(todo[2], store)
    when 'mod'
      store[todo[1]] %= getValFor(todo[2], store)
    when 'rcv'
      if store[todo[1]] != 0
        puts "Sound played is #{lastPlayed}"
        break
      end
    when 'jgz'
      if getValFor(todo[1], store) > 0
        nextCmd = todo[2].to_i
      end
  end

  ptr += nextCmd
end

storeA = {}
storeA.default = 0

queueA = []
queueATotal = 0

storeB = {}
storeB["p"] = 1
storeB.default = 0

queueB = []

ptrA = 0
ptrB = 0

cpu = 0

while true
  iA = instructions[ptrA]
  todoA = iA.split("\s")
  iB = instructions[ptrB]
  todoB = iB.split("\s")

  nextCmdA = 1
  nextCmdB = 1

  case todoA[0]
    when 'snd'
      queueB << getValFor(todoA[1], storeA)
    when 'set'
      storeA[todoA[1]] = getValFor(todoA[2], storeA)
    when 'add'
      storeA[todoA[1]] += getValFor(todoA[2], storeA)
    when 'mul'
      storeA[todoA[1]] *= getValFor(todoA[2], storeA)
    when 'mod'
      storeA[todoA[1]] %= getValFor(todoA[2], storeA)
    when 'rcv'
      if !queueA.empty?
        storeA[todoA[1]] = queueA.take(1)[0]
        queueA = queueA.drop(1)
      else
        nextCmdA = 0
      end
    when 'jgz'
      if getValFor(todoA[1], storeA) > 0
        nextCmdA = getValFor(todoA[2], storeA)
      end
  end

  case todoB[0]
    when 'snd'
      queueA << getValFor(todoB[1], storeB)
      queueATotal += 1
    when 'set'
      storeB[todoB[1]] = getValFor(todoB[2], storeB)
    when 'add'
      storeB[todoB[1]] += getValFor(todoB[2], storeB)
    when 'mul'
      storeB[todoB[1]] *= getValFor(todoB[2], storeB)
    when 'mod'
      storeB[todoB[1]] %= getValFor(todoB[2], storeB)
    when 'rcv'
      if !queueB.empty?
        storeB[todoB[1]] = queueB.take(1)[0]
        queueB = queueB.drop(1)
      else
        nextCmdB = 0
      end
    when 'jgz'
      if getValFor(todoB[1], storeB) > 0
        nextCmdB = getValFor(todoB[2], storeB)
      end
  end

  puts "#{cpu}> #{ptrA}: #{todoA.join(" ")} -- #{ptrB}: #{todoB.join(" ")}"
  puts storeA.to_s + " :: " + storeB.to_s
  puts "#{queueA.length.to_s.rjust(6, '0')} :: #{queueB.length.to_s.rjust(6, '0')} ++ #{queueATotal}"
  puts ""

  cpu += 1
  ptrA += nextCmdA
  ptrB += nextCmdB

  if nextCmdA == 0 and nextCmdB == 0
    break
  end

end


puts "Ended after program 1 sent #{queueATotal} items"
