require "test/unit"
require_relative '../src/main'
require_relative '../src/family'

class MainTest < Test::Unit::TestCase
  def setup
    @people = create_people_from("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
    @families = create_families_from(@people)
  end

  def test_create_people_from_file
    assert_equal Array, @people.class
    assert_equal 7, @people.size
    @people.each do |person|
      assert_equal Person, person.class
    end
    assert_equal "Luke", @people.first.first_name
    assert_equal "Wayne", @people[4].last_name
    assert_equal "virgil@rigworkersunion.org", @people[5].email
  end

  def test_create_returns_santa_group_with_expected_familes
    assert_equal 4, @families.size
    assert_equal "Skywalker", @families.first.name
    assert_equal 2, @families.first.size 
    assert_equal "Wayne", @families[2].name
    assert_equal 1, @families[2].size 
  end


end