module Finder

    def find_by_movie_title(title)
        Movies.all.find { |movie| movie.title == title }
    end

end