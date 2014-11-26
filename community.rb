class Community
  attr_accessor :connections, :members
  module Error
    class InsufficientNetworkValue < StandardError; end
  end

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
    relationship = [name_1, name_2]
    connections.push relationship unless connections.include? relationship
  end

  def network_members entity_name
    names_of_members = connections.select {|c| c.include? entity_name}.flatten.uniq
    members.select {|member| names_of_members.include? member.name}
  end

  def network_value entity_name
    sum_contributions network_members entity_name
  end

  def network_liability entity_name
    sum_indebtedness network_members entity_name
  end

  def proportional_liability member
    share_network_value =  member.contribution.to_f / network_value(member.name)
    (share_network_value * network_liability(member.name)).round 2
  end

  def available_to_network entity_name
    network_value(entity_name) + network_liability(entity_name)
  end

  def sum_contributions selected_members
    selected_members.map(&:contribution).reduce :+
  end

  def sum_indebtedness selected_members
    selected_members.map(&:indebtedness).reduce :+
  end

  def lend member, amount
    if available_to_network(member.name) >= amount
      member.indebtedness = -amount
    else
      raise Error::InsufficientNetworkValue
    end
  end
end

class Person
  attr_accessor :contribution, :name, :indebtedness
  def initialize args
    @contribution = args[:contribution] || 0
    @name = args[:name] || 'el duderino'
    @indebtedness = args[:indebtedness] || 0
  end
end
