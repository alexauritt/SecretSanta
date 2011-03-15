class Family
  attr_accessor :name, :size
  def initialize(name)
    @name = name
    @size = 1
  end
  def increment
    @size += 1
  end
end