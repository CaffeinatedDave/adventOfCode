value = 312051
#value = 10

ptr = 1

direction = "E"
maxMove = 1
remMove = 1

x = 100
y = 100

grid = []
grid[100] = []
grid[100][100] = 1

foundNeighbor = nil

until (ptr == value) 
  ptr += 1

  case direction 
    when "E"
      nextDir = "N"
      movX = 1
      movY = 0
      changeMaxMove = 0
    when "N"
      nextDir = "W"
      movX = 0
      movY = 1
      changeMaxMove = 1
    when "W"
      nextDir = "S"
      movX = -1
      movY = 0
      changeMaxMove = 0
    when "S"
      nextDir = "E"
      movX = 0
      movY = -1
      changeMaxMove = 1
  end  

  x += movX
  y += movY

  remMove -= 1

  if remMove == 0
    direction = nextDir
    maxMove += changeMaxMove
    remMove = maxMove
  end

  if (foundNeighbor.nil?)
    calc = 0
    if !grid[x].nil?
      calc += grid[x].at(y+1) || 0
      calc += grid[x].at(y-1) || 0
    end
    if !grid[x+1].nil?
      calc += grid[x+1].at(y+1) || 0
      calc += grid[x+1].at(y-1) || 0
      calc += grid[x+1].at(y) || 0
    end
    if !grid[x-1].nil?
      calc += grid[x-1].at(y+1).to_i || 0
      calc += grid[x-1].at(y-1).to_i || 0
      calc += grid[x-1].at(y).to_i || 0
    end

    if grid[x].nil? 
      grid[x] = []
    end
    grid[x][y] = calc

    if (calc > value)
      foundNeighbor = calc
    end
  end

end

manDist = (x - 100).abs + (y - 100).abs
puts "Coord for #{ptr} is #{x},#{y}, distance of #{manDist}"

puts "Fib num greater than #{value} is #{foundNeighbor}"
