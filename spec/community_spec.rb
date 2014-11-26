require '../community'
require 'rspec'

describe Community do
  context 'Communities are made up of people' do
    before do
      @alice = Person.new({name: 'alice', contribution: 10})
      @tom = Person.new({name: 'tom', contribution: 5})
      @chris = Person.new({name: 'chris', contribution: 15})
      @elise = Person.new({name: 'elise', contribution: 5})
      @betty = Person.new({name: 'betty', contribution: 5})
      @dan = Person.new({name: 'dan', contribution: 5})
      @community = Community.new
    end

    it '.populate()' do
      @community.populate([@alice, @tom, @chris, @elise, @betty, @dan])
      expect(@community.members.count).to be 6
    end

    it '.connect()' do
      @community.connect @alice.name, @tom.name
      expect(@community.connections.count).to be 1
    end

    context 'have awareness of networks within itself.' do
      before do
        @community.populate([@alice, @tom, @chris, @elise, @betty, @dan])
        @community.connect @alice.name, @tom.name
        @community.connect @alice.name, @elise.name
        @community.connect @alice.name, @chris.name
      end

      it '.network_members(member_name)' do
        network_member_names =  @community.network_members('alice').map &:name
        expect(network_member_names).to eq ['alice', 'tom', 'chris', 'elise']
      end

      it '.sum_contributions(members)' do
        members = @community.network_members('alice')
        expect(@community.sum_contributions members).to be 35
      end

      it '.sum_indebtedness(members) ' do
        @alice.indebtedness = -10
        @tom.indebtedness = -5
        members = @community.network_members('alice')
        expect(@community.sum_indebtedness members).to be -15
      end

      it '.network_value(member_name)' do
        expect(@community).to receive(:sum_contributions).once 
        @community.network_value 'alice'
      end

      it '.network_liability(member_name)' do
        expect(@community).to receive(:sum_indebtedness).once 
        @community.network_liability 'alice'
      end

      it '.available_to_network(member_name)' do
        @alice.indebtedness = -5
        expect(@community.available_to_network 'alice').to be 30
      end

      it '.lend(member, amount_within_network_limit)' do
        @community.lend @chris, 10
        expect(@chris.indebtedness).to be -10
      end

      it '.lend(member, amount_greater_than_network_limit)' do
        expect(lambda {@community.lend @chris, 100}).to raise_error Community::Error::InsufficientNetworkValue
      end

      it '.proportional_liability member' do
        @community.lend @chris, 10
        expect(@community.proportional_liability @chris ).to be -6.0
      end
    end
  end
end

