require 'test_helper'

class EstimationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Estimation.new.valid?
  end
end
