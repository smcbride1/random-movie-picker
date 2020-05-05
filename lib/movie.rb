class Movie

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :service_urls

    def initialize(attributes)
        attributes.each { |key, value| self.send(("#{key}="), value) }
    end

end