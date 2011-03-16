require_relative 'family'

class SantaAssigner
  attr_accessor :people, :families
  def initialize(people)    
    @people = people
    @families = create_families(@people)

    set_family_references!
    ensure_no_targets_are_set!
    calculate_initial_valid_targets!
    sort_by_flexibilty!
  end

  def assign_santas!
    until people_with_no_targets_assigned.empty?
      santa = fussiest_person_with_no_target
      target = find_acceptable_target_for(santa)
      santa.santa_target_id = target.id
    end
  end

  def print_list!
    people.each do |p|
      puts "#{p.full_name} will give to #{find_person_by_id(p.santa_target_id).full_name}"
    end
  end
  
  private

  def people_with_no_targets_assigned
    no_targs = people.select {|p| p.santa_target_id == nil }
    no_targs.sort_by! { |p| p.valid_target_count }
  end

  def find_acceptable_target_for(person)
    acceptable_targets = unassigned_targets.delete_if {|p| same_family?(p,person) }
    acceptable_targets[rand(acceptable_targets.size)]
  end

  def fussiest_person_with_no_target
    people_with_no_targets_assigned.first
  end

  def assigned_targets
    targets = @people.map {|p| p.santa_target_id }
    targets.compact!
    targets.uniq!
    @people.select { |p| targets.include? p.id }
  end

  def unassigned_targets
    @people - assigned_targets
  end

  def set_family_references!
    @people.each {|p| p.family = find_family_by_name(p.last_name) }
  end

  def all_targets_nil?
    targets = @people.collect {|p| p.santa_target_id }
    targets.compact!
    targets.empty?
  end
  
  def find_family_by_name(name)
    @families.find { |fam| fam.name == name }
  end
  
  def ensure_no_targets_are_set!
    init_error = ArgumentError.new("SantaAssigner was initialized with at least one person that already has a target santa!")
    raise init_error unless all_targets_nil?
  end
  
  def calculate_initial_valid_targets!
    @people.each { |p| p.valid_target_count = @people.size - p.family.size }
  end
  
  def sort_by_flexibilty!
    @people.sort_by! { |p| p.valid_target_count }
  end

  def create_families(people)
    families = initialize_families_from(people)
    calculate_family_size(people, families)
  end

  def initialize_families_from(people)
    family_names = people.map { |person| person.last_name }
    family_names.uniq!
    families = family_names.map { |name| Family.new(name) }  
  end

  def calculate_family_size(people, families)
    families.each do |family|
      family.size = people.count {|person| person.last_name == family.name }
    end
  end
  
  def same_family?(person1, person2)
    person1.last_name == person2.last_name
  end
  
  def find_person_by_id(id)
    @people.find {|p| p.id == id }
  end
  
end