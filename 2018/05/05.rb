INPUT = './05.input.test'

class Polymer
  attr_reader :units

  def initialize(input=INPUT)
    @units = IO.read(INPUT).gsub("\n", '')
  end

  def p1
    process_with_threads.length
  end

  def process(group=@units)
    last_iteration = -1
    while last_iteration != group.length
      last_iteration = group.length
      remove_from(group)
    end
    return group
  end

  def process_with_threads(group=@units, threads=4)
    results = Array.new
    threads = Array.new

    sets = group.chars.each_slice(group.length / threads).to_a.map(&:join)
    sets.each do |set|
      threads << Thread.new { results << process(set) }
    end

    threads.each { |thread| thread.join }
    return process(results.join)
  end

  def patterns
    lower, upper = (?a..?z).to_a, (?A..?Z).to_a
    set = lower.map.with_index { |letter, i| letter + upper[i] }
    return set + set.map(&:reverse)
  end

  def remove_from(group=@units)
     patterns.map { |pattern| group.gsub!(pattern, '') }
  end
end
