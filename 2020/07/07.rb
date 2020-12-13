class Rules
  INPUT = "./input.txt"

  attr_reader :input, :containers

  def initialize(input = INPUT)
    @input = read(input)
  end

  def containers
    @containers ||= input.map { |rule|
      rule = rule.gsub("contain", ":")
        .scan(/[A-z0-9\s]+bag[s]*/)
        .map { |r| r.gsub(/[\s]*bag[s]*/, "")
      }
      {
        container: rule.first,
        contains: rule[1..-1].map { |c|
          [
            c.match(/[A-z][A-z\s]*[A-z]/).to_s.to_sym,
            c.match(/[\d]+/).to_s.to_i
          ]
        }.to_h
      }
    }
  end

  def candidates_for(color = "shiny gold", candidates = [])
    containers.each do |bag|
      if bag[:contains].keys.include? color.to_sym
        candidates_for(bag[:container], (candidates << bag))
      end
    end

    candidates.uniq
  end

  def contained
    @bags = 0

    contained_within

    @bags
  end

  def contained_within(color = "shiny gold")
    return if color.eql? "no other"

    container = containers.detect { |current|
      current[:container].eql? color
    }

    @bags += container[:contains].values.sum

    container[:contains].each do |bag, count|
      count.times do
        contained_within(bag.to_s)
      end
    end
  end

  private

  def read(input)
    input.eql?(INPUT) ? IO.readlines(input) : input.split("\n")
  end
end

rules = Rules.new
puts rules.candidates_for("shiny gold").size
puts rules.contained
