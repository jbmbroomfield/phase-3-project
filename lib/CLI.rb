class CLI
    attr_accessor :score, :quote_count, :page

    def initialize
        @score = 0
        @quote_count = 0
        @page = 1
    end

    def clear
        system 'clear'
    end

    def run
        clear
        puts [
                "Welcome to the Quotes CLI. What would you like to do?",
                '',
                '(1) Play a quote matching game.',
                '(2) Search for quotes by their tags.',
                '(3) Exit.',
            ]
        response = get_integer_response(1, 3)

        if response == 1
            run_game
        elsif response == 2
            puts 'Enter a tag to search by.'
        end
        clear
        puts ['Goodbye!', '']
    end

    def tag_search
        tag = prompt('Enter a tag to search by.')
    end

    def promptYesNo(text)
        input = prompt("#{text} (Y/n)")
        input[0] && input[0].downcase == 'n'
    end

    def prompt(text)
        puts text if text.length > 0
        gets.strip
    end

    def show_score
        puts "Score: #{score} / #{quote_count}"
    end

    def run_game
        while Scraper.create_quotes(page).length > 0 do
            if page > 1
                break if !promptYesNo("Would you like to continue?")
            end

            prompt("Press enter to begin.")
            show_quotes
            show_score
            @page += 1
            promptYesNo("Would you like to continue?")
        end
    end

    def show_quotes
        Quote.all.each do |quote|
            show_quote(quote)
            @quote_count += 1
        end
    end

    def show_quote(quote)
        chosen_author = ask_question(quote)
        show_chosen_answer(chosen_author)
        show_correct_answer(chosen_author, quote.author)
        learn_more(quote.author)
    end

    def ask_question(quote)
        authors = Author.all
        options_array = authors.each_with_index.map { |author, index| "(#{index + 1}) #{author}" }
        clear
        puts ['Who said the following quote?', quote.text, '']  + options_array + ['']
        response = get_integer_response(1, authors.length)
        authors[response - 1]
    end

    def get_integer_response(min, max)
        response = nil
        loop do
            response = Integer(gets.strip) rescue nil
            break if check_integer(response, min, max)
        end
        response
    end

    def check_integer(response, min, max)
        if !response || response < min || response > max
            puts "Please enter a number between #{min} and #{max}."
            return false
        end
        true
    end

    def show_chosen_answer(chosen_author)
        puts ['', "You chose #{chosen_author}.", '']
    end

    def show_correct_answer(chosen_author, correct_author)
        chosen_author == correct_author ? correct : incorrect(correct_author)
        puts
    end

    def correct
        puts "Correct!"
        @score += 1
    end

    def incorrect(correct_author)
        puts "Incorrect! The correct answer is #{correct_author.name}."
    end

    def learn_more(author)
        response = promptYesNo("Would you like to learn more about #{author.name}?")
        show_author(author) if response
    end

    def show_author(author)
        puts ['', author.name, '', "Born: #{author.born}", '', 'Description:', '', author.description, '']
        prompt("Press any key to continue.")
    end

end