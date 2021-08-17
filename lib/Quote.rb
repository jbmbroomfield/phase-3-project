class Quote < ClassObject

    attr_accessor :text, :author

    def initialize(text, author_name, author_url)
        self.text = text
        self.author = Author.find_or_new(author_name, author_url)
    end
    
end