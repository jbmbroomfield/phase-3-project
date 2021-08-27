class CliPage < DataClass

    include CliCommands

    attr_reader :quotes

    def continue?
        @page_number == 1 || promptYesNo("Would you like to continue?")
    end

    def run
        @quotes.each do |quote|
            cli_quote = CliQuote.new(quote, @authors)
            @score += cli_quote.run
        end
        @score
    end

    def quote_count
        @quotes.count
    end

    private

    def initialize(page_number)
        @page_number = page_number
        get_quotes
        get_authors
        @score = 0
    end

    def get_quotes
        @quotes = Scraper.get_quotes_by(page_number: @page_number)
    end

    def get_authors
        @authors = @quotes.map { |quote| quote.author }.uniq.sort_by(&:name)
    end

end