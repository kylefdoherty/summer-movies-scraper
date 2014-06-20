#http://www.thrillist.com/entertainment/new-york/outdoor-movie-nyc-calendar

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'ap'


doc = Nokogiri::HTML(open('http://www.thrillist.com/entertainment/new-york/outdoor-movie-nyc-calendar'))


thrillist_list = doc.css("div.caption")


### get all the text
  content = thrillist_list.css('div.caption').collect do |i|
      i.content
  end 

  movies = content.reduce([]) do |array, item|
    array << item.split("\n\n")
  end 

  movies = movies.flatten
  movies.delete_at(-1)


  # => movies.size == 165

###got links
  links = thrillist_list.css('a').collect do |a_tag|
    a_tag.attribute("href").value    
  end 

  links.pop(2)

  
  # => movies.size == 165

def movie_builder(movies, links)
    date = ""
    movie_name = "" #--> need to remove '(click here for info)'
    location = ""   #--> remove word 'location:'
    amenities = ""  #--> remove word 'amenities:'
    link = ""

    movies.collect.with_index do |movie, index|
      movie.strip!
      date,movie_name,location,amenities = movie.split("\n")
      link = links[index]

      
      clean_movie_name(movie_name)
      clean_amenities_name(amenities) unless amenities == nil
      clean_location_name(location)
      date.strip!
      link.strip!

      [date,movie_name,location,amenities,link]
    end 
end 

def clean_movie_name(name)
  name.gsub!("(click here for info)","")
end

def clean_amenities_name(name)
  name.gsub!("Amenities:","").strip!
end 

def clean_location_name(name)
  name.gsub!("Location:","").strip!
end 




movies_array = movie_builder(movies,links)



binding.pry



#got dates
  # thrillist_list.css('strong').each do |tag|
  #   puts tag.content  
  # end 



  #NEXT 
  # - loop through movies array and split each text_line on "\n" to get:
      # - date
      # - movie_name --> need to remove '(click here for info)'
      # - location 
      # - amenities
      # - link --> use current index to access index of link 
  # - on each loop take the new vars and use them to create a movie object 
      # - convert date string to actual date object 
  # - when it runs and tell it command "this_week" it puts the upcoming movies for next 7 days
      # - figure out how to use cronjob to do it weekly
      # - hook it up to send grid to send emails on weekly basis by setting when you want to recieve them







