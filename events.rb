require './dbc'

class Events
  def initialize(events)
    DBC.require(events.is_a?(Array))
    
    @events = events
  end
  
  def group_and_count(groups)
    DBC.require(groups.is_a?(Array))
    DBC.require(groups.count >= 1)

    result = {}

    groups.each do |g|
      groupped = @events.group_by { |e| e[g.to_sym] }
      groupped.each do |k, v|
        result[k] = v.count
      end
    end
    
    result
  end
end