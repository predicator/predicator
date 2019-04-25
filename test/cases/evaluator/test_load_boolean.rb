require "helper"

class LoadBooleanTest < ::Minitest::Test
  attr_reader :instructions

  def setup
    @instructions = [["load", "bool_var"], ["to_bool"]]
  end

  def test_with_no_context
    context = nil
    expected_result = false

    e = ::Predicator::Evaluator.new instructions, context
    assert_equal expected_result, e.result
    assert_empty e.stack
  end

  def test_with_false
    context = {"bool_var"=>false}
    expected_result = false

    e = ::Predicator::Evaluator.new instructions, context
    assert_equal expected_result, e.result
    assert_empty e.stack
  end

  def test_with_true
    context = {"bool_var"=>true}
    expected_result = true

    e = ::Predicator::Evaluator.new instructions, context
    assert_equal expected_result, e.result
    assert_empty e.stack
  end

end
