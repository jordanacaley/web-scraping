require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = 'https://www.annuaire-des-mairies.com/val-d-oise.html'

def get_townhall_urls
  # Print email for specific town hall
  def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url))
    townhall_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    townhall_email.each do |email|
      return email.text
      end
  end

  # Get array of all city names
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  town_names = page.xpath('//a[@class="lientxt"]')
  town_names_array = []
  town_names.each do |name|
    town_names_array.push(name.text)
    end

  # Get array of all city websites
  town_urls = page.xpath('//a[@class="lientxt"]/@href')
  town_urls_array = []
  town_urls.each do |url|
    town_urls_array.push(url.text.delete_prefix('.').prepend('https://www.annuaire-des-mairies.com'))
    end

  # Get array of all city emails
  # Need to run the get_townhall_email method passing it each townhall_url from the town_urls_array
  town_emails_array = []
  i = 0
  while i < town_urls_array.length
    town_emails_array.push(get_townhall_email(town_urls_array[i]))
    i = i + 1
  end

  # Zip the 2 new arrays together in a hash
  a = Hash[town_names_array.zip(town_emails_array)]

  # Return the hash
  print a
end

get_townhall_urls
