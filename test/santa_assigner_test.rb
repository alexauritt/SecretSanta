require "test/unit"
require 'mocha'
require_relative "../src/main"
require_relative "../src/santa_assigner"
require_relative "../src/person"

class SantaAssignerTest < Test::Unit::TestCase
  def setup
    @person1 = Person.new(2,"Fred","James","asdf@asdf.com")
    @person2 = Person.new(3,"Mark","James","mark@asdf.com")
    @person3 = Person.new(4,"Missy","Pents","asdfasdf@asdf.com")
    @person4 = Person.new(5, "Audrey", "Frantics", "audsbauds@asd.com")

    @people = create_people_from("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
    @assigner = SantaAssigner.new @people
  end

  def test_create_families_creates_expected_familes
    families = @assigner.families
    assert_equal 4, families.size
    assert_equal "Skywalker", families.first.name
    assert_equal 2, families.first.size 
    assert_equal "Wayne", families[2].name
    assert_equal 1, families[2].size 
  end
  
  def test_assigned_targets_direct_from_file
    assert_equal [], @assigner.send(:assigned_targets)
  end

  def test_unassigned_targets_direct_from_file
    unassigned = @assigner.send(:unassigned_targets)
    unassigned.uniq!
    assert_equal 7, unassigned.size
  end
  
  def test_assigned_and_unassigned_targets
    assigner = SantaAssigner.new([])
    @person3.santa_target_id = @person1.id
    assigner.people = [@person1,@person2,@person3]
    
    assert_equal [@person1], assigner.send(:assigned_targets)
    assert_equal [@person2,@person3], assigner.send(:unassigned_targets)
  end
  
  def test_assert_raise_if_person_with_target_id_passed_in
    @person1.santa_target_id = 4
    assert_raise ArgumentError do
      SantaAssigner.new([@person1])
    end
  end
  
  def test_find_family_by_name
    fam = @assigner.send(:find_family_by_name, "Brigman")
    assert_equal "Brigman", fam.name
    assert_equal 2, fam.size
  end
  
  def test_initial_valid_target_counts_are_calculated_as_expected
    @assigner.people.size - 1.times do |index|
      assert_equal 5, @assigner.people[index].valid_target_count
    end
    
    expected_person_with_no_family = @assigner.people.last
    assert_equal 6, expected_person_with_no_family.valid_target_count
    assert_equal "Wayne", expected_person_with_no_family.last_name
  end

  def test_people_with_no_targets_assigned_is_initially_full
    assert_equal @people, @assigner.send(:people_with_no_targets_assigned)
  end
  
  def test_people_with_no_targets_assigned_is_empty_after_assignment
    @assigner.assign_santas!
    assert @assigner.send(:people_with_no_targets_assigned).empty?
  end
  
  def test_fussiest_person_with_no_target
    assert_equal 5, @assigner.send(:fussiest_person_with_no_target).valid_target_count
  end
    
  def test_find_acceptable_target_for
    assigner = SantaAssigner.new([@person1,@person2,@person3]) #persons 1 and 2 from same family, person 3 from diff. see setup
    assert_equal @person3, assigner.send(:find_acceptable_target_for, @person1)
  end
  
  def test_decrement_valid_target_counts!
    assigner = SantaAssigner.new([@person1,@person2,@person3,@person4])
    assert_equal 2, @person1.valid_target_count
    assert_equal 2, @person2.valid_target_count
    assert_equal 3, @person3.valid_target_count
    assert_equal 3, @person4.valid_target_count
    
    @person1.santa_target_id = @person3.id
    
    assigner.send(:decrement_valid_target_counts!, @person3)
    
    assert_equal 1, @person2.valid_target_count
    assert_equal 3, @person3.valid_target_count
    assert_equal 2, @person4.valid_target_count    
  end
  
  def test_assign_santas
    @assigner.assign_santas!
  
    assert_no_santa_targets_are_nil(@people)
    assert_each_santa_target_unique(@people)
  end

  private

  def assert_no_santa_targets_are_nil(people)
    people.each do |person|
      assert_not_nil person.santa_target_id, "At least one person was not assigned a santa target"
    end  
  end

  def assert_each_santa_target_unique(people)
    ids = people.collect { |p| p.santa_target_id }
    assert_nil ids.uniq!, "More than one person was a assigned the same santa target"
  end
end