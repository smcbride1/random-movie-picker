class RandomMoviePicker::Scraper

    def self.random_movie_by_genre(genre)
        doc = Nokogiri::HTML(open(genre.url))
        movies = doc.css(".table .unstyled.articleLink")
        new_movie = RandomMoviePicker::Movie.new_from_url(movies[rand(movies.length)].attribute("href").text)
        new_movie
    end

    def self.random_movie_by_year(year)
        doc = Nokogiri::HTML(open(year.url))
        movies = doc.css(".table .unstyled.articleLink")
        new_movie = RandomMoviePicker::Movie.new_from_url(movies[rand(movies.length)].attribute("href").text)
        new_movie
    end

end