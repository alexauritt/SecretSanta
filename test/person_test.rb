require 'test/unit'
require_relative '../src/person'

class PersonTest < Test::Unit::TestCase
  def setup
    @p = Person.new(6, "Alex", "Auritt", "alex@alex.com")    
    @q = Person.new(3, "Polly", "Auritt", "polly@polly.com")
  end
  
  def test_new_person
    assert_equal "Alex", @p.first_name
    assert_equal "Auritt", @p.last_name
    assert_equal "alex@alex.com", @p.email
  end
  
  def test_santa_id
    assert_nil @p.santa_target_id
    @p.santa_target_id = 6
    assert_equal 6, @p.santa_target_id
  end
  
  def test_id
    assert_equal 6, @p.id
  end
  
  
end