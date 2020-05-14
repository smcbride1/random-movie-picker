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

    def self.scrape_movie_by_url(url)
        doc = Nokogiri::HTML(open(url))
        runtime_element = doc.css(".content-meta.info .meta-row.clearfix").find { |element| element.css(".meta-label.subtle").text == "Runtime:" }
        {
            title: doc.css(".mop-ratings-wrap__title.mop-ratings-wrap__title--top").text,
            rating: doc.css(".content-meta.info .meta-row.clearfix .meta-value")[0].text.split(" ")[0].strip,
            genre: doc.css(".content-meta.info .meta-row.clearfix .meta-value")[1].text.gsub("\n", "").split(",").map{ |s| s.strip }.join(", "),
            year: doc.css(".content-meta.info .meta-row.clearfix .meta-value time")[0].attribute("datetime").text.split("-")[0].strip,
            runtime: runtime_element == nil ? "" : runtime_element.css("time").text.strip,
            description: doc.css("#movieSynopsis").text.strip.gsub("\"", ""),
        }
    end

end