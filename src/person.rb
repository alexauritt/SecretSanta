class Person
  attr_accessor :id, :first_name, :last_name, :email, :santa_target_id
  def initialize(id, first, last, email)
    @id, @first_name, @last_name, @email = id, first, last, email
  end

end