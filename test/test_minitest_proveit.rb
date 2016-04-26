require "minitest/autorun"
require "minitest/proveit"

module TestMinitest; end

class ProveTest < Minitest::Test
  self.prove_it!

  def self.go(&b)
    Class.new(ProveTest, &b).new(:test_something).run
  end
end

class TestMinitest::TestProve < Minitest::Test
  def test_happy
    tc = ProveTest.go do
      def test_something
        assert true
      end
    end

    assert_predicate tc, :passed?
  end

  def test_sad
    tc = ProveTest.go do
      def test_something
        # do nothing
      end
    end

    refute_predicate tc, :passed?
  end
end
