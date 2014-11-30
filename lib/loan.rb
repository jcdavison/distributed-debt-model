class Loan
  attr_accessor :amount, :lendor, :lendee, :timestamp
  def initialize args = {}
    @amount = args[:amount] || 0
    @lendor = args[:lendor] || 'Paul'
    @lendee = args[:lendee] || 'Leto'
    @created_at = set_time_with_seconds 
  end

  def self.build args
    Loan.new args
  end

  def set_time_with_seconds
    Time.now.strftime("%Y-%m-%d %H:%M:%S.%L")
  end
end

