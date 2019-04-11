require 'date'

INPUT = '04.input'

class Entry
  attr_reader :index, :datetime, :guard_id, :state

  def initialize(log_entry)
    @datetime, @guard_id, @state = parse_entry(log_entry)
    @index = 0
  end

  def parse_entry(input)
    datetime = parse_datetime(input)
    guard_id = input.match(/\#\d+/).to_s.delete('#') || nil
    state = input.match(/begins|asleep|wakes/).to_s
    return [datetime, guard_id, state]
  end

  def parse_datetime(input)
    yyyy, mo, dd, hh, mi = input
      .match(/[\d\-\:\s]+/)
      .to_s
      .split(/\s|\:|\-/)
      .map(&:to_i)
    DateTime.new(yyyy, mo, dd, hh, mi)
  end
end

class Timeline
  attr_reader :all

  def initialize
    @all = Array.new
    IO.readlines(INPUT).each { |entry| @all << Entry.new(entry) }
    sort_entries; fill_all_guard_ids
  end

  def winner
    guard = most_asleep_guard
    best_minute = most_asleep_minute_for(guard).first
    puts "Guard: #{guard.to_i}\nBest minute: #{best_minute}"
    return [guard.to_i, best_minute].inject(:*)
  end

  def winner_pt2
    guard = leader
    return guard[:guard].to_i * guard[:minute]
  end

  def asleep_entries(guard)
    logs = @all.select { |log| log.guard_id == guard }
    logs.select do |log|
      log.state == "asleep" || log.state == "wakes"
    end
  end

  def fill_all_guard_ids
    @all.each.with_index do |entry, i|
      if entry.instance_variable_get("@guard_id").empty?
        prev = @all[(i - 1)].instance_variable_get("@guard_id")
        entry.instance_variable_set(:@guard_id, prev)
      end
    end
  end

  def list_minutes_asleep(guard)
    logs = asleep_entries(guard).each_slice(2).to_a
    logs.map { |log| Utility.each_minute_between_datetimes(log.first.datetime, log.last.datetime) }.flatten
  end

  def minutes_asleep(guard)
    logs = asleep_entries(guard).each_slice(2).to_a
    logs.map { |a, b| Utility.each_minute_between_datetimes(b.datetime, a.datetime) }.count
  end

  def most_asleep_guard
    guards = @all.map { |log| log.guard_id }.uniq
    asleep_time = guards.map do |guard|
      [guard, minutes_asleep(guard)]
    end.to_h
    asleep_time.max_by {|guard, total| total }.first
  end

  def most_asleep_minute_for(guard, flag=nil)
    minutes = list_minutes_asleep(guard)
    counter = Hash.new(0)
    minutes.each { |minute| counter[minute] += 1 }
    answer = counter.max_by { |minute, count| count }
  end

  def minute_leaderboard
    guards = @all.map do |log|
      log.guard_id unless asleep_entries(log.guard_id).empty?
    end.uniq.compact.reject(&:empty?)
    leaderboard = guards.map do |guard|
      minute_count = most_asleep_minute_for(guard)
      { :guard => guard,
        :minute => minute_count.first,
        :count => minute_count.last
      }
    end
    return leaderboard
  end

  def leader
    candidate = minute_leaderboard.max_by { |board| board[:count] }
    return candidate
  end

  def sort_entries
    @all.sort! { |a, b| a.datetime <=> b.datetime }
    @all.each.with_index { |entry, i| entry.instance_variable_set(:@index, i) }
  end

end

class Utility
  def self.each_minute_between_datetimes(earliest, latest)
    ((earliest.minute)...(latest.minute)).to_a
  end
end

