class Quote < DataClass

    attr_accessor :text, :author

    def initialize(text, author_name, author_url)
        self.text = text
        self.author = Author.find_or_new(author_name, author_url)
    end

    def self.find_or_new(text, *args)
        self.find_by(text: text) || self.new(text, *args)
    end

    def to_s
        author.name
    end
    
end