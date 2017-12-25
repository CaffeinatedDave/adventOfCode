# Begin in state A.
# Perform a diagnostic checksum after 12861455 steps.
#
# In state A:
#   If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the right.
#     - Continue with state B.
#   If the current value is 1:
#     - Write the value 0.
#     - Move one slot to the left.
#     - Continue with state B.
#
# In state B:
#   If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the left.
#     - Continue with state C.
#   If the current value is 1:
#     - Write the value 0.
#     - Move one slot to the right.
#     - Continue with state E.
#
# In state C:
#   If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the right.
#     - Continue with state E.
#   If the current value is 1:
#     - Write the value 0.
#     - Move one slot to the left.
#     - Continue with state D.
#
# In state D:
#   If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the left.
#     - Continue with state A.
#   If the current value is 1:
#     - Write the value 1.
#     - Move one slot to the left.
#     - Continue with state A.
#
# In state E:
#   If the current value is 0:
#     - Write the value 0.
#     - Move one slot to the right.
#     - Continue with state A.
#   If the current value is 1:
#     - Write the value 0.
#     - Move one slot to the right.
#     - Continue with state F.
#
# In state F:
#   If the current value is 0:
#     - Write the value 1.
#     - Move one slot to the right.
#     - Continue with state E.
#   If the current value is 1:
#     - Write the value 1.
#     - Move one slot to the right.
#     - Continue with state A.


ptr = 0
state = :a

tape = Hash.new(0)

tape[ptr]

(1..12861455).each do |step|

  case state
    when :a
      if tape[ptr] == 0
        tape[ptr] = 1
        ptr += 1
        state = :b
      else
        tape[ptr] = 0
        ptr -= 1
        state = :b
      end
    when :b
      if tape[ptr] == 0
        tape[ptr] = 1
        ptr -= 1
        state = :c
      else
        tape[ptr] = 0
        ptr += 1
        state = :e
      end
    when :c
      if tape[ptr] == 0
        tape[ptr] = 1
        ptr += 1
        state = :e
      else
        tape[ptr] = 0
        ptr -= 1
        state = :d
      end
    when :d
      tape[ptr] = 1
      ptr -= 1
      state = :a
    when :e
      if tape[ptr] == 0
        ptr += 1
        state = :a
      else
        tape[ptr] = 0
        ptr += 1
        state = :f
      end
    when :f
      if tape[ptr] == 0
        tape[ptr] = 1
        ptr += 1
        state = :e
      else
        ptr += 1
        state = :a
      end
  end
end

answer = 0
tape.each do |k, v|
  answer += v
end

puts answer
