require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

def crypto_scrapper
  # Target page to scrape with Nokogiri
  page = Nokogiri::HTML(URI.open(PAGE_URL))

  # Target all cryptocurrency symbols using xpath, iterate through them and push the text to an empty array
  crypto_symbols = page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
  crypto_symbols_array = []
  crypto_symbols.each do |name|
    crypto_symbols_array.push(name.text)
    end

  # Target all cryptocurrency prices using xpath, iterate through them and push the text (removing the $ and converting to a float) to an empty array
  crypto_prices = page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a')
  crypto_prices_array = []
  crypto_prices.each do |price|
    crypto_prices_array.push(price.text.delete_prefix('$').to_f)
    end

  # Zip the 2 new arrays together in a hash
  a = Hash[crypto_symbols_array.zip(crypto_prices_array)]

  # Return the hash
  return a
end

crypto_scrapper