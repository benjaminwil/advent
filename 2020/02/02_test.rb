require "minitest/autorun"
require_relative "./02"

describe Passwords do
  let(:input) {
    [
      "1-3 a: abcde",
      "1-3 b: cdefg",
      "2-9 c: ccccccccc"
    ]
  }

  describe "valid_passwords" do
    let(:subject) { Passwords.valid_passwords(input) }
    let(:valid_passwords) {
      [
        "1-3 a: abcde"
      ]
    }

    it "returns valid passwords" do
      _(subject).must_equal valid_passwords
    end
  end

  describe "valid_toboggan_passwords" do
    let(:subject) { Passwords.valid_toboggan_passwords(input) }
    let(:valid_passwords) {
      [
        "1-3 a: abcde",
        "2-9 c: ccccccccc"
      ]
    }

    it "returns valid passwords" do
      _(subject).must_equal valid_passwords
    end
  end

  describe "parse" do
    let(:password) { input[0] }
    let(:subject) { Passwords.parse([password]) }

    it "returns parsed password data" do
      _(subject).must_equal([{
        low: 1,
        high: 3,
        char: "a",
        password: "abcde",
        raw: password
      }])
    end
  end
end
