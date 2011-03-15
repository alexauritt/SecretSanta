require "test/unit"
require_relative "../src/main"
require_relative "../src/santa_assigner"

class SantaAssignerTest < Test::Unit::TestCase
  def setup
    @people = create_people_from("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
    @assigner = SantaAssigner.new @people
  end

  def test_create_families_creates_expected_familes
    @families = @assigner.send(:create_families, @people)
    assert_equal 4, @families.size
    assert_equal "Skywalker", @families.first.name
    assert_equal 2, @families.first.size 
    assert_equal "Wayne", @families[2].name
    assert_equal 1, @families[2].size 
  end
  
  def test_assign_santas
    @assigner.assign_santas!(@people)

    @people.each do |person|
      assert_not_nil person.santa_target_id
    end
  end
  
  def test_assigned_targets_direct_from_file
    assert_equal [], @assigner.assigned_targets
  end

  def test_unassigned_targets_direct_from_file
    unassigned = @assigner.unassigned_targets
    unassigned.uniq!
    assert_equal 7, unassigned.size
  end
  
  def test_assigned_and_unassigned_targets
    assigner = SantaAssigner.new([])
    person1 = Person.new(2,"Fred","Jims","asdf@asdf.com")
    person2 = Person.new(3,"Mark","James","mark@asdf.com")
    person3 = Person.new(4,"Missy","Pents","asdfasdf@asdf.com")
    person3.santa_target_id = person1.id
    assigner.people = [person1,person2,person3]
    
    assert_equal [person1], assigner.assigned_targets
    assert_equal [person2,person3], assigner.unassigned_targets
  end
end