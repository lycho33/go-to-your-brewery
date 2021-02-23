class FINDBREWERY::CLI
#get inputs and show string/display 
     def run
        greeting
        FINDBREWERY::API
        menu
     end

     def greeting
        puts "Welcome to the Brewery Index"
        puts "Grabbing Data... Loading..."
     end

     def menu
        puts "pick something from menu"
     end
end