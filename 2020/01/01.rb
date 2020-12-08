class Entries
  def self.answer(input: "./input.txt", method: :find_pair)
    output = self.public_send(method, self.read(input))
    output.inject(:*)
  end

  private

  def self.read(file)
    return file if file.class.eql? Array

    IO.readlines(file).map(&:chomp).reject(&:empty?).map(&:to_i)
  end

  def self.find_pair(input)
    input.each do |a|
      input.each do |b|
        return [a, b].sort if ([a, b].sum == 2020)
      end
    end
  end

  def self.find_trio(input)
    input.each do |a|
      input.each do |b|
        input.each do |c|
          return [a, b, c].sort if ([a, b, c].sum == 2020)
        end
      end
    end
  end
end

puts Entries.answer
puts Entries.answer(method: :find_trio)
