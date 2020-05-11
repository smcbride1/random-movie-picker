class RandomMoviePicker::Year

    BASE_URL = "https://www.rottentomatoes.com"

    attr_accessor :name, :url

    @@all = []

    def initialize(name, url)
        @name = name
        @url = url
        @@all.push(self)
    end

    def self.all
        if @@all == []
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=2020"))
            doc.css(".btn-group.btn-primary-border-dropdown li a").each do |year|
                self.new(year.text.strip, BASE_URL + year.attribute("href").text)
            end
            @@all
        else
            @@all
        end
    end

    def self.find_by_name(name)
        self.all.find { |year| year.name == name }
    end

end