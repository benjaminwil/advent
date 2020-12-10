class Declaration
  INPUT = "./input.txt"

  attr_reader :input

  def initialize(input = INPUT)
    @input = read(input)
  end

  def unique
    input.map { |group| group.join.chars.uniq.size }.sum
  end

  def consensus
    input.map { |group|
      group.join.chars.uniq.select { |q|
        group.join.chars.count(q).eql? group.size
      }.size
    }.sum
  end

  private

  def read(input)
    data = input.eql?(INPUT) ? IO.readlines(input).join : input
    data.split("\n\n").map { |group| group.split("\n") }
  end
end

declaration = Declaration.new
puts declaration.unique
puts declaration.consensus
