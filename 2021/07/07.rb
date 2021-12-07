require_relative "../advent"

class Crabmarine
  include Advent

  def initialize(input: self.class.input_file)
    @input = self.class.read(input)
  end

  def cheapest(calc = :n, points = starting_points, best = Float::INFINITY)
    lows, highs = points.each_slice(points.size / 2).to_a
    min = (lows.min..lows.min + (lows.count)).to_a.map { |n| send(calc, n) }.min
    max = (highs.min..highs.min + (highs.count)).to_a.map { |n| send(calc, n) }.min

    case
    when best <= (min && max) then best
    when min <= max then cheapest(calc, lows, min)
    else
      cheapest(calc, highs, max)
    end
  end

  private

  def n(t)
    fuel = 0
    starting_points.each do |p|
      fuel += p > t ? (t...p).to_a.count : (p...t).to_a.count
    end
    fuel
  end

  def n_plus_i(t)
    fuel = 0
    starting_points.each { |p| fuel += trip(p, t) }
    fuel
  end

  def starting_points
    @starting_points ||= @input.join.split(",").map(&:to_i).sort
  end

  def trip(a, b)
    points = a > b ? (b...a) : (a...b)
    points.to_a.map.with_index { |_, i| 1 + i }.sum
  end
end

puts Crabmarine.new.cheapest
puts Crabmarine.new.cheapest(:n_plus_i)
