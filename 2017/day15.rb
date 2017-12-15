genA = 16807
genB = 48271

found = 0

valA = 277
valB = 349
(1..40000000).each do |x|
  valA = (valA * genA) % 2147483647
  valB = (valB * genB) % 2147483647

  sixteenA = valA % 65536
  sixteenB = valB % 65536

  if sixteenA == sixteenB
    found += 1
  end
end

puts "Found #{found} matches in 40M tries"

found = 0
valA = 277
valB = 349
(1..5000000).each do |x|
  loop do
    valA = (valA * genA) % 2147483647
    break if (valA % 4 == 0)
  end

  loop do
    valB = (valB * genB) % 2147483647
    break if (valB % 8 == 0)
  end

  sixteenA = valA % 65536
  sixteenB = valB % 65536

  if sixteenA == sixteenB
    found += 1
  end
end

puts "Found #{found} matches in 5M tries"
