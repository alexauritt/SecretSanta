class Person
  include Comparable
  attr_accessor :id, :first_name, :last_name, :email, :santa_target_id, :valid_target_count, :family
  def initialize(id, first, last, email)
    @id, @first_name, @last_name, @email = id, first, last, email
  end
  def full_name
    first_name + " " + last_name
  end
  def <=>(other)
    self.valid_target_count <=> other.valid_target_count
  end
    
end