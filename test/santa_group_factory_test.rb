require 'test/unit'
require_relative '../src/santa_group_factory'
require_relative '../src/santa_group'
class SantaGroupTest < Test::Unit::TestCase
  def setup
    @santa_group = SantaGroupFactory.create_from_file("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
  end
  
  def test_create_returns_santa_group
    assert_equal SantaGroup, @santa_group.class
    people = @santa_group.people
    assert_equal 7, people.size
    people.each do |person|
      assert_equal Person, person.class
    end
    assert_equal "Luke", people.first.first_name
    assert_equal "Wayne", people[4].last_name
    assert_equal "virgil@rigworkersunion.org", people[5].email
  end
  
  def test_create_returns_santa_group_with_expected_familes
    familes = @santa_group.families
    assert_equal 4, familes.size
    assert_equal "Skywalker", familes.first.name
    assert_equal 2, familes.first.size 
    assert_equal "Wayne", familes[2].name
    assert_equal 1, familes[2].size 
  end
end