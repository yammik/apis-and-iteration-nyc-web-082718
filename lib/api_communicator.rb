require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character}")
  response_hash = JSON.parse(response_string)

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.


  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  result = response_hash["results"]
  if result.length > 1
    puts "More than one character found. Please enter the full name :"
    nil
  elsif result.length == 0
    puts "No character found by that name. Please check your spelling and retry :"
    nil
  else
    parse_response_films(result[0])
  end

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_response_films(result)
  result_hash = []
  films = result["films"]
  films.each do |film_url|
    response = JSON.parse(RestClient.get(film_url))
    result_hash << response
  end
  result_hash
end

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts "Title : #{film['title']}"
    puts "Episode #{film['episode_id']}"
    puts "Director : #{film['director']}"
    puts "Producer : #{film['producer']}"
    puts "Released : #{film['release_date']}", "\n"
    puts "#{film['opening_crawl']}"
    puts "\n" * 2, "-" * 25, "\n"
  end

end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
# binding.pry
