require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = 'https://www.nosdeputes.fr/deputes'

def french_deputies
  # Print email for one deputy
  def get_deputy_email(deputy_url)
    page = Nokogiri::HTML(URI.open(deputy_url))
    deputy_email = page.xpath('/html/body/div[1]/div[5]/div/div[3]/div[1]/ul[2]/li[1]/ul/li[1]/a')
    deputy_email.each do |email|
      return email.text
      end
  end

  # Get array of names of all deputies
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  deputy_names = page.xpath('//span[@class="list_nom"]')
  deputy_names_array = []
  deputy_names.each do |name|
    deputy_names_array.push(name.text.strip)
    end
  
  # Create one array for first names and one array for last names
  deputy_first_names_array = []
  deputy_last_names_array = []
  i = 0
  while i < deputy_names_array.length
    deputy_last_names_array.push(deputy_names_array[i].split(',')[0])
    deputy_first_names_array.push(deputy_names_array[i].split(',')[1])
    i = i + 1
  end  

  # Get array of all deputy urls
  deputy_urls = page.xpath('//div[@class="list_table"]//a/@href')
  deputy_urls_array = []
  deputy_urls.each do |url|
    deputy_urls_array.push(url.text.prepend('https://www.nosdeputes.fr'))
    end

  # Get array of all deputy emails
  # Run the get_deputy_email method passing it each deputy_url from the deputy_urls_array
  deputy_emails_array = []
  deputy_urls_array.each do |url|
    deputy_emails_array.push(get_deputy_email(url))
  end

  # Turn names and emails into hash
  a = []
  i = 0
  while i < deputy_names_array.length
    a.push({ "first_name" => deputy_first_names_array[i], "last_name" => deputy_last_names_array[i], "email" => deputy_emails_array[i] })
    i = i + 1
  end
  print a
end

french_deputies