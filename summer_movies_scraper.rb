require 'nokogiri'
require 'open-uri'
require 'pry'


skint_doc = Nokogiri::HTML(open('http://www.theskint.com/2014/06/2014-free-outdoor-movies-guide.html'))

skint_html = skint_doc.css("div.post-body.entry-content")
skint_links = skint_doc.css("div.post-body.entry-content a")

lines = skint_html.text.split("\n").select do |line|
  line[0].to_i != 0
end

links = skint_links.collect do |item|
  [item.attribute("href").value, item.text]
end 

links

[
  ["http://www.theskint.com/2007/01/sign-up-for-daily-email.html", "Sign up"],
 ["http://www.bryantpark.org/plan-your-visit/filmfestival.html", " >>"],
 ["https://www.facebook.com/supercolliderbrooklyn/photos/pb.162139653946568.-2207520000.1402100837./279894258837773/?type=3&theater",
  " >>"]
]





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





### To-Do ###

#1.build scraper that collects lines 
#of text for each movie & links for each movie
    #test that lines array & m



# date 
# title 
# location
# link 




binding.pry
