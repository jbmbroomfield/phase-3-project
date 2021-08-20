class Author < DataClass

    attr_accessor :name, :url
    attr_writer :born, :description

    def initialize(name, url)
        self.name = name
        self.url = url
    end

    def born
        self.set_born_and_description if !@born
        @born
    end

    def description
        self.set_born_and_description if !@description
        @description
    end

    def set_born_and_description
        self.born, self.description = Scraper.get_born_and_description(self.url)
    end

    def to_s
        self.name
    end

    def self.find_or_new(*args)
        self.find_by_name(args[0]) || self.new(*args)
    end

    def self.find_by_name(name)
        self.all && self.all.find { |author| author.name == name }
    end

    def self.new(*args)
        author = super(*args)
        self.all.sort_by!(&:name)
        author
    end

end