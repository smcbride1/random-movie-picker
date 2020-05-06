class Movie

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :url, :service_urls, :fully_fetched

    @@all = []

    def initialize(attributes)
        @fully_fetched = false
        attributes.each { |key, value| self.send(("#{key}="), value) }
        self.class.push(self)
    end

    def self.all
        @@all
    end

    def formatted_info
        puts "#{title}"
        puts "#{genre}"
        puts "#{year}, #{rating}, #{runtime}"
        puts "#{description}"
    end

end