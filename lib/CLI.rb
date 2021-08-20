class CLI
    attr_accessor :score, :quote_count, :page

    def initialize
        self.score = 0
        self.quote_count = 0
        self.page = 1
    end

    def run
        system 'clear'
        puts [
                "Welcome to the Quotes CLI. What would you like to do?",
                '',
                '(1) Play a quote matching game.',
                '(2) Search for quotes by their tags.',
                '(3) Exit.',
            ]
        response = get_integer_response(1, 3)

        if response == 1
            self.prompt("Press enter to begin.")
            until self.run_game
            end
        elsif response == 2
            puts 'Enter a tag to search by.'
        end
        system 'clear'
        puts ['Goodbye!', '']
    end

    def promptYesNo(text)
        input = self.prompt("#{text} (Y/n)")
        input[0] && input[0].downcase == 'n'
    end

    def prompt(text)
        puts text if text.length > 0
        gets.strip
    end

    def show_score
        puts "Score: #{self.score} / #{self.quote_count}"
    end

    def run_game
        return true if self.create_quotes
        self.show_quotes
        self.show_score
        self.page += 1
        self.promptYesNo("Would you like to continue?")
    end

    def create_quotes
        Scraper.create_quotes(self.page)
        return false if Quote.all.length > 0
        puts "You have made it through all of the quotes."
        true
    end

    def show_quotes
        Quote.all.each do |quote|
            self.show_quote(quote)
            self.quote_count += 1
        end
    end

    def show_quote(quote)
        chosen_author = self.ask_question(quote)
        self.show_chosen_answer(chosen_author)
        self.show_correct_answer(chosen_author, quote.author)
        self.learn_more(quote.author)
    end

    def ask_question(quote)
        authors = Author.all
        options_array = authors.each_with_index.map { |author, index| "(#{index + 1}) #{author}" }
        puts ['', 'Who said the following quote?', quote.text, '']  + options_array + ['']
        response = self.get_integer_response(1, authors.length)
        authors[response - 1]
    end

    def get_integer_response(min, max)
        response = nil
        loop do
            response = Integer(gets.strip) rescue nil
            break if self.check_integer(response, min, max)
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
        chosen_author == correct_author ? self.correct : self.incorrect(correct_author)
        puts
    end

    def correct
        puts "Correct!"
        self.score += 1
    end

    def incorrect(correct_author)
        puts "Incorrect! The correct answer is #{correct_author.name}."
    end

    def learn_more(author)
        response = self.promptYesNo("Would you like to learn more about #{author.name}?")
        self.show_author(author) if response
    end

    def show_author(author)
        puts ['', author.name, '', "Born: #{author.born}", '', 'Description:', '', author.description, '']
        self.prompt("Press any key to continue.")
    end

end