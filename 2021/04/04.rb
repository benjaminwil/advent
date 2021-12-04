require_relative "../advent"

class Bingo
  include Advent

  def initialize(input: self.class.input_file)
    @input = self.class.read(input)
  end

  def best
    final_call, winner = 0, []

    callsheet.each do |callnumber|
      cards.each do |card|
        mark(card, callnumber)
        winner, final_call = card, callnumber.to_i if winner?(card)
      end
      break if final_call != 0
    end

    winner.flatten.compact.map(&:to_i).sum * final_call
  end

  def worst
    final_call, winners = 0, []

    callsheet.each do |callnumber|
      cards.each do |card|
        mark(card, callnumber)
        winners << card if !winners.include?(card) && winner?(card)
        final_call = callnumber.to_i if cards.all? { |b| winner?(b) }
      end
      break if final_call != 0
    end

    winners.last.flatten.compact.map(&:to_i).sum * final_call
  end

  private

  def cards
    @cards ||=
      @input[1..-1].reject(&:empty?).each_slice(5).to_a.map { |card|
        card.map { |row| row.split(" ") }
      }
  end

  def callsheet
    @callsheet ||= @input.first.split(",")
  end

  def mark(card, callnumber)
    return unless card.flatten.include? callnumber

    row = card.detect { |row| row.include?(callnumber) }
    card[card.index(row)][row.index(callnumber)] = nil
  end

  def winner?(card)
    card.any? { |row| row.all?(nil) } ||
      card.transpose.any? { |col| col.all?(nil) }
  end
end

# puts Bingo.new.best
# puts Bingo.new.worst
