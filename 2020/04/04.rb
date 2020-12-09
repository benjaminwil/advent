class Passports
  INPUT = "./input.txt"

  ECL = %w(amb blu brn gry grn hzl oth)
  REQUIREMENTS = %i(byr iyr eyr hgt hcl ecl pid)

  def initialize(input = INPUT)
    @input = read(input)
  end

  def count
    parse_input.select { |passport| valid? passport }.size
  end

  def parse_input
    input.map { |entry|
      entry.scan(/[A-z]+:[\#A-z\d]+/).map { |field|
        field = field.split(":")
        [field.first.to_sym, field.last]
      }.to_h
    }
  end

  def valid?(passport)
    return false unless REQUIREMENTS.all? { |field|
      passport.keys.include? field
    }

    REQUIREMENTS.map { |field|
      send("valid_#{field.to_s}?", passport[field])
    }.all?(true)
  end

  private

  attr_reader :input

  def read(input)
    data = input.eql?(INPUT) ? IO.readlines(input).join : input
    data.split("\n\n")
  end

  def four_digits?(value)
    value.match?(/\d{4}/)
  end

  def valid_byr?(byr)
    four_digits?(byr) && byr.to_i >= 1920 && byr.to_i <= 2002
  end

  def valid_iyr?(iyr)
    four_digits?(iyr) && iyr.to_i >= 2010 && iyr.to_i <= 2020
  end

  def valid_eyr?(eyr)
    four_digits?(eyr) && eyr.to_i >= 2020 && eyr.to_i <= 2030
  end

  def valid_hgt?(hgt)
    measurement = hgt.match(/^\d+/).to_s.to_i

    if hgt.match?(/^\d{3}cm$/)
      measurement >= 150 && measurement <= 193
    elsif hgt.match?(/^\d{2}in$/)
      measurement >= 59 && measurement <= 76
    end
  end

  def valid_hcl?(hcl)
    hcl.match?(/^\#[a-f\d]{6}$/)
  end

  def valid_ecl?(ecl)
    ECL.include?(ecl)
  end

  def valid_pid?(pid)
    pid.match?(/^\d{9}$/)
  end
end

passports = Passports.new
puts passports.count

