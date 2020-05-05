require "open-uri"
require "nokogiri"
require "pry"
require_relative "./movie.rb"
require_relative "../concerns/finder.rb"

class RandomMovie

    extend Finder

    BASE_URL = "https://www.rottentomatoes.com"

    @@genres = {}
    @@years = {}

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

    #binding.pry

end