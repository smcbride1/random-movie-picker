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
            {:name => genre.text.split("\n")[1].strip,
             :url => genre.attribute("href").text}
        end
    end

    def self.cache_years
        doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=2018"))
        @@years = doc.css(".btn-group.btn-primary-border-dropdown li a").map do |year|
            {:name => year.text.split("\n")[1].strip,
             :url => year.attribute("href").text}
        end
    end

end