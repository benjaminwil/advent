require_relative "../advent"

class Overlap
  include Advent
  def initialize(input: self.class.input_file)
    @input = self.class.read(input)
  end

  def simple
    points = []
    coordinates.each do |x1, y1, x2, y2|
      next unless (x1 == x2 || y1 == y2)
      path(x1, y1, x2, y2).each { |point| points << point }
    end
    points.tally.select { |_, v| v >= 2 }.count
  end

  def complex
    points = []
    coordinates.each do |x1, y1, x2, y2|
      path(x1, y1, x2, y2).each { |point| points << point }
    end
    points.tally.select { |_, v| v >= 2 }.count
  end

  private

  def coordinates
    @coordinates ||= @input.map { |c| c.split(/ \-\> |\,/).map(&:to_i) }
  end

  def path(x1, y1, x2, y2)
    x, y = points(x1, x2), points(y1, y2)

    case
    when (x1 == x2) || (y1 == y2) then x.product(y)
    when (x1 == x1 || y2) || (y1 == x1 || x2) then x.zip(y)
    end
  end

  def points(a, b)
    (a..b).to_a.empty? ? (b..a).to_a.reverse : (a..b).to_a
  end
end

# puts Overlap.new.simple
# puts Overlap.new.complex
