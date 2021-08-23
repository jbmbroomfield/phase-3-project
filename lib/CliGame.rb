class CliGame < DataClass

    include CliCommands
    
    attr_accessor :score, :quote_count, :page_number, :active

    def self.get_and_run
        cli_game = (self.all && self.all[0]) || self.new
        cli_game.run
    end
    
    def run
        loop do
            show_score
            cli_page = CliPage.new(page_number + 1)
            !active || cli_page.continue? ? run_page(cli_page) : stop && break
        end
    end

    private

    def initialize
        @score = 0
        @quote_count = 0
        @page_number = 0
        @active = false
    end

    def run_page(cli_page)
        @active = true
        @page_number += 1
        @quote_count += cli_page.quotes.count
        @score += cli_page.run
    end

    def stop
        @active = false
        true
    end

    def show_score
        clear
        if active
            puts "Score: #{score} / #{quote_count}"
        end
    end

end