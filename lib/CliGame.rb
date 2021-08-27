class CliGame < DataClass

    include CliCommands

    def self.get_and_run
        cli_game = (all && all[0]) || new
        cli_game.run
    end
    
    def run
        loop do
            show_score
            @cli_page = CliPage.new(@page_number + 1)
            !@active || continue? ? run_page : stop && break
        end
    end

    private

    def initialize
        @score = 0
        @quote_count = 0
        @page_number = 0
        @active = false
        @cli_page = nil
    end

    def run_page
        @active = true
        @page_number += 1
        @quote_count += @cli_page.quote_count
        @score += @cli_page.run
    end

    def stop
        @active = false
        true
    end

    def show_score
        clear
        puts "Score: #{@score} / #{@quote_count}" if @active
    end

    def continue?
        @cli_page.continue?
    end

end