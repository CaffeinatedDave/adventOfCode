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

    both = selected + b_selected
    both.reverse!

    selected = both[0,selected.length]
    b_selected = both[selected.length, b_selected.length]

    list = b_selected + before
    list += selected
    list += after

    ptr = (ptr + len + skip) % list.length
    skip += 1
  end
  return list
end

input = "nbysizxe"

list = *(0..255)
range = *(0..127)

ones = 0
zeroes = 0

grid = []

range.each do |x|
  str = "#{input}-#{x}"
  instructions = (str.split('').map{|x| x.ord} + [17, 31, 73, 47, 23]) * 64

  result = knot(list, instructions)
  start = {}
  start.default = 0

  result.each_with_index do |x, i|
    start[(i / 16)] ^= x.ord
  end
  bin = ""
  start.each do |k, v|
    bin += "#{v.to_s(2).rjust(8, '0')}"
  end

  ones += bin.scan('1').length
  zeroes += bin.scan('0').length

  grid[x] = bin.split('')
end

puts "There are #{ones} ones and #{zeroes} zeroes"

regions = 0
continue = true

grid.each_with_index do |p, i|
  puts "#{i}: #{p.join}"
end

totalNumber = 0
while continue
  continue = false
  fx = 0
  fy = 0

  found = false # quick short circuit

  grid.each_with_index do |gx, x|
    next if found
    gx.each_with_index do |gy, y|
      next if found
      if gy == "1"
        fx = x
        fy = y
        continue = true
        found = true
      end
    end
  end

  if continue
    queue = []
    queue << {x: fx, y: fy}
    puts "1 at #{fx},#{fy}"

    number = 1
    while queue.length > 0
      looking = queue[0]
      queue = queue[1, queue.length-1]

      x = looking[:x]
      y = looking[:y]
      grid[x][y] = '0'

      if (x < 127 and grid[x+1][y]) == '1'
        puts "1 at #{x+1},#{y}"
        queue << {x: x+1, y: y}
        grid[x+1][y] = '0'
        number += 1
      end
      if (x > 0 and grid[x-1][y]) == '1'
        puts "1 at #{x-1},#{y}"
        queue << {x: x-1, y: y}
        grid[x-1][y] = '0'
        number += 1
      end
      if (y < 127 and grid[x][y+1]) == '1'
        puts "1 at #{x},#{y+1}"
        queue << {x: x, y: y+1}
        grid[x][y+1] = '0'
        number += 1
      end
      if (y > 0 and grid[x][y-1]) == '1'
        puts "1 at #{x},#{y-1}"
        queue << {x: x, y: y-1}
        grid[x][y-1] = '0'
        number += 1
      end
    end
    regions += 1
    puts " Number of ones in region #{regions}: #{number}"
    totalNumber += number
  end
end

puts regions

puts totalNumber
