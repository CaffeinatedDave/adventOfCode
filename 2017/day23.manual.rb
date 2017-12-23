# Probably not really in the spirit of the rest of these,
# but this is the cleaned up version of what it was actually doing...

r1 = 106500
r2 = 123500

h = 0

(r1..r2).step(17) do |b|
  d = 2

  while b > d
    if b % d == 0
      h += 1
      b = d
    end

    d += 1
  end
end

puts h
