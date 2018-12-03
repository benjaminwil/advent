class Frequency
  def initialize(initial_freq=0)
    @start = initial_freq
    @freqs = IO.readlines('./01.input').map { |n| n.chomp.to_i }
  end 
  
  def result
    @freqs.reduce(@start, :+)
  end
  
  def first_dupe
    results = Array.new 
    total = @start 
    @freqs.cycle do |freq|
      return total if results.include? total 
      results << total
      total += freq
    end
  end
end
