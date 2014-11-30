require 'spec_helper'

describe 'LendBot + Community' do
  include_context 'create and populate community'
  context 'Community' do
    it '#primary_network_net_value' do
      args = {lendee: @alice, amount: 1000, community: @community}
      LendBot.generate_proportional_loans(args)
      expect(@community.primary_network_net_value 'betty').to eq 2070
    end
  end
end
