class LendBot
  attr_accessor :lendee, :amount, :community, :proportional_loans

  def initialize args
    @lendee               = args[:lendee]
    @amount               = args[:amount]
    @community            = args[:community]
    @proportional_loans   = []
    calculate_proportional_loans
  end

  def calculate_proportional_loans
    community.primary_network_members(lendee_name).each do |member| 
      proportional_loans.push({lendor: member, amount: weighted_loan_value(member)})
    end
  end

  def weighted_loan_value member
    (community.proportional_network_weight(member, community_member(lendee_name)) * amount).round 0
  end

  def proportional_loan_lendor proportional_loan
    proportional_loan[:lendor].name
  end

  def community_member lendee_name
    community.select_member lendee_name 
  end

  def self.generate_proportional_loans args
    lendbot = LendBot.new args
    if lendbot.all_members_can_lend?
      lendbot.proportional_loans.each do |proportional_loan|
        new_loan = lendbot.build_new_loan lendee: lendbot.lendee_name, 
          amount: proportional_loan[:amount], 
          lendor: lendbot.proportional_loan_lendor(proportional_loan)
        lendbot.community.lend new_loan
      end
    end
  end

  def build_new_loan args
    Loan.build args
  end

  def all_members_can_lend? 
    proportional_loans.all? do |proportional_loan|
      can_lend? proportional_loan
    end
  end

  def can_lend? args
    args[:amount] <= available_to_lend(args[:lendor])
  end

  def available_to_lend member
    member.contribution + sum_loans_lent(member) 
  end

  def sum_loans_lent member
    community.sum_loans_lent member
  end

  def lendee_name
    lendee.name
  end
end
