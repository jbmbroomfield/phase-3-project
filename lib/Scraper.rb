require 'nokogiri'
require 'open-uri'

class Scraper

    @@base_url = 'https://quotes.toscrape.com'

    def self.get_quotes_by(tag: nil, page_number: nil)
        url = self.tag_url(tag) + self.page_url(page_number)
        quote_elements = self.get_quote_elements(url)
        quote_elements.map { |quote_element| self.find_or_new_quote(quote_element) }
    end

    def self.tag_url(tag)
        tag ? "/tag/#{tag}" : ''
    end

    def self.page_url(page_number)
        page_number && page_number > 1 ? "/page/#{page_number}" : ''
    end

    def self.get_quote_elements(url='')
        self.get_page(url).css('.quote')
    end

    def self.get_page(url='')
        url = @@base_url + url + '/'
        Nokogiri::HTML(open(url))
    end

    def self.find_or_new_quote(quote_element)
        text = quote_element.css('.text').text
        author_name = quote_element.css('.author').text
        author_url = quote_element.css('a')[0].attributes["href"].value
        Quote.find_or_new(text, author_name, author_url)
    end

    def self.get_born_and_description(url)
        page = self.get_page(url)
        birth_date = page.css('.author-born-date').text
        birth_location = page.css('.author-born-location').text
        description = page.css('.author-description').text
        ["#{birth_date} #{birth_location}", description]
    end

end
