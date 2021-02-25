class FINDBREWERY::Brewery
    #Where the data is going to be stored
    @@all = [] #array of objects
    #attr_accessor :id, :name, :brewery_type
    def initialize(brewery_hash)
        brewery_hash.each do |key, value|
            self.class.attr_accessor(key) #created an attr_accessor key (ex. ID)
            #self.id= 4581/ setter 
            self.send(("#{key}="), value) #send creates a method #self is an instance of brewery
        end
        @@all << self #object 
    end

    def self.find_or_create_by_state_or_city(state)
        new_state = ""
        if state.include?("%20")
            new_state = state.split("%20").map {|x| x.capitalize}.join(" ")
        else
            new_state = state.capitalize 
        end
        self.all.select {|brewery| brewery.state == new_state}
    end

    def self.find_or_create_by_city(city)
        new_city = ""
        if city.include?("%20")
            new_city = city.split("%20").map {|x| x.capitalize}.join(" ")
        else
            new_city = city.capitalize 
        end
        self.all.select {|brewery| brewery.city == new_city}
    end

    def self.all
        @@all
    end

end