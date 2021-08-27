class Author < DataClass

    attr_reader :name

    def initialize(name, url)
        @name = name
        @url = url
        @born = nil
        @description = nil
    end

    def born
        set_born_and_description if !@born
        @born
    end

    def description
        set_born_and_description if !@description
        @description
    end

    def set_born_and_description
        @born, @description = Scraper.get_born_and_description(@url)
    end

    def to_s
        @name
    end

    def self.find_or_new(*args)
        find_by_name(args[0]) || new(*args)
    end

    def self.find_by_name(name)
        all && all.find { |author| author.name == name }
    end

    def self.new(*args)
        author = super(*args)
        all.sort_by!(&:name)
        author
    end

end