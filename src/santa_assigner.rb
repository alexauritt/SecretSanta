require_relative 'family'

class SantaAssigner
  attr_accessor :people
  def initialize(people)
    @people = clear_santa_targets! people
    @famlies = create_families(@people)
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
  
  def assign_santas!(people)
    @people = clear_santa_targets! people
    @famlies = create_families(@people)
    
    people.each { |person| person.santa_target_id = 4 }
  end
  
private

  def clear_santa_targets! people
    people.each { |person| person.santa_target_id = nil }
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
  
end