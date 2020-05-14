class RandomMoviePicker::Genre

    attr_accessor :name, :url

    @@all = []

    def initialize(name, url)
        @name = name
        @url = url
        @@all.push(self)
    end

    def self.all
        if @@all == []
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/top_100_action__adventure_movies/"))
            doc.css(".btn-group.btn-primary-border-dropdown li a").each do |genre|
                self.new(genre.text.strip, "https://www.rottentomatoes.com" + genre.attribute("href").text)
            end
            @@all
        else
            @@all
        end
    end

    def self.random_genre
        self.all.sample
    end

end