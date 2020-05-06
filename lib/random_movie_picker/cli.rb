class RandomMoviePicker::CLI

    def call
        puts "Hi! I'm the Random Movie Picker! 🎬"
        start
    end

    def start
        puts "Which category would you like to specify?"
        puts "1. Genre"
        puts "2. Year"
        puts "3. Suprise me!"

        input = gets.strip.to_i
    end

end