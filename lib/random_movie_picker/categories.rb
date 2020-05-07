class RandomMoviePicker::Categories

    BASE_URL = "https://www.rottentomatoes.com"

    @@genres = {}
    @@years = {}

    def self.genres

        if @@genres == {}
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/top_100_action__adventure_movies/"))
            doc.css(".btn-group.btn-primary-border-dropdown li a").each do |genre|
                @@genres[white_space_fix(genre.text)] = BASE_URL + genre.attribute("href").text
            end
            @@genres
        else
            @@genres
        end

    end

    def self.years

        if @@years == {}
            doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=2020"))
            doc.css(".btn-group.btn-primary-border-dropdown li a").map do |year|
                @@years[year.text.strip] = BASE_URL + year.attribute("href").text
            end
            @@years
        else
            @@years
        end

    end

    def self.random_category
        categories = [@@genres, @@years]
        categories.sample
    end

    def self.random_subcategory(category)
        category[category.keys[rand(category.length)]]
    end

    def self.white_space_fix(text)
        text.split("\n")[1].strip
    end

    #binding.pry

end