input = ""
File.open("day9.input").each do |l|
  input += l
end

clean = ""

skip = false
garbage = false
garbageCount = 0
input.split('').each do |x|
  if skip
    skip = false
    next
  elsif garbage
    case x
      when '!'
        skip = true
      when '>'
        garbage = false
      else
        garbageCount += 1
    end
    next
  end

  case x
    when '<'
      garbage = true
    else
      if x == '{' or x == '}'
        clean += x
      end
  end
end

total = 0
level = 0
clean.split('').each do |c|
  case c
    when '{'
      level += 1
    when '}'
      total += level
      level -= 1
  end
end

puts "Total score: #{total}"
puts "Garbage characters #{garbageCount}"
