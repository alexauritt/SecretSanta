require_relative 'person'

class PersonFactory
  def self.create_from_file(file)
    list = []
    count = 1
    IO.foreach(file) do |line|
      info = line.split
      list << Person.new(count,info[0],info[1],info[2].delete('<>'))
      count += 1
    end
    list
  end
end