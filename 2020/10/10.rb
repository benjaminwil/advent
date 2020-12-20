class Joltage
  INPUT = "./input.txt"

  attr_reader :input

  def initialize(input = INPUT)
    @input = read(input)
  end

  def multiplied_joltages
    differences[:one] * differences[:three]
  end

  def differences
    ones, threes = 0, 0

    input.each_cons(2) do |a, b|
      case (b - a)
      when 3 then threes += 1
      when 1 then ones += 1
      else
        next
      end
    end

    { one: ones, three: threes }
  end

  def arrangements(n = 0)
    return 1 if n == input.last

    @arrangements ||= {}

    @arrangements[n] ||= next_adapters(n).map { |adapter|
      arrangements(adapter)
    }.sum
  end


  def next_adapters(n)
    index = input.index(n)

    begins = input.index(index + 1)
    ends = (index + 3) >= input.size ? -1 : index + 3

    input[begins..ends].select { |adapter|
      [1, 2, 3].include? adapter - n
    }
  end

  private

  def read(input)
    data = input.eql?(INPUT) ? IO.readlines(input) : input.split("\n")
    data = data.map(&:chomp).reject(&:empty?).map(&:to_i)

    [0] + data.sort + [data.max + 3]
  end
end

joltage = Joltage.new
puts joltage.multiplied_joltages
puts joltage.arrangements
