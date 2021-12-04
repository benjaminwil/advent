require "net/http"
require "pathname"
require "uri"

module Advent
  def self.included(klass)
    current_path = caller[0].partition(":")[0]

    klass.extend ClassMethods

    klass.puzzle(current_path)
    klass.download_input if klass.puzzle?
  end

  module ClassMethods
    def download_input
      return if File.exist? input_file

      url = URI("https://adventofcode.com/2021/day/#{puzzle.to_i}/input")
      http = ::Net::HTTP.new(url.host, 443)
      http.use_ssl = true

      request = ::Net::HTTP::Get.new(url.request_uri)
      request["Cookie"] = cookie

      File.open(input_file, "w") { |f| f.write http.request(request).body }
    end

    def puzzle(current_path = nil)
      @@puzzle ||= current_path.split("/")[0]
    end

    def puzzle?(filename_part = puzzle)
      filename_part.match? /\d{2}/
    end

    def input_file
      File.join(File.dirname(__FILE__), puzzle, "input.txt")
    end

    def read(file)
      if File.exist?(file)
        IO.readlines(file).map(&:chomp).reject(&:empty?)
      else
        file.split("\n")
      end
    end

    private

    def cookie
      begin
        IO.readlines(File.open(File.join(File.dirname(__FILE__), "..", ".aoc-cookie")))
          .map(&:chomp)
          .reject(&:empty?)
          .first
      rescue
        puts "Session cookie needs to exist at the project root in '.aoc-cookie'."
        puts "The cookie contents should look like 'session=<identifier>'."
      end
    end
  end
end
