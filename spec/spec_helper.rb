require 'rspec'

Dir["./lib/*.rb"].sort.each {|file| require file }

require 'support'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
