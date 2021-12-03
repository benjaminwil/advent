require_relative "../../advent"

class Diagnostic
  include Advent

  class << self
    def consumption(input: input_file)
      common = most_common_bits(input: input)
      gamma, epsilon = common.to_i(2), epsilon(common).to_i(2)
      gamma * epsilon
    end

    def rating(input: input_file)
      common = most_common_bits(input: input)
      oxygen = candidate(input: input, set: common)
      c_oh_2 = candidate(input: input, set: epsilon(common), gamma: false)

      oxygen * c_oh_2
    end

    private

    def candidate(input: input_file, set:, gamma: true)
      remaining = set
      candidates = read(input)

      set.chars.each.with_index do |char, index|
        break if candidates.size == 1

        candidates = reduce(remaining[index], index, candidates, gamma)
        remaining =
          gamma ? most_common_bits(input: candidates.join("\n")) :
            least_common_bits(input: candidates.join("\n"))
      end

      candidates.first.to_i(2)
    end

    def epsilon(binary_string)
      binary_string.chars.map { |char| char == "1" ? "0" : "1" }.join
    end

    def least_common_bits(input: input_file)
      epsilon(most_common_bits(input: input))
    end

    def most_common_bits(input: input_file)
      collection = Hash.new { |h, k| h[k] = [] }

      read(input).map(&:chars).each do |set|
        set.each.with_index { |value, index| collection[index] << value }
      end

      collection.values.map { |c|
        c.tally.to_a.max_by { |_, v| v }.first.to_s.to_i
      }.join
    end

    def reduce(char, index, candidates, gamma)
      selects, rejects = [], []

      candidates.each do |set|
        selects << set if set[index] == char
        rejects << set if set[index] != char
      end

      return selects unless selects.size == rejects.size

      preference = gamma ? "1" : "0"
      selects.first[index] == preference ? selects : rejects
    end
  end
end

puts Diagnostic.rating
