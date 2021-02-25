require_relative "../lib/modules/findbrewery" #the environment hasn't been required so you need to require it again 

class FINDBREWERY::API
    #All data is going to be grabbed here
    def initialize
        @url = "https://api.openbrewerydb.org/breweries" #base url
    end
    
    def get_and_create_brewery_data 
        brewery_array = HTTParty.get(@url) #returns a hash
        brewery_array.each do |brewery_hash| 
            FINDBREWERY::Brewery.new(brewery_hash) #iterates to create each nested hash as an instance 
        end
    end

    def get_and_create_state_data(state)
        puts "___----- GRABBED DATA ---______"
        brewery_array = HTTParty.get(@url + "?by_state=#{state}" + "&per_page=5") #returns a hash
        brewery_array.each do |brewery_hash| 
            FINDBREWERY::Brewery.new(brewery_hash) #iterates to create each nested hash as an instance 
        end
    end
    
    def get_and_create_city_data(city)
        puts "___----- GRABBED DATA ---______"
        brewery_array = HTTParty.get(@url + "?by_city=#{city}" + "&per_page=5") #returns a hash
        brewery_array.each do |brewery_hash| 
            FINDBREWERY::Brewery.new(brewery_hash) #iterates to create each nested hash as an instance 
        end
    end
end