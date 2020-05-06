require "open-uri"
require "nokogiri"
require "pry"
require "json"

class Movie

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :url, :service_urls, :fully_fetched

    @@all = []

    def initialize(attributes={})
        @fully_fetched = false
        attributes.each { |key, value| self.send(("#{key}="), value) }
        self.class.all.push(self)
    end

    def self.all
        @@all
    end

    def self.new_from_url(url)
        doc = Nokogiri::HTML(open(url))
        new_movie = Movie.new()
        binding.pry
        new_movie.title = doc.css(".mop-ratings-wrap__title.mop-ratings-wrap__title--top").text
        new_movie.rating = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[0].text.split(" ")[0].strip
        new_movie.genre = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[1].text.gsub("\n", "").split(",").map{ |s| s.strip }.join(", ")
        new_movie.year = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[4].css("time").attribute("datetime").text.split("-")[0].strip
        new_movie.runtime = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[7].css("time").text.strip
        new_movie.description = doc.css("#movieSynopsis").text.strip.gsub("\"", "")
        new_movie
    end

    def formatted_info
        puts "#{title}"
        puts "#{genre}"
        puts "#{year}, #{rating}, #{runtime}"
        puts "#{description}"
    end

    binding.pry

end