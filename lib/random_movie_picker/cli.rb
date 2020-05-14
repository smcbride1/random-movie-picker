class RandomMoviePicker::CLI

    def call
        select_category
    end

    def select_category
        clear_terminal
        puts "Hi! I'm the Random Movie Picker!"
        puts ""
        puts "Which category would you like to pick from?"
        puts "1. Genre"
        puts "2. Year"
        puts "3. Surprise me!"

        input = gets.strip.to_i

        if input > 0 && input <= 3
            
            case input
            when 1
                select_genre
            when 2
                select_year
            when 3
                select_random_movie
            end
        else
            select_category
        end
    end
    
    def select_genre
        clear_terminal
        print_genres
        puts ""
        puts "What genre are you looking for? (type in the number)"
        input = gets.strip.to_i
        genre = RandomMoviePicker::Genre.all[input - 1] if input > 0
        if genre != nil
            clear_terminal
            puts "Awesome! Searching for a(n) #{genre.name} movie, this might take a couple of seconds..."
            new_movie = RandomMoviePicker::Scraper.random_movie_by_genre(genre)
            clear_terminal
            print_movie(new_movie)
            find_another_movie_message
        else
            select_genre
        end
    end

    def select_year
        clear_terminal
        puts "What year are you looking for? (#{RandomMoviePicker::Year.all[0].name} - #{RandomMoviePicker::Year.all[-1].name})"
        input = gets.strip
        year = RandomMoviePicker::Year.find_by_name(input)
        if year != nil
            clear_terminal
            puts "Awesome! Searching for a movie from #{year.name}, this might take a couple of seconds..."
            new_movie = RandomMoviePicker::Scraper.random_movie_by_year(year)
            clear_terminal
            print_movie(new_movie)
            find_another_movie_message
        else
            select_year
        end
    end

    def select_random_movie
        clear_terminal
        puts "Working on finding you an amazing movie, this might take a couple of seconds..."
        categories = ["genre", "year"]
        case categories.sample
        when "genre"
            new_movie = RandomMoviePicker::Scraper.random_movie_by_genre(RandomMoviePicker::Genre.random_genre)
            clear_terminal
            print_movie(new_movie)
            find_another_movie_message
        when "year"
            new_movie = RandomMoviePicker::Scraper.random_movie_by_year(RandomMoviePicker::Year.random_year)
            clear_terminal
            print_movie(new_movie)
            find_another_movie_message
        end
    end

    def find_another_movie_message
        puts ""
        puts "Find another movie? ('y' or 'n')"
        input = gets.strip.downcase
        if input == "y"
            select_category
        elsif input == "n"
            close
        else
            select_category
        end
    end

    def print_genres
        puts "Grabbing content, please wait..."
        clear_terminal
        RandomMoviePicker::Genre.names.each_with_index { |genre, i| puts "#{i + 1}. #{genre}" }
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

end