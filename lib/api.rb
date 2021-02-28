require_relative "../lib/modules/findbrewery" 

class FINDBREWERY::API
    

    def initialize
        @url = "https://api.openbrewerydb.org/breweries" 
    end

    def get_and_create_state_data(state)
        brewery_array = HTTParty.get(@url + "?by_state=#{state}" + "&per_page=5") 
        brewery_array.each {|brewery_hash| FINDBREWERY::Brewery.new(brewery_hash)} 
    end
end