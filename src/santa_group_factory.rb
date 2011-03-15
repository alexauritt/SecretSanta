require_relative 'person'
require_relative 'family'
class SantaGroupFactory
  def self.create_from_file(file)
    people = []
    families = []
    count = 1
    IO.foreach(file) do |line|
      info = line.split
      first_name, family_name, email = info[0], info[1], info[2].delete('<>')
      people << Person.new(count, first_name, family_name, email)
      match = families.select {|fam| fam.name == family_name }
      if match.empty?
        families << Family.new(family_name)
      else
        match.first.increment
      end
      count += 1
    end
    SantaGroup.new(families,people)
  end
end