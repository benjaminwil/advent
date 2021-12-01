class Depth
  class << self
    def increases(input: input_file)
      count = 0
      log = read(input).map(&:to_i)

      log.each.with_index do |depth, index|
        next if index.eql? 0
        count += 1 if depth > log[index - 1]
      end

      count
    end

    def sliding(input: input_file)
      count = 0
      log = read(input).map(&:to_i).each_cons(3).to_a

      log.each.with_index do |depth, index|
        next if index.eql? 0
        count +=1 if depth.sum > log[index - 1].sum
      end

      count
    end

    private

    def input_file
      File.open File.join(File.dirname(__FILE__), "input.txt")
    end

    def read(file)
      case file.class
      when Array
        file
      when String
        file.split("\n")
      else
        IO.readlines(file).map(&:chomp).reject(&:empty?)
      end
    end
  end
end

puts Depth.increases
puts Depth.sliding
