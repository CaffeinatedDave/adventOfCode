input = "25/13
4/43
42/42
39/40
17/18
30/7
12/12
32/28
9/28
1/1
16/7
47/43
34/16
39/36
6/4
3/2
10/49
46/50
18/25
2/23
3/21
5/24
46/26
50/19
26/41
1/50
47/41
39/50
12/14
11/19
28/2
38/47
5/5
38/34
39/39
17/34
42/16
32/23
13/21
28/6
6/20
1/30
44/21
11/28
14/17
33/33
17/43
31/13
11/21
31/39
0/9
13/50
10/14
16/10
3/24
7/0
50/50"

bridges = []

input.split("\n").each do |i|
  bridge = i.split("/").map{|x| x.to_i}.sort
  bridges << bridge
end

solutions = []

start = 0
max = 0

longest = 0
longestStrength = 0


inProgress = bridges.select{ |b| b[0] == start or b[1] == start }.map{ |x| [x] }

while !inProgress.empty?
  doing = inProgress[0]
  solutions << doing

  inProgress = inProgress[1, inProgress.length]

  search = 0
  doing.each do |part|
    if part[0] == search
      search = part[1]
    else
      search = part[0]
    end
  end

  matches = bridges.select{ |b| (b[0] == search or b[1] == search) and !doing.include?(b)}

  if matches.empty?
    score = 0
    doing.each do |s|
      score += s[0] + s[1]
    end

    puts "#{inProgress.length} left: #{doing.join(", ")} scores #{score}"

    if doing.length > longest or (doing.length == longest and score > longestStrength)
      longestStrength = score
      longest = doing.length
    end

    if score >= max
      max = score
    end
  else
    matches.each do |m|
      inProgress << doing + [m]
    end
  end
end

puts "#{max} is the max strength"
puts "#{longest} is the longest bridge, with strength #{longestStrength}"
