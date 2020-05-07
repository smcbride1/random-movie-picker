require "pry"

class RandomMoviePicker::CLI

    def call

        clear_terminal
        puts "Hi! I'm the Random Movie Picker! 🎬"
        start

    end

    def start

        select_category

    end

    def select_category

        puts ""
        puts "Which category would you like to pick from?"
        puts "1. Genre 🎭"
        puts "2. Year 📅"
        puts "3. Surprise me! 🎉"

        input = gets.strip.to_i
        
        if input >= 0 && input <= 3
            
            case input
            when 1
                select_genre
            when 2
                select_year
            when 3
                random_movie
            end
        else
            "❌ Sorry, I don't recognize what you mean by '#{input}'."
            select_category
        end

    end
    
    def select_genre

        clear_terminal
        print_genres
        puts ""
        puts "What genre are you looking for? (type in the number)"
        genre = RandomMoviePicker::Categories.genres.keys[gets.strip.to_i - 1]
        if genre != nil
            clear_terminal
            puts "Awesome! Searching for a(n) #{genre} movie, this might take a couple of seconds..."
            new_movie = self.random_by_genre(genre)
            print_movie(new_movie)
            puts ""
            puts "Find another movie? ('y' or 'n')"
            input = gets.strip.downcase
            if input == "y"
                select_genre
            elsif input == "n"
                close
            else
                puts "Sorry, I don't understand what you mean by '#{input}'; going back to start.'"
                start
            end
        else
            puts "Sorry! '#{input}' is not a valid number. Please try again!"
            select_genre
        end

    end

    def select_year

        clear_terminal
        puts ""
        puts "What year are you looking for? (#{RandomMoviePicker::Categories.years.keys[0]} - #{RandomMoviePicker::Categories.years.keys[-1]})"
        year = gets.strip
        if RandomMoviePicker::Categories.years.has_key?(year)
            clear_terminal
            puts "Awesome! Searching for a movie from #{year}, this might take a couple of seconds..."
            new_movie = self.random_by_year(year)
            print_movie(new_movie)
            puts ""
            puts "Find another movie? ('y' or 'n')"
            input = gets.strip.downcase
            if input == "y"
                select_year
            elsif input == "n"
                close
            else
                puts "Sorry, I don't understand what you mean by '#{input}'; going back to start.'"
                start
            end
        else
            puts "Sorry! I couldn't find '#{year}'. Please try again!"
            select_year
        end

    end

    def find_another_movie_message(upon_yes_method)

        puts ""
        puts "Find another movie? ('y' or 'n')"
        input = gets.strip.downcase
        if input == "y"
            self.send(upon_yes_method)
        elsif input == "n"
            close
        else
            puts "Sorry, I don't understand what you mean by '#{input}'; going back to start.'"
            start
        end

    end

    def random_by_genre(genre)

        doc = Nokogiri::HTML(open(RandomMoviePicker::Categories.genres[genre]))
        clear_terminal
        movies = doc.css(".table .unstyled.articleLink")
        new_movie = RandomMoviePicker::Movie.new_from_url(movies[rand(movies.length)].attribute("href").text)
        new_movie

    end

    def random_by_year(year)

        doc = Nokogiri::HTML(open(RandomMoviePicker::Categories.years[year]))
        clear_terminal
        movies = doc.css(".table .unstyled.articleLink")
        new_movie = RandomMoviePicker::Movie.new_from_url(movies[rand(movies.length)].attribute("href").text)
        new_movie

    end

    def random_movie

        clear_terminal
        puts "Working on finding you an amazing movie, this might take a couple of seconds..."
        categories = ["genre", "year"]
        case categories.sample
        when "genre"
            new_movie = self.random_by_genre(RandomMoviePicker::Categories.genres.keys.sample)
            print_movie(new_movie)
            puts ""
            puts "Find another movie? ('y' or 'n')"
            input = gets.strip.downcase
            if input == "y"
                random_movie
            elsif input == "n"
                close
            else
                puts "Sorry, I don't understand what you mean by '#{input}'; going back to start.'"
                start
            end
        when "year"
            new_movie = self.random_by_year(RandomMoviePicker::Categories.years.keys.sample)
            print_movie(new_movie)
            puts ""
            puts "Find another movie? ('y' or 'n')"
            input = gets.strip.downcase
            if input == "y"
                random_movie
            elsif input == "n"
                close
            else
                puts "Sorry, I don't understand what you mean by '#{input}'; going back to start.'"
                start
            end
        end

    end

    def print_genres

        puts "Grabbing content, please wait..."
        genres = RandomMoviePicker::Categories.genres
        clear_terminal
        genres.each_with_index { |genre, i| puts "#{i + 1}. #{genre[0]}" }

    end

    def print_years

        puts "Grabbing content, please wait..."
        years = RandomMoviePicker::Categories.years
        clear_terminal
        years.each_with_index { |year, i| puts "#{i + 1}. #{year[0]}" }

    end

    def print_movie(movie)

        puts "------------------------------  #{movie.title} ------------------------------"
        puts ""
        puts "#{movie.genre}"
        puts ""
        if movie.runtime == ""
            puts "#{movie.year}, #{movie.rating}"
        else
            puts "#{movie.year}, #{movie.rating}, #{movie.runtime}"
        end
        puts ""
        puts "#{movie.description}"
        puts ""
        puts "-----------------------------------------------------------------------------"

    end

    def clear_terminal

        Gem.win_platform? ? (system "cls") : (system "clear")

    end

    def close

        clear_terminal
        puts "Hope you found an awesome movie!"

    end

    #binding.pry

end