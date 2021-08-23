class DataClass

	class << self
		attr_accessor :all

		def initialize
			self.class.all = []
		end

	end

	def self.find_by(**kwargs)
		self.all.find { |instance| self.all_match?(instance, **kwargs) }
	end

	def self.all_match?(instance, **kwargs)
		kwargs.each do |key, value|
			return false if instance.send(key) != value
		end
		true
	end

    def self.new(*args)
        new_object = super(*args)
		self.all ||= []
        self.all << new_object
        new_object
    end
	
	def self.new_many(*many)
		many.map { |args| self.new(*args) }
	end

    def self.reset
        self.all = []
    end

end