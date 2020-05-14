class RandomMoviePicker::Movie

    BASE_URL = "https://www.rottentomatoes.com"

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :url

    @@all = []

    def initialize
        self.class.all.push(self)
    end

    def self.all
        @@all
    end

    def self.new_from_url(url)
        return self.find_by_url(url) if self.find_by_url(url) != nil
        url = BASE_URL + url if !url.include?(BASE_URL)
        new_from_hash(RandomMoviePicker::Scraper.scrape_movie_by_url(url))
    end

    def self.new_from_hash(h)
        new_movie = self.new
        h.each do |att, val|
            m = "#{att}=".to_sym
            new_movie.send(m, val) if new_movie.methods.include?(m)
        end
        new_movie
    end

    def self.find_by_title(title)
        all.find { |movie| movie.title == title }
    end

    def self.find_by_url(url)
        all.find { |movie| movie.url == url }
    end

end