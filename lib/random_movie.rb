require "open-uri"
require "nokogiri"
require "pry"

class RandomMovie

    BASE_URL = "https://www.rottentomatoes.com"

    @@genres = []
    @@years = []

    def self.cache_genres
        doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/top_100_action__adventure_movies/"))
        @@genres = doc.css(".btn-group.btn-primary-border-dropdown li a").map do |genre|
            {:name => white_space_fix(genre.text),
             :url => genre.attribute("href").text}
        end
    end

    def self.cache_years
        doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=2020"))
        @@years = doc.css(".btn-group.btn-primary-border-dropdown li a").map do |year|
            {:name => white_space_fix(year.text),
             :url => year.attribute("href").text}
        end
    end

    def self.white_space_fix(text)
        text.split("\n")[1].strip
    end

end