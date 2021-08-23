class CLI

    include CliCommands

    def run
        show_menu
        response = get_integer_response(1, 3)

        if response == 1
            CliGame.get_and_run
            run
        elsif response == 2
            puts 'Enter a tag to search by.'
        end
        clear
        puts ['Goodbye!', '']
    end

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

    def tag_search
        tag = prompt('Enter a tag to search by.')
    end

end