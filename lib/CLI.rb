class CLI

    include CliCommands

    def run
        show_menu
        response = get_integer_response(1, 3)
        accept_response(response)
        terminate
    end

    private

    def show_menu
        clear
        puts [
                "Welcome to the Quotes CLI. What would you like to do?",
                '',
                '(1) Play a quote matching game.',
                '(2) Search for quotes by their tags.',
                '(3) Exit.',
            ]
    end

    def accept_response(response)
        if response == 1
            run_game
        elsif response == 2
            run_tag_search
        end
    end

    def run_game
        CliGame.get_and_run
        run
    end

    def run_tag_search
        tag = prompt('Enter a tag to search by.')
        run
    end

    def terminate
        clear
        puts ['Goodbye!', '']
    end

end