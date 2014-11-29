RSpec.shared_context 'create community', :a => :b do
  before do
    @alice = Member.new({name: 'alice', contribution: 10})
    @tom = Member.new({name: 'tom', contribution: 5})
    @chris = Member.new({name: 'chris', contribution: 15})
    @elise = Member.new({name: 'elise', contribution: 5})
    @betty = Member.new({name: 'betty', contribution: 5})
    @dan = Member.new({name: 'dan', contribution: 5})
    @community = Community.new
  end
end


RSpec.shared_context 'create and populate community', :a => :b do
  include_context 'create community'
  before do
    @community.populate([@alice, @tom, @chris, @elise, @betty, @dan])
    @community.connect @alice.name, @tom.name
    @community.connect @alice.name, @elise.name
    @community.connect @alice.name, @chris.name
  end
end
