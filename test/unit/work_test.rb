require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Work.new.valid?
  end
end
