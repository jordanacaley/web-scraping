require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"
   

page = Nokogiri::HTML(URI.open(PAGE_URL))
news_links = page.css("a[data-category=news]")
news_links.each{|link| puts link['href']}
#=>   http://reddit.com
#=>   http://www.nytimes.com

puts news_links.class   #=>   Nokogiri::XML::NodeSet     