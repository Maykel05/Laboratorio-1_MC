class Team
	attr_accessor :name, :players, :pj, :pg, :pe, :pp
	def initialize(name)
		@pj = 0
		@pg = 0
		@pe = 0
		@pp = 0
		@name = name
		@players = Array.new
	end
	def self.size
		@players.size
	end
end