class Traversal
  INPUT = "./input.txt"

  def self.trees_encountered(input = INPUT, slope: [3, 1])
    trees = 0
    position = [0, 0]

    lines = self.read(input)

    lines.each do |line|
      break if position.last >= lines.count

      x, y = self.x(position.first, line.length), position.last

      trees += 1 if lines[y][x].eql? "#"

      position = self.movement(
        from: [x, y],
        slope: [slope.first, slope.last]
      )
    end

    trees
  end

  def self.all_routes(input = INPUT, slopes:)
    slopes.map { |slope|
      self.trees_encountered(input, slope: slope)
    }.inject(:*)
  end

  private

  def self.x(position, max)
    position % max
  end

  def self.movement(from: [0, 0], slope: [3, 1])
    x, y = from.first, from.last

    [x + slope.first, y + slope.last]
  end

  def self.read(input)
    return input.split unless input.eql? INPUT

    IO.readlines(input).map(&:chomp)
  end
end

puts Traversal.trees_encountered
puts Traversal.all_routes(
  slopes: [
    [3, 1], [1, 1], [5, 1], [7, 1], [1, 2]
  ]
)
