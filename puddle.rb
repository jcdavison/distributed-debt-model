require './community'

# create people
@alice = Person.new({name: 'alice', contribution: 10})
@tom = Person.new({name: 'tom', contribution: 5})
@chris = Person.new({name: 'chris', contribution: 15})
@elise = Person.new({name: 'elise', contribution: 5})
@betty = Person.new({name: 'betty', contribution: 5})
@dan = Person.new({name: 'dan', contribution: 5})

# build and populate people
@community = Community.new
@community.populate([@alice, @tom, @chris, @elise, @betty, @dan])

# create connections among people
@community.connect @alice.name, @tom.name
@community.connect @alice.name, @elise.name
@community.connect @alice.name, @chris.name
@community.connect @betty.name, @dan.name
@community.connect @chris.name, @betty.name

# make a loan to alice

@community.lend @alice, 5
