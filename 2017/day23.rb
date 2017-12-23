input = "set b 65
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set f 1
set d 2
set e 2
set g d
mul g e
sub g b
jnz g 2
set f 0
sub e -1
set g e
sub g b
jnz g -8
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23"

instructions = input.split("\n")

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

mulCount = 0
while !instructions[ptr].nil?
  i = instructions[ptr]
  todo = i.split("\s")

  nextCmd = 1

  case todo[0]
    when 'set'
      store[todo[1]] = getValFor(todo[2], store)
    when 'sub'
      store[todo[1]] -= getValFor(todo[2], store)
    when 'mul'
      store[todo[1]] *= getValFor(todo[2], store)
      mulCount += 1
    when 'jnz'
      if getValFor(todo[1], store) != 0
        nextCmd = todo[2].to_i
      end
  end

  ptr += nextCmd
end

puts "Multiplied #{mulCount} times"

# This won't finish within a reasonable time...
store = {}
store.default = 0
store["a"] = 1
ptr = 0

def getValFor(val, store)
  if val.to_i == 0
    return store[val].to_i
  else
    return val.to_i
  end
end

while !instructions[ptr].nil?
  i = instructions[ptr]
  todo = i.split("\s")

  nextCmd = 1

  case todo[0]
    when 'set'
      store[todo[1]] = getValFor(todo[2], store)
    when 'sub'
      store[todo[1]] -= getValFor(todo[2], store)
    when 'mul'
      store[todo[1]] *= getValFor(todo[2], store)
    when 'jnz'
      if getValFor(todo[1], store) != 0
        nextCmd = todo[2].to_i
      end
  end

  if todo[1] == 'h'
    puts "H is #{store["h"]}"
  end

  ptr += nextCmd
end

puts "H is #{store["h"]}"
