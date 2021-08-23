class CliPage

    include CliCommands

    attr_accessor :page_number, :quotes, :authors, :score

    def continue?
        page_number == 1 || promptYesNo("Would you like to continue?")
    end

    def run
        quotes.each do |quote|
            cli_quote = CliQuote.new(quote, authors)
            @score += cli_quote.run
        end
        score
    end

    private

    def initialize(page_number)
        @page_number = page_number
        get_quotes
        get_authors
        @score = 0
    end

    def get_quotes
        @quotes = Scraper.get_quotes(page_number)
    end

    def get_authors
        @authors = quotes.map { |quote| quote.author }.uniq.sort_by(&:name)
    end

end