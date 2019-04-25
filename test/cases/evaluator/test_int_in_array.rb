require "helper"

class IntInArrayTest < ::Minitest::Test
  attr_reader :instructions

  def setup
    @instructions = [["lit", 1], ["array", [1, 2]], ["compare", "IN"]]
  end

  def test_with_no_context
    context = nil
    expected_result = true

    e = ::Predicator::Evaluator.new instructions, context
    assert_equal expected_result, e.result
    assert_empty e.stack
  end

end
