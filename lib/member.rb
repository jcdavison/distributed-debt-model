class Member
  attr_accessor :contribution, :name
  def initialize args = {}
    @contribution = args[:contribution] || 0
    @name = args[:name] || 'el duderino'
  end
end
