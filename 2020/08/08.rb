class Boot
  INPUT = "./input.txt"

  attr_reader :input, :sequence

  def initialize(input = INPUT)
    @input = read(input)
  end

  def sequence
    @sequence ||= input.map.with_index do |instruction, index|
      {
        id: index,
        op: instruction.match(/^[A-z]{3}/).to_s,
        arg: instruction.match(/[+|-][0-9]+$/).to_s.to_i
      }
    end
  end

  def run_until_true
    bug_candidates = sequence.select { |instruction|
      ["jmp", "nop"].include? instruction[:op]
    }

    bug_candidates.each do |candidate|
      trial_sequence = sequence.dup

      candidate = candidate[:op].eql?("jmp") ?
        { id: candidate[:id], op: "nop", arg: candidate[:arg] } :
        { id: candidate[:id], op: "jmp", arg: candidate[:arg] }

      trial_sequence[candidate[:id]] = candidate
      trial_run = run_once(program: trial_sequence)

      return trial_run if trial_run.first.eql? true
    end
  end

  def run_once(program: sequence)
    accumulator, index, expired_ids = 0, 0, []

    loop do
      instruction = program[index]

      return [true, accumulator] if index.eql?(program.size)
      return [false, accumulator] if expired_ids.include?(instruction[:id])

      expired_ids << instruction[:id]

      case instruction[:op]
      when "acc"
        accumulator += instruction[:arg]
        index += 1
      when "jmp"
        index = [index, instruction[:arg]].sum
      when "nop"
        index += 1
      end
    end
  end

  private

  def read(input)
    data = input.eql?(INPUT) ? IO.readlines(input) : input.split("\n")
    data.map(&:chomp).reject(&:empty?)
  end
end

boot = Boot.new
puts boot.run_once
puts boot.run_until_true
