def knot(list, instructions)
  skip = 0
  ptr = 0

  instructions.each do |len|

    before = list[0,ptr]
    b_selected = []

    selected = list[ptr, len]
    b_selected = []
    after = list[ptr+len, list.length]

    if (ptr + len > list.length)
      before_len = ((ptr+len)%list.length)
      b_selected = before[0, before_len]
      before = before[before_len, list.length]
      after = []
    end

    if b_selected.nil?
      b_selected = []
    end

    if before.nil?
      before = []
    end

    both = selected + b_selected
    both.reverse!

    selected = both[0,selected.length]
    b_selected = both[selected.length, b_selected.length]

    if b_selected.nil?
      b_selected = []
    end

    list = b_selected + before
    list += selected
    list += after

    ptr = (ptr + len + skip) % list.length
    skip += 1
  end
  return list
end

input = "70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41"

list1 = *(0..255)
part1 = knot(list1, input.split(',').map{|x| x.to_i})
puts "Part 1: #{part1}"
puts "Answer: #{part1[0] * part1[1]}"
puts ""

instructions = (input.split('').map{|x| x.ord} + [17, 31, 73, 47, 23]) * 64

list2 = *(0..255)
part2 = knot(list2, instructions)

start = {}
start.default = 0

part2.each_with_index do |x, i|
  start[(i / 16)] ^= x.ord
end

puts "Part2: #{part2}"
start.each do |k, v|
  print "#{(v/16).to_s(16)}#{(v%16).to_s(16)}"
end
