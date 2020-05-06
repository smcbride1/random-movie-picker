require "open-uri"
require "nokogiri"
require "pry"
require_relative "./movie.rb"
require_relative "../concerns/finder.rb"
require_relative "../concerns/finder.rb"

class RandomMovie

    extend Finder

    BASE_URL = "https://www.rottentomatoes.com"

    @@genres = {}
    @@years = {}

    def self.random_by_genre(genre)

        doc = Nokogiri::HTML(open(self.genres[genre]))
        movies = doc.css(".table .unstyled.articleLink").map do |movie|
            if Finder.find_by_movie_title(white_space_fix(movie.text)).length == 0
                new_movie = Movie.new
                new_movie.title = white_space_fix(movie.text)
                new_movie.url = movie.attribute("href").text
            else
                find_by_movie_title(title)
            end
        end

        movies.sample
        
    end

    def self.random_by_year(year)
    end

    def self.genres

        if @@genres = {}
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/top_100_action__adventure_movies/"))
            doc.css(".btn-group.btn-primary-border-dropdown li a").each do |genre|
                @@genres[white_space_fix(genre.text)] = BASE_URL + genre.attribute("href").text
            end
            @@genres
        else
            @@genres
        end

    end

    def self.years

        if @@years = {}
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=2020"))
            @@years = doc.css(".btn-group.btn-primary-border-dropdown li a").map do |year|
                @@years[white_space_fix(year.text)] = BASE_URL + year.attribute("href").text
            end
            @@years
        else
            @@years
        end

    end

    def self.white_space_fix(text)
        text.split("\n")[1].strip
    end

    binding.pry

end