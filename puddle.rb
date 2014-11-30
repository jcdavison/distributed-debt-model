require './setup.rb'

# create people
@alice = Member.new({name: 'alice', contribution: 10})
@tom = Member.new({name: 'tom', contribution: 5})
@chris = Member.new({name: 'chris', contribution: 15})
@elise = Member.new({name: 'elise', contribution: 5})
@betty = Member.new({name: 'betty', contribution: 5})
@dan = Member.new({name: 'dan', contribution: 5})

# build and populate people
@community = Community.new
@community.populate([@alice, @tom, @chris, @elise, @betty, @dan])

# create connections among people
@community.connect @alice.name, @tom.name
@community.connect @alice.name, @elise.name
@community.connect @alice.name, @chris.name
@community.connect @betty.name, @dan.name
@community.connect @chris.name, @betty.name

LendBot.generate_proportional_loans lendee: @alice, amount: 10, community: @community
