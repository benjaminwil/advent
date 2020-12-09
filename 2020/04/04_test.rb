require "minitest/autorun"
require_relative "./04"

describe Passports do
  let(:input) {
    <<~TXT
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
    TXT
  }

  let(:passports) { Passports.new(input) }

  describe "parse_input" do
    let(:subject) { passports.parse_input }

    it "returns four passports" do
      _(subject.count).must_equal 4
    end
  end

  describe "valid?" do
    let(:subject) { passports.valid?(passport) }

    describe "valid passport" do
      let(:passport) {
        {ecl: "gry", pid: "860033327", eyr: "2020", byr: "1937",
         hcl: "#fffffd", iyr: "2017", cid: "147", hgt: "183cm"}
      }
      it "is valid" do
        _(subject).must_equal true
      end
    end

    describe "invalid passport" do
      let(:passport) {
        {iyr: "2013", ecl: "amb", cid: "350", eyr: "2023", hcl: "#cfa07d",
         pid: "028048884", byr: "1929"}
      }
      it "is valid" do
        _(subject).must_equal false
      end
    end

    describe "valid passport" do
      let(:passport) {
        {iyr: "2013", eyr: "2024", ecl: "brn", pid: "760753108", byr: "1931",
         hcl: "#ae17e1" ,hgt: "179cm"}
      }
      it "is valid" do
        _(subject).must_equal true
      end
    end

    describe "invalid passport" do
      let(:passport) {
        {hcl: "#cfa07d", eyr: "2025", pid: "166559648", iyr: "2011", ecl:
         "brn", hgt: "59in"}
      }
      it "is valid" do
        _(subject).must_equal false
      end
    end

    describe "count" do
      let(:subject) { passports.count }

      it "counts two" do
        _(subject).must_equal 2
      end
    end
  end
end
