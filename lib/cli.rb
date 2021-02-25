class FINDBREWERY::CLI
#get inputs and show string/display 
   def initialize
      FINDBREWERY::API.new.get_and_create_brewery_data # Data from API
   end

   def run
      greeting
      menu
   end

     def greeting
        puts ""
        puts "Welcome to the Brewery Index!"
        puts ""
        puts "Here we will help you find breweries within your vicinity."
        #puts "Grabbing Data... Loading..."
     end

     def menu
         # until @input == "exit"
         #    questionnaire #show state/city/type
         # end
         # exit
         #give the option to go back
         first_question
         # second_question
         # type_of_beer
     end

#-------------------------------------------------------------------------------------Question 1------------------------------
     def first_question
      puts "Which state do you reside in?"
      input = grab_input
      FINDBREWERY::API.new.get_and_create_state_data(input.split.join("_"))
      #if input == #{}  NEED AN ERROR CHECK
      state_selection(input)
     end

     def state_selection(state)
      puts "Here are the first 5 breweries in your state"
      breweries = FINDBREWERY::Brewery.find_or_create_by_state_or_city(state)
      display(breweries)
     end

     def display(breweries)
      breweries.each.with_index(1) {|brewery, index| puts "#{index}. #{brewery.name}"}
         #grab_input
      end

    def grab_input
      state = gets.chomp.downcase 
         if state.include?(" ")
            return state.split.join("%20")
         end
            return state
      if @input == "exit"
         exit
      end
    end

    #--------------------------------------------------------------------------------Question 2--------------------------------
    def second_question
      puts ""
      puts "Which city do you live in?"
      input = grab_input
      FINDBREWERY::API.new.get_and_create_city_data(input.split.join("%20"))
      city_selection(input)
    end
    def city_selection(city)
      puts "Here are the first 10 breweries in your state"
      breweries = FINDBREWERY::Brewery.find_or_create_by_city(city)
      display(breweries)
     end
#---------------------------------------------------------------------Question 3-------------------------------------------
   def type_of_beer
      puts ""
      puts "Now that we know where you're located. Use the up or down arrow key to....."
      prompt = TTY::Prompt.new
      select_input = prompt.select("Select the type of beer you like.", display_all)
      brewery = FINDBREWERY::Brewery.find_type_of_beer(select_input)

   end
   
   def display_all
      FINDBREWERY::Brewery.all.collect do |brewery|
         brewery.brewery_type
      end
   end

   def display_type(breweries)
      puts "Here's a list of the breweries near you with the type of beer you like."
      breweries.each.with_index(1) do |brewery, index|
         puts ""
         puts "Name: #{brewery.name}"
         puts "Website: #{brewery.website_url}"
         puts "Phone: #{brewery.phone}"
         puts "Address: #{brewery.street} #{brewery.city}, #{brewery.state} #{brewery.postal_code}"
         puts ""
      end
   end
end