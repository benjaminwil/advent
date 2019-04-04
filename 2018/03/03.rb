INPUT = './03.input'

class Claim
  attr_reader :id, :x, :y, :w, :h

  def initialize(claim)
    @id, @x, @y, @w, @h = claim.split(/\D+/).reject(&:empty?).map(&:to_i)
  end

  def inches
    left = ((@x)...(@x + @w)).to_a
    top  = ((@y)...(@y + @h)).to_a
    left.product(top)
  end
end

class Claims
  attr_reader :all

  def initialize
    @all = Array.new
    IO.readlines(INPUT).each { |claim| @all << Claim.new(claim) }
  end

  def inches
    list = Array.new
    @all.each do |claim|
      claim.inches.each { |inch| list << inch }
    end
    list
  end

  def counter
    roll = Hash.new(0)
    inches.each { |inch| roll[inch] += 1 }
    roll
  end

  def two_or_more_inches
    counter.reject { |inch, count| count == 1 }.count
  end

  def claim_with_no_overlap
    singles = counter.select { |inch, count| count == 1 }.map { |inch| inch[0] }
    @all.detect { |claim| claim.inches - singles == [] }.id
  end
end

