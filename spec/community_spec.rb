require 'spec_helper'

describe Community, :type=> :model do
  context 'Communities are made up of people' do
    include_context 'create community'

    it '#populate()' do
      @community.populate [@alice, @tom, @chris, @elise, @betty, @dan] 
      expect(@community.members.count).to be 6
    end

    it '#connect()' do
      @community.connect @alice.name, @tom.name
      expect(@community.connections.count).to be 1
    end

    it '#select_member(member_name)' do
      @community.populate [@tom, @chris, @alice]
      person_who_is_alice = @community.select_member('alice')
      expect(person_who_is_alice.name).to eq 'alice'
    end

    context 'they have awareness of networks within themselves.' do
      before do
        @community.populate([@alice, @tom, @chris, @elise, @betty, @dan])
        @community.connect @alice.name, @tom.name
        @community.connect @alice.name, @elise.name
        @community.connect @alice.name, @chris.name
      end

      it '#primary_network_members(member_name)' do
        primary_network_member_names =  @community.primary_network_members('alice').map &:name
        expect(primary_network_member_names).to eq ['alice', 'tom', 'chris', 'elise']
      end

      it '#sum_contributions(members)' do
        members = @community.primary_network_members('alice')
        expect(@community.sum_contributions members).to be 35
      end

      it '#primary_network_contribution_value(member_name)' do
        expect(@community).to receive(:sum_contributions).once 
        @community.primary_network_contribution_value 'alice'
      end

      it '#proportional_network_weight' do
        expect(@community.proportional_network_weight(@tom, @alice)).to eq(0.1428571429)
      end
    end

    context 'they know how to lend' do
      it '#lend(loan)' do
        MockLoan = Struct.new :value
        loan = MockLoan.new 10
        @community.lend loan
        expect(@community.loans.first.value).to eq 10
      end
    end
  end
end
