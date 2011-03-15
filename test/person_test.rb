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
  
  
end