class Community
  attr_accessor :connections, :members

  def initialize
    @connections = []
    @members = []
  end

  def populate people
    people.each do |person|
      members.push person
    end
  end

  def connect name_1, name_2 
    entities = [name_1, name_2]
    connections.push entities unless connections.include? entities
  end

  def network_contribution entity_name
    sum_contributions network_members entity_name
  end

  def network_members entity_name
    names_of_members = connections.select {|c| c.include? entity_name}.flatten.uniq
    members.select {|member| names_of_members.include? member.name}
  end

  def sum_contributions selected_members
    selected_members.map(&:contribution).reduce :+
  end
end

class Person
  attr_accessor :contribution, :name
  def initialize args
    @contribution = args[:contribution]
    @name = args[:name]
  end
end

@community = Community.new

@alice = Person.new({name: 'alice', contribution: 10})
@tom = Person.new({name: 'tom', contribution: 5})
@chris = Person.new({name: 'chris', contribution: 15})
@elise = Person.new({name: 'elise', contribution: 5})
@betty = Person.new({name: 'betty', contribution: 5})
@dan = Person.new({name: 'dan', contribution: 5})

@community.populate([@alice, @tom, @chris, @elise, @betty, @dan])

@community.connect @alice.name, @tom.name
@community.connect @alice.name, @elise.name
@community.connect @alice.name, @chris.name
@community.connect @betty.name, @dan.name
@community.connect @chris.name, @betty.name
