class RandomMoviePicker::Movie

    BASE_URL = "https://www.rottentomatoes.com"

    attr_accessor :title, :year, :rating, :genre, :runtime, :description, :url, :services

    @@all = []

    def initialize
        @services = {}
        self.class.all.push(self)
    end

    def self.all
        @@all
    end

    def self.new_from_url(url)
        return self.find_by_url(url) if self.find_by_url(url) != nil
        url = BASE_URL + url if !url.include?(BASE_URL)
        doc = Nokogiri::HTML(open(url))
        new_movie = self.new
        new_movie.url = url
        #binding.pry
        new_movie.title = doc.css(".mop-ratings-wrap__title.mop-ratings-wrap__title--top").text
        new_movie.rating = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[0].text.split(" ")[0].strip
        new_movie.genre = doc.css(".content-meta.info .meta-row.clearfix .meta-value")[1].text.gsub("\n", "").split(",").map{ |s| s.strip }.join(", ")
        new_movie.year = doc.css(".content-meta.info .meta-row.clearfix .meta-value time")[0].attribute("datetime").text.split("-")[0].strip
        runtime_element = doc.css(".content-meta.info .meta-row.clearfix").find { |element| element.css(".meta-label.subtle").text == "Runtime:" }
        runtime_element == nil ? new_movie.runtime = "" : new_movie.runtime = runtime_element.css("time").text.strip
        new_movie.description = doc.css("#movieSynopsis").text.strip.gsub("\"", "")
        doc.css(".affiliates__list .affiliate__item .affiliate__link").each do |service|
            new_movie.services[service.attribute("data-affiliate").text] = service.attribute("href").text
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