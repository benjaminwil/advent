class Seats
  INPUT = "./input.txt"

  attr_reader :input

  def initialize(input = INPUT)
    @input = read(input)
  end

  def ids
    parse.map { |pass| pass[:id] }
  end

  def open_seat
    (ids.min..ids.max).to_a - ids
  end

  def parse
    input.map do |pass|
      row, col = (0..127).to_a, (0..7).to_a

      transform_row(pass).each do |zone|
        row = row.each_slice(row.size / 2).to_a[zone]
      end

      transform_col(pass).each do |zone|
        col = col.each_slice(col.size / 2).to_a[zone]
      end

      row, col = row.first, col.first

      { row: row, col: col, id: id(row, col) }
    end
  end

  private

  def id(row, col)
    (row * 8) + col
  end

  def read(input)
    return input unless input.eql? INPUT
    IO.readlines(INPUT).map(&:chomp).reject(&:empty?)
  end

  def transform_col(pass)
    pass.scan(/L|R/).map { |p| p.gsub("L", "0").gsub("R", "1").to_i }
  end

  def transform_row(pass)
    pass.scan(/F|B/).map { |p| p.gsub("F", "0").gsub("B", "1").to_i }
  end
end

seats = Seats.new
puts seats.ids.max
puts seats.open_seat

