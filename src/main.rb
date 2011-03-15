require_relative 'person'
require_relative 'santa_assigner'

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

# people = create_people_from("/Users/alexauritt/Programming/RubyDev/rubyquiz/secret_santa/test/samples/persons.txt")
# sa = SantaAssigner.new(people)
# sa.assign_santas!
# sa.print_list!
