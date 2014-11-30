require 'spec_helper'

describe 'LendBot + Community' do
  include_context 'create and populate community'

  before do
    args = {lendee: @alice, amount: 1000, community: @community}
    LendBot.generate_proportional_loans(args)
  end

  context 'Community' do
    it '#primary_network_net_value' do
      expect(@community.primary_network_net_value 'betty').to eq 2070
    end

    it '#primary_network_sum_loans_lent' do
      expect(@community.primary_network_sum_loans_lent 'alice').to eq 1000
    end
  end
end
