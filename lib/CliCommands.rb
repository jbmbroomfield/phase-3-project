module CliCommands

    def clear
        system 'clear'
    end

    def promptYesNo(text)
        input = prompt("#{text} (Y/n)")
        input.length == 0 || input[0].downcase != 'n'
    end

    def prompt(text)
        puts text if text.length > 0
        gets.strip
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

end