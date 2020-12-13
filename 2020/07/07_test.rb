require "minitest/autorun"
require_relative "./07"

describe Rules do
  let(:rules) { Rules.new(input) }
  let(:input) {
    <<~TXT
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    TXT
  }

  describe "containers" do
    let(:subject) { rules.containers }

    it "gets container definitions in a regular way" do
      _(subject.first).must_equal({
        container: "light red",
        contains: {
          :"bright white" => 1,
          :"muted yellow" => 2
        }
      })
    end
  end

  describe "candidates_for" do
    let(:subject) { rules.candidates_for }

    it "lists all direct candidates" do
      _(subject.count).must_equal 4
    end
  end

  describe "contained" do
    let(:subject) { rules.contained }

    describe "first example" do
      it "lists the bags contained within" do
        _(subject).must_equal 32
      end
    end

    describe "second example" do
      let(:input) {
        <<~TXT
          shiny gold bags contain 2 dark red bags.
          dark red bags contain 2 dark orange bags.
          dark orange bags contain 2 dark yellow bags.
          dark yellow bags contain 2 dark green bags.
          dark green bags contain 2 dark blue bags.
          dark blue bags contain 2 dark violet bags.
          dark violet bags contain no other bags.
        TXT
      }

      it "lists the bags contained within" do
        _(subject).must_equal 126
      end
    end
  end
end
