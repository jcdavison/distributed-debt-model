class Community
  attr_accessor :connections, :members, :loans
  module Error
    class InsufficientNetworkValue < StandardError; end
  end

  def initialize
    @connections = []
    @members = []
    @loans = []
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

  def select_member name
    members.select {|m| m.name == name}.first
  end

  def primary_network_members member_name
    network_member_names = connections.select {|c| c.include? member_name}.flatten.uniq
    members.select {|member| network_member_names.include? member.name}
  end

  def sum_contributions selected_members
    selected_members.map(&:contribution).reduce :+
  end

  def primary_network_contribution_value member_name
    sum_contributions primary_network_members member_name
  end

  def proportional_network_weight member_who_lends, member_to_anchor
    # a member can lend only an amount that reflects the proportion
    # of contribution that member has made to the anchor member's primary lending network
    (member_who_lends.contribution.to_f / primary_network_contribution_value(member_to_anchor.name)).round(2)
  end

  def lend new_loan
    loans.push new_loan
  end

  def sum_loans_lent member
    members_loans =  loans.select {|loan| loan.lendor == member.name}
    return 0 if loans.empty? || members_loans.empty?
    members_loans.map(&:amount).reduce :+
  end
end
