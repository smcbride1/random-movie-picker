class Movie

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :service_urls

    def initialize(attributes)
        attributes.each { |key, value| self.send(("#{key}="), value) }
    end

    def formatted_info
        puts "#{title}"
        puts "#{genre}"
        puts "#{year}, #{rating}, #{runtime}"
        puts "#{description}"
    end

end