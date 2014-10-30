require 'rspec'
require './events'

events = [
  { event: 'bill.split', user: 'Ray Green', city: 'Boston', time_of_day: 'morning', timestamp: 23981398 },
  { event: 'promo.used', user: 'Jon Wicks', city: 'New York', time_of_day: 'afternoon', amount: 10.0, timestamp: 93219323 },
  { event: 'promo.used', user: 'Robin Chou', city: 'New York', time_of_day: 'afternoon', amount: 15.0, timestamp: 28138233 },
  { event: 'bill.split', user: 'John Malcom', city: 'Chicago', time_of_day: 'evening', timestamp: 32189389 },
  { event: 'bill.split', user: 'Mark Wang', city: 'Boston', time_of_day: 'evening', timestamp: 43890121 }
]

describe Events do
  context "group_and_count" do
    
    context "counting groups" do
      it "should count 1 if just 1 unique item, 1 level deep" do 
        Events.new([{event: 'a'}]).group_and_count(['event']).should == {"a" => 1}
      end
    end
    
  end
end