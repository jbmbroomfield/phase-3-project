require 'nokogiri'
require 'open-uri'

class Scraper

    @@base_url = 'https://quotes.toscrape.com'

    def self.get_page(url='')
        url = @@base_url + url + '/'
        Nokogiri::HTML(open(url))
    end

    def self.get_quotes(url='')
        self.get_page(url).css('.quote')
    end

    def self.get_born_and_description(url)
        page = self.get_page(url)
        birth_date = page.css('.author-born-date').text
        birth_location = page.css('.author-born-location').text
        born = "#{birth_date} #{birth_location}"
        description = page.css('.author-description').text
        [born, description]
    end

    def self.create_quotes(page)
        Quote.reset
        Author.reset
        url = page > 1 ? "/page/#{page}" : ''
        quotes = self.get_quotes(url)
        quotes.each do |quote|
            self.new_quote(quote)
        end
    end

    def self.new_quote(quote)
        text = quote.css('.text').text
        author_name = quote.css('.author').text
        author_url = quote.css('a')[0].attributes["href"].value
        Quote.new(text, author_name, author_url)
    end

end
