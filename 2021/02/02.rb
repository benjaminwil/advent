require_relative "../../advent"

class Position
  include Advent

  class << self
    def result(input: input_file)
      log = read(input).map { |line|
        current_position = line.split(" ")
        [current_position[0], current_position[1].to_i]
      }

      counts = {}
      log.each do |direction, value|
        counts[direction] ||= 0
        counts[direction] = counts[direction] + value
      end

      counts["forward"] * (counts["down"] - counts["up"])
    end

    def result2(input: input_file)
      log = read(input).map { |line|
        current_position = line.split(" ")
        [current_position[0], current_position[1].to_i]
      }

      counts = {"aim" => 0, "depth" => 0, "forward" => 0}
      log.each do |direction, value|
        case direction
        when "up"
          counts["aim"] = counts["aim"] - value
        when "down"
          counts["aim"] = counts["aim"] + value
        when "forward"
          counts["depth"] =  counts["depth"] + (counts["aim"] * value)
          counts["forward"] = counts["forward"] + value
        end
      end

      counts["forward"] * counts["depth"]
    end
  end
end

puts Position.result
puts Position.result2
