require_relative "../advent"

class Lanternfish
  include Advent

  def initialize(input: self.class.input_file)
    @input = self.class.read(input)
  end

  def population(days:)
    fishes = all
    days.times do
      t, r = fishes, (t[0] + t[7])
      fishes = {0 => t[1],
                1 => t[2],
                2 => t[3],
                3 => t[4],
                4 => t[5],
                5 => t[6],
                6 => r,
                7 => t[8],
                8 => t[0]}
    end
    fishes.values.sum
  end

  def all
    @all ||=
      begin
        tally = {}
        (0..8).to_a.each { |n| tally[n] = 0 }
        tally.merge @input.join.split(",").map(&:to_i).tally
      end
  end
end

# puts Lanternfish.new.population(days: 80)
# puts Lanternfish.new.population(days: 256)
