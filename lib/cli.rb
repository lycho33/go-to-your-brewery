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
        puts "Welcome to the Brewery Index!".colorize(:yellow)
        puts ""
        puts "Here we will help you find breweries within your vicinity."
     end

     def menu
            first_question
            second_question
            type_of_beer
            goodbye
     end

     def goodbye
         puts ""
         puts "Hope this helped you and make sure to check out those breweries!"
         puts ""
         puts "Would you like to see more breweries in other states or cities?"
         puts "If so, please type menu. If not, please type exit"
         if grab_input == "exit"
            exit
         else
            menu
         end
      end
#-------------------------------------------------------------------------------------Question 1------------------------------
     def first_question
      puts "Which state do you reside in?".colorize(:green)
      input = grab_input
      FINDBREWERY::API.new.get_and_create_state_data(input.split.join("_"))
      #if input == #{}  NEED AN ERROR CHECK
      state_selection(input)
     end

     def state_selection(state)
      puts "Here are examples of the first 5 breweries in your state. Now let's figure out what breweries are in your city." 
      breweries = FINDBREWERY::Brewery.find_or_create_by_state_or_city(state)
      display(breweries)
     end

     def display(breweries)
      breweries.each.with_index(1) {|brewery, index| puts "#{index}. #{brewery.name}"}
      end

    def grab_input
      state = gets.chomp.downcase 
         if state.include?(" ")
            return state.split.join("%20")
         end
            return state
    end
#--------------------------------------------------------------------------------Question 2--------------------------------
    def second_question
      puts ""
      puts "Which city do you live in?".colorize(:green)
      input = grab_input
      FINDBREWERY::API.new.get_and_create_city_data(input.split.join("%20"))
      city_selection(input)
    end
    def city_selection(city)
      puts "Here are examples of the first 5 breweries in your state"
      breweries = FINDBREWERY::Brewery.find_or_create_by_city(city)
      display(breweries)
     end
#---------------------------------------------------------------------Question 3-------------------------------------------
   def type_of_beer
      puts ""
      puts "Now that we know where you're located. We want to help you select the right type of brewery."
      puts "Here is a list of the types of breweries."
      table = Terminal::Table.new :headings => ['Type', 'Description'] do |t|
         t << ['Micro', 'A small brewery that brews craft beer.']
         t.add_row ['Regional', "A regional location of an expanded brewery."]
         t.add_row ['Brewpub', "A beer-focused restaurant or restaurant/bar with a brewery on-premise."]
         t.add_row ['Contract', "A brewery that uses another brewery's equipment."]
         t.add_row ['Planning', "A brewery in planning or not yet opened to the public."]
       end
      puts table
      puts ""
      puts "Use the up or down arrow key to....."
      prompt = TTY::Prompt.new
      select_input = prompt.select("Select the type of brewery you are looking for.".colorize(:green), display_all)
      brewery = FINDBREWERY::Brewery.find_type_of_beer(select_input)
      display_type(brewery)
   end
   
   def display_all
      FINDBREWERY::Brewery.all.collect  {|brewery| brewery.brewery_type}.uniq
   end

   def display_type(breweries)
      puts "       "
      puts "Here's a list of breweries near you associated with the type of brewery you like."
      puts "***".colorize(:yellow) + "Note that some types of brewery may not be in your area and will recommend that specific type of brewery in another state or area."
      breweries.each.with_index(1) do |brewery, index|
         puts ""
         puts "Name: #{brewery.name}"
         puts "Website: #{brewery.website_url.colorize(:blue)}"
         puts "Phone: #{brewery.phone}"
         puts "Address: #{brewery.street} #{brewery.city}, #{brewery.state} #{brewery.postal_code}"
         puts ""
      end
   end
end