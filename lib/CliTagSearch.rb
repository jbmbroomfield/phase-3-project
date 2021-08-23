class CliTagSearch

    attr_accessor :tag, :quotes

    include CliCommands

    def run
        ask_for_tag
        get_quotes
        show_quotes
    end

    private

    def ask_for_tag
        @tag = prompt('Enter a tag to search by.')
    end

    def get_quotes
        @quotes = Scraper.get_quotes_by(tag: tag)
    end

    def show_quotes
        show_quotes_header
        @quotes.each do |quote|
            show_quote(quote)
        end
        gets
    end

    def show_quotes_header
        clear
        puts "Quotes with the tag: #{@tag}"
        sleep(2)
    end

    def show_quote(quote)
        puts ['', '', quote.text, '', quote.author]
        gets
    end

end
