require './dbc'
require 'active_support'

class Events
  def initialize(events)
    DBC.require(events.is_a?(Array))
    
    @events = events
  end
  
  def group_and_count(groups, events = @events)
    DBC.require(groups.is_a?(Array))
    DBC.require(groups.count >= 1)
    
    group = groups.first.to_sym

    result = events.group_by { |e| e[group] }
    if groups.count == 1
      result.each do |k, v|
        result[k] = v.count
      end
    else
      result.each do |k, v|
        result[k] = group_and_count(groups.last(groups.count-1), v)
      end
    end
    
    result
  end
  
end