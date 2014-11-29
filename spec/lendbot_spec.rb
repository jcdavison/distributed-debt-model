require 'spec_helper'

describe LendBot, :type=> :model do
  context 'is in charge of lending' do
    include_context 'create and populate community'

    before do
      @lendbot_proc = Proc.new {LendBot.new(lendee: @alice, amount: 10, community: @community)}
      @lendbot = LendBot.new(lendee: @alice, amount: 10, community: @community)
    end

    context 'and can be tempermental' do
      it 'and will complain if not fed correctly.' do
        bad_lendbot = Proc.new {LendBot.new}
        expect(bad_lendbot).to raise_error ArgumentError
      end

      it 'but plays nice with the propery intitialization arguments' do
        expect(@lendbot_proc).not_to raise_error
      end
    end

    context '#calculate_proportional_loans()' do
      it '#proportional_loans == 4'  do
        expect(@lendbot.proportional_loans.length).to eq 4
      end

      it '#proportional_loans.select { loan.value == 1.428}.count == 2' do
        loan_count = @lendbot.proportional_loans.select {|l| l[:amount] == 1.428571429}.length
        expect(loan_count).to eq 2
      end
    end

    it '#weighted_loan_value member' do
      expect(@lendbot.weighted_loan_value @chris).to eq 4.285714286
    end

    it '#proportional_loan_lendor' do
      alice = @lendbot.proportional_loans.first
      expect(@lendbot.proportional_loan_lendor alice).to eq 'alice'
    end

    it '#community_member member_name' do
      expect(@lendbot.community).to receive :select_member
      @lendbot.community_member 'someone'
    end
  end

  context 'LendBot.generate_proportional_loans' do
    include_context 'create and populate community'
    before do
      args = {lendee: @alice, amount: 10, community: @community}
      LendBot.generate_proportional_loans(args)
    end
    it '#community.loans.count == 4' do
      expect(@community.loans.count).to eq 4
    end

    it '#community.loans.select(loan.lendor.name == tom).first.value == 12.33' do
      expect(@community.loans.select {|loan| loan.lendor == 'tom'}.first.amount).to eq 1.428571429
    end

    it '#all_members_can_lend?' do
      expect_any_instance_of(LendBot).to receive :all_members_can_lend? 
      args = {lendee: @alice, amount: 10, community: @community}
      LendBot.generate_proportional_loans(args)
    end

    it '#build_new_loan' do
      expect_any_instance_of(LendBot).to receive(:build_new_loan).exactly(4).times
      args = {lendee: @alice, amount: 10, community: @community}
      LendBot.generate_proportional_loans(args)
    end
  end
end
