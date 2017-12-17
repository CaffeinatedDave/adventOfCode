cycle = 386

arr = [0]
pos = 0

(1..2017).each do |x|
  pos = (pos + cycle) % arr.length

  arr = arr[0, pos+1].to_a + [x] + arr[pos+1, arr.length].to_a
  pos += 1
  if x == 2017
    puts "Number after 2017: #{arr[pos+1]}"
  end
end

pos = 0
lastZero = 0
puts ""

(1..50000000).each do |x|
  pos = (pos + cycle) % x

  if pos == 0
    lastZero = x
  end

  pos += 1

  if x % 1000000 == 0
    print "."
  end
end

puts "Number after 0 in 50M cycles: #{lastZero}"
