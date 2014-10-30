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

      
      
    end
    
  end
end