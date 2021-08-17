class ClassObject

	class << self
		attr_accessor :all
	end

	def set_all(value)
		self.class.all = value
	end

	def get_all
		self.class.all
	end

    def self.new(*args)
        new_object = super(*args)
		self.all ||= []
        self.all << new_object
        new_object
    end

    def self.reset
        self.all = []
    end

end