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
      
      # Hmmm...actually this test case is specified. Leave for now
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
      
      
    end
    
  end
end