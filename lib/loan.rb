class Loan
  attr_accessor :amount, :lendor, :lendee, :timestamp
  def initialize args = {}
    @amount = args[:amount] || 0
    @lendor = args[:lendor] || 'Paul'
    @lendee = args[:lendee] || 'Leto'
    @timestamp = Time.now.to_i
  end

  def self.build args
    Loan.new args
  end
end

