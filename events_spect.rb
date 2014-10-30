require 'rspec'
require './events'

describe Events do
  context "group_and_count" do
    
    context "counting groups" do
      it "should count 1 if just 1 unique item, 1 level deep" do 
        Events.new([{event: 'a'}]).group_and_count(['event']).should == {"a" => 1}
      end
      
      it "should count different groups properly, 1 level deep" do
        Events.new([
          {event: 'a'},
          {event: 'a'},
          {event: 'b'}
        ]).group_and_count(['event']).should == {
          "a" => 2,
          "b" => 1
        }
      end
      
      # Hmmm...actually this test case is NOT specified. Leave for now
      # it "should not include items that do not match the group" do
      #
      #   Events.new([
      #     {event: 'a'},
      #     {something_else: 'blah'}
      #   ]).group_and_count(['event']).should == {
      #     "a" => 1
      #   }
      # end

      it "should count different groups properly, 2 levels deep" do
        Events.new([
          {event: 'a', city: 'x'},
          {event: 'a', city: 'x'},
          {event: 'a', city: 'y'},
          {event: 'b', city: 'x'}
        ]).group_and_count(['event', 'city']).should == {
          "a" => {
            'x' => 2,
            'y' => 1
          },
          "b" => {
            'x' => 1
          }
        }
      end

      it "should not include un-groupped properties in th results" do
        Events.new([
          {event: 'a', city: 'x'},
          {event: 'b', city: 'x', something_esle: 'blah blah'}
        ]).group_and_count(['event', 'city']).should == {
          "a" => {
            'x' => 1,
          },
          "b" => {
            'x' => 1
          }
        }
      end
      
      it "should pass the specified test" do
        events = [
          { event: 'bill.split', user: 'Ray Green', city: 'Boston', time_of_day: 'morning', timestamp: 23981398 },
          { event: 'promo.used', user: 'Jon Wicks', city: 'New York', time_of_day: 'afternoon', amount: 10.0, timestamp: 93219323 },
          { event: 'promo.used', user: 'Robin Chou', city: 'New York', time_of_day: 'afternoon', amount: 15.0, timestamp: 28138233 },
          { event: 'bill.split', user: 'John Malcom', city: 'Chicago', time_of_day: 'evening', timestamp: 32189389 },
          { event: 'bill.split', user: 'Mark Wang', city: 'Boston', time_of_day: 'evening', timestamp: 43890121 }
        ]
        
        Events.new(events).group_and_count(['event','city','time_of_day']).should == {
          "bill.split" => {
             "Boston" => {
               "morning" => 1,
               "evening" => 1
             },
             "Chicago" =>  {
               "evening" => 1
             }
           },
           "promo.used" => {
             "New York" => {
               "afternoon" => 2
             }
           }
        }
        
      end
      
    end
    
  end
end