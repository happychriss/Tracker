require 'test_helper'

class ImplementationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Implementation.new.valid?
  end
end
