class CliQuote
    
    include CliCommands

    def run
        ask_for_author
        show_chosen_author
        show_correct_author
        learn_more
        @chosen_author == @quote.author ? 1 : 0
    end

    private

    def initialize(quote, authors)
        @quote = quote
        @authors = authors
        @chosen_author = nil
    end

    def correct_author
        @quote.author
    end

    def ask_for_author
        show_question
        show_author_options
        response = get_integer_response(1, @authors.length)
        @chosen_author = @authors[response - 1]
    end

    def show_question
        clear
        puts ['Who said the following quote?', '', @quote.text, '']
    end

    def show_author_options
        puts @authors.each_with_index.map { |author, index| "(#{index + 1}) #{author}" }
        puts
    end

    def show_chosen_author
        show_question
        puts ["You chose #{@chosen_author}.", '']
    end

    def show_correct_author
        @chosen_author == correct_author ? correct : incorrect
        puts
    end

    def correct
        puts "Correct!"
    end

    def incorrect
        puts "Incorrect! The correct answer is #{correct_author}."
    end

    def learn_more
        show_author if promptYesNo("Would you like to learn more about #{correct_author}?")
    end

    def show_author
        clear
        puts [correct_author, '', "Born: #{correct_author.born}", '', 'Description:', correct_author.description, '']
        prompt("Press Enter to continue.")
    end

end