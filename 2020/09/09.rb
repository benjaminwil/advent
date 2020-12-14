class Preamble
  INPUT = "./input.txt"

  attr_reader :input, :first_invalid_entry

  def initialize(input = INPUT)
    @input = read(input)
  end

  def encryption_weakness(range)
    [range.min, range.max].sum
  end

  def first_invalid_entry(limit: 25)
    @first_invalid_entry ||= input.detect.with_index { |entry, index|
      next if index < limit

      entries_within_limit = input[(index - limit)..(index - 1)]

      combinations = entries_within_limit.product(entries_within_limit)

      !combinations.map(&:sum).include? entry
    }
  end

  def weak_range(limit: 25)
    last_candidate_index = input.find_index(first_invalid_entry(limit: limit))
    candidates = input[0..last_candidate_index]

    candidates.each.with_index do |candidate, index|
      (3..last_candidate_index).to_a.each do |set|
        group = candidates[index..index + set]

        return group if group.sum.eql? first_invalid_entry
      end
    end
  end

  private

  def read(input)
    data = input.eql?(INPUT) ? IO.readlines(input) : input.split("\n")
    data.map(&:chomp).reject(&:empty?).map(&:to_i)
  end
end

preamble = Preamble.new
puts preamble.first_invalid_entry
puts preamble.encryption_weakness(preamble.weak_range)
