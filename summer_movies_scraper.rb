require 'nokogiri'
require 'open-uri'
require 'pry'


skint_doc = Nokogiri::HTML(open('http://www.theskint.com/2014/06/2014-free-outdoor-movies-guide.html'))

skint_html = skint_doc.css("div.post-body.entry-content")

lines = skint_html.text.split("\n").select do |line|
  line[0].to_i != 0
end


# clean the lines
#lines.first.gsub(/\w\w\w:|>>/,"").strip
# get date 
#date = clean_line.slice!(/[0-9]\/[0-9][0-9]/)
# get movie & venue 
#movie, venue = clean_line.strip.split(",")

def split_lines(lines)
  movies = []

  lines.each do |line|
    date = line.split(":")[0].split(" ")[0] 
    name, venue = line.split(":")[1].strip.split(",")

    movies << {:date => date, :name => name, :venue => venue}
  end 


  movies

end 


free_movies = split_lines(lines)


links = []


### To-Do ###

#1.build scraper that collects lines 
#of text for each movie & links for each movie
    #test that lines array & m



# date 
# title 
# location
# link 




binding.pry
