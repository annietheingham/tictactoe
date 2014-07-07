class TicTacToe
	attr_reader :players, :board
	attr_accessor :first_players_turn

	def initialize
		@board = Board.new
		@players = [Player.new('X'), Player.new('O')]
		@first_players_turn = true
	end

	def start
		puts "Welcome to the game!"
		board.print
		while moves_left? do
			puts "#{player_live}, it's your turn."
			puts "Enter and index: "
			input_index = gets.chomp.to_i
			move = Move.new(player_live, board, input_index)
			if move.execute
				board.print
				#toggle first_players_turn
				first_players_turn = !first_players_turn
			else
				puts "Error: that space is taken"
			end
		end
	end

	def player_live
		self.first_players_turn ? players.first : players.last
	end

	def moves_left?
		board.state.any? {|space| space.nil? }
	end

	def is_there_a_winner?
		# todo for later
	end

end

class Player
	attr_reader :symbol
	def initialize(symbol)
		@symbol = symbol
	end

	def name
		"Player #{symbol}"
	end
end

class Board
	attr_accessor :state
	def initialize
		#creates an array with 9 nils
		@state = Array.new(9)
	end

	def space_available?(index)
		state[index].nil?
		# or state[index] == nil
	end

	def take_space(symbol, index)
		if space_available?(index)
			state[index] = symbol
			return true
		else
			return false
		end
	end

	def print
		puts state[0,3].join(' | ')
		puts "----------"
		puts state[3,3].join(' | ')
		puts "----------"
		puts state[6,3].join(' | ')
	end
end

class Move
	attr_reader :player, :board, :index
	def initialize(player, board, index)
		@player = player
		@board = board
		@index = index
	end

	def execute
		board.take_space(player.symbol, index)
	end
end