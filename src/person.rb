class Person
  attr_accessor :id, :first_name, :last_name, :email
  def initialize(id, first, last, email)
    @first_name, @last_name, @email = first, last, email
  end

end