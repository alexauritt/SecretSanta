require 'test/unit'
require_relative '../src/person_factory'

class PersonFactoryTest < Test::Unit::TestCase
  def setup
    @people = PersonFactory.create_from_file("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
  end
  
  def test_create
    assert_equal 7, @people.size
    @people.each do |person|
      assert_equal Person, person.class
    end
    assert_equal "Luke", @people.first.first_name
    assert_equal "Wayne", @people[4].last_name
    assert_equal "virgil@rigworkersunion.org", @people[5].email
  end
end