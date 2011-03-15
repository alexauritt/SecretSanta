class Person
  attr_accessor :id, :first_name, :last_name, :email, :santa_target_id, :valid_target_count, :family
  def initialize(id, first, last, email)
    @id, @first_name, @last_name, @email = id, first, last, email
  end

end