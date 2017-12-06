input = "5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6"

buckets = input.split("\s").map{|x| x.to_i}

counter = 0
seen = 0

history = []
until seen > 0
  counter += 1
  highest = 0
  buckets.each_with_index do |b, i|
    if b > buckets[highest] 
      highest = i
    end
  end

  toshare = buckets[highest] 
  buckets[highest] = 0
  
  ptr = highest
  while toshare > 0
    toshare -= 1
    ptr = (ptr + 1) % buckets.length

    buckets[ptr] += 1
  end

  history.each_with_index do |h, hi|
    match = true
    h.each_with_index do |v, vi|
      if v != buckets[vi]
        match = false
      end
    end
    if match && history.length > 0
      seen = hi + 1
    end
  end

  newhist = []
  buckets.each do |b|
    newhist << b
  end
  history << newhist
end

puts "Seen a match after #{counter} loops"
puts "Loop size is #{counter - seen}"
