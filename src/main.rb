require_relative 'person'

def create_people_from(file)
  people = []
  count = 1
  IO.foreach(file) do |line|
    info = line.split
    first_name, family_name, email = info[0], info[1], info[2].delete('<>')
    people << Person.new(count, first_name, family_name, email)
    count += 1
  end
  people
end

def create_families_from(people)
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
