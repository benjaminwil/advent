class IDs

  attr_reader :id

  def initialize(id)
    @id = id.split(//)
  end
  
  def has_dupes?(count)
    !!@id.detect { |n| @id.count(n) == count }
  end
end

class Inventory

  attr_reader :ids

  def initialize(input='./02.input')
    list = IO.readlines(input).map { |n| n.chomp.to_s }
    @ids = list.map { |id| IDs.new(id) }
    @cheksum = twos * threes
  end
  
  def difference
    @ids.each do |a|
      @ids.each do |b|
        counter = 0 
        a.id.each_with_index do |character, index| 
          counter += 1 if character != b.id[index]
        end
        return (a.id - (a.id - b.id)).join if counter == 1
      end
    end
    return false
  end
  
  def twos
    @ids.select { |id| id.has_dupes?(2) }.count
  end

  def threes
    @ids.select { |id| id.has_dupes?(3) }.count
  end
end
