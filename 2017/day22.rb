input = "#.###...#..#..#...##.####
##.##.#..##.#..#.#..#####
.####..###.#.#####.#.##.#
##..#.##.#.#.#...#..##..#
..#...####.#.###.###...#.
#..###.##.###.....#....#.
.#..#.##.##....##...####.
###.##....#...#.##....##.
..#.###..######.#.####...
.#.###..#.##.#..##.######
###.####.#####.####....#.
#...####.#.##...##..#.#..
##.######.#....##.#.####.
.#.#..#...##....#....#...
.####.##.#..##...#..####.
.#.####.##..###..###..##.
...#...####...#.#.#.###.#
#.##.####.#..##.###.####.
.#.#...####....##..####.#
##.###.##..####..#.######
#.#...#.#.##.####........
.......#..##..#.#..###...
.#..###.###........##.#..
.######.......#.#.##.#.#.
.##..#.###.....##.#.#...#"

grid = {}
grid.default = nil

input.split("\n").each_with_index do |l, y|
  grid[y] = {}
  grid[y].default = "."
  l.split("").each_with_index do |c, x|
    grid[y][x] = c
  end
end

# It just is, ok....
posX = 12
posY = 12
dir = "N"

leftTurn = {
  "N" => "W",
  "W" => "S",
  "S" => "E",
  "E" => "N"
}
rightTurn = {
  "N" => "E",
  "W" => "N",
  "S" => "W",
  "E" => "S"
}
reverse = {
  "N" => "S",
  "S" => "N",
  "E" => "W",
  "W" => "E"
}
infecting = 0

(1..10000000).each do |x|
  case grid[posY][posX]
    when '.'
      dir = leftTurn[dir]
      grid[posY][posX] = 'W'
    when 'W'
      grid[posY][posX] = '#'
      infecting += 1
    when '#'
      dir = rightTurn[dir]
      grid[posY][posX] = 'F'
    when 'F'
      dir = reverse[dir]
      grid[posY][posX] = '.'
  end

  case dir
    when "N"
      posY -= 1
    when "E"
      posX += 1
    when "S"
      posY += 1
    when "W"
      posX -= 1
  end

  if grid[posY].nil?
    grid[posY] = {}
    grid[posY].default = "."
  end
end

  minX = 0
  minY = 0
  maxX = 0
  maxY = 0
  grid.each do |yk, yv|
    yv.each_key do |xk|
      if xk > maxX
        maxX = xk
      end
      if xk < minX
        minX = xk
      end
    end

    if yk > maxY
      maxY = yk
    end
    if yk < minY
      minY = yk
    end
  end

  (minY..maxY).each do |y|
    (minX..maxX).each do |x|
      if x == posX and y == posY
        print "X"
      else
        print grid[y][x]
      end
    end
    puts ""
  end
  puts""


puts "After 10k, infected turns = #{infecting}"
