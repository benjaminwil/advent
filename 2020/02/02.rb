class Passwords
  def self.answer(input: "./input.txt", method: :valid_passwords)
    output = self.public_send(method, self.valid_passwords(input))
    output.size
  end

  def self.parse(input)
    self.read(input).map do |password|
      {
        low: password.match(/^\d*/).to_s.to_i,
        high: password.match(/-\d*/).to_s.gsub("-", "").to_i,
        char: password.match(/[A-z]:/).to_s.gsub(":", ""),
        password: password.match(/[A-z]+$/).to_s,
        raw: password
      }
    end
  end

  def self.valid_passwords(input)
    self.parse(input).select { |entry|
      chars = entry[:password].chars
      next unless chars.include? entry[:char]

      results = [
        chars[entry[:low] - 1] == entry[:char],
        chars[entry[:high] - 1] == entry[:char]
      ]

      (results.any? true) && !(results.all? true)
    }
  end

  def self.valid_toboggan_passwords(input)
    self.parse(input).select { |entry|
      chars = entry[:password].chars
      next unless chars.include? entry[:char]

      count = chars.count(entry[:char])

      count >= entry[:low] && count <= entry[:high]
    }
  end

  private

  def self.read(file)
    return file if file.class.eql? Array

    IO.readlines(file).map(&:chomp).reject(&:empty?)
  end
end

puts Passwords.answer
