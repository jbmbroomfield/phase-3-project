class CliGame

    include CliCommands
    
    attr_accessor :score, :quote_count, :page_number
    
    def run
        loop do
            show_score
            cli_page = new_cli_page
            cli_page.continue? ? @score += cli_page.run : break
        end
    end

    private

    def initialize
        @score = 0
        @quote_count = 0
        @page_number = 0
    end

    def show_score
        puts "Score: #{score} / #{quote_count}" if quote_count > 0
    end

    def new_cli_page
        @page_number += 1
        cli_page = CliPage.new(page_number)
        @quote_count += cli_page.quotes.count
        cli_page
    end

end