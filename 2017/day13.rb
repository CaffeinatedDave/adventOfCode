input = "0: 4
1: 2
2: 3
4: 4
6: 8
8: 5
10: 6
12: 6
14: 10
16: 8
18: 6
20: 9
22: 8
24: 6
26: 8
28: 8
30: 12
32: 12
34: 12
36: 12
38: 10
40: 12
42: 12
44: 14
46: 8
48: 14
50: 12
52: 14
54: 14
58: 14
60: 12
62: 14
64: 14
66: 12
68: 12
72: 14
74: 18
76: 17
86: 14
88: 20
92: 14
94: 14
96: 18
98: 18"

perfect = false
delay = -1
zeroRun = -1

until perfect
  delay += 1
  score = 0

  caught = false

  input.split("\n").each do |layer|
    x = layer.split(":")

    layer = x[0].to_i
    bufferSize = x[1].to_i

    time = delay + layer

    rollingLength = ((bufferSize * 2) - 2)

    if (((rollingLength) * 100000) - time) % rollingLength == 0
      caught = true
      score += layer * bufferSize
    end
  end

  if caught == false
    perfect = true
  end
  if delay == 0
    zeroRun = score
  end
end

puts "Score for run 0 is: #{zeroRun}"
puts "Perfect run found after #{delay}"
