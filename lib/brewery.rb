class FINDBREWERY::Brewery
  
    @@all = [] 
    
    def initialize(brewery_hash)
        brewery_hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        @@all << self
    end

    def self.find_or_create_by_state(state)
        if self.all.find {|b| b.state == state} != nil
            return self.all.each {|b| b.state == state.capitalize}
        else
            FINDBREWERY::API.new.get_and_create_state_data(state.split.join("%20"))
            return self.all.each {|b| b.state == state.capitalize}
        end
    end

    def self.find_type_of_beer(type)
        self.all.select {|brewery| brewery.brewery_type == type}
    end

    def self.all
        @@all
      
    end

end