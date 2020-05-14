class RandomMoviePicker::Genre

    attr_accessor :name, :url

    def initialize(name, url)
        @name = name
        @url = url
    end

    def self.all
        @@all ||= Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/top_100_action__adventure_movies/"))
        .css(".btn-group.btn-primary-border-dropdown li a").map do |genre|
            self.new(genre.text.strip, "https://www.rottentomatoes.com" + genre.attribute("href").text)
        end
    end

    def self.random_genre
        self.all.sample
    end

    def self.names
        self.all.map { |genre| genre.name }
    end

end