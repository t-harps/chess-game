class Piece
	attr_accessor :colour, :white, :black
	def initialize(colour)
		@colour = colour
	end

	def to_s
	  @colour == "white" ? white : black
	end

	def legal_move?(board,to)
		piece = board.get_piece(to)
		if piece.class == String
			return true
		else
			return true if colour != piece.colour
		end
	end
end

class Queen < Piece

	def initialize(colour)
		@white = "\u{2655}"
		@black = "\u{265B}"
		super(colour)
	end

	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		dif_y = from_y - to_y
		dif_x = from_x - to_x
		if from_y == to_y
			true if board.clear_path?(from,to)
		elsif from_x == to_x
			true if board.clear_path?(from,to)
		elsif dif_y.abs == dif_x.abs
			true if board.clear_path?(from,to)
		else
			puts "Queen can only move in a diagonal/straight direction and or path not clear"
			false
		end
	end
end

class King < Piece

	def initialize(colour)
		@white = "\u{2654}"
		@black = "\u{265A}"

		super(colour)
	end

	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		dif_y = from_y - to_y
		dif_x = from_x - to_x
		if from_y < 0 || to_y < 0 || from_x < 0 || to_x < 0
			false
		elsif from_y == to_y && (from_x-to_x).abs == 1
			true if board.clear_path?(from,to)
		elsif from_x == to_x && (from_y-to_y).abs == 1
			true if board.clear_path?(from,to)
		elsif dif_y.abs == dif_x.abs && dif_y.abs == 1
			true if board.clear_path?(from,to)
		else
			puts "King can only move one square in any direction" 
			false
		end
	end

end

class Rook < Piece

	def initialize(colour)
		@white = "\u{2656}"
		@black = "\u{265C}"
		super(colour)
	end

	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		dif_y = from_y - to_y
		dif_x = from_x - to_x
		if from_y == to_y
			true if board.clear_path?(from,to)
		elsif from_x == to_x
			true if board.clear_path?(from,to)
		else
			puts "Rook can only move in straight lines and or path not clear"
			false
		end
	end	
end

class Knight < Piece

	def initialize(colour)
		@white = "\u{2658}"
		@black = "\u{265E}"
		super(colour)
	end
	
	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		dif_y = from_y - to_y
		dif_x = from_x - to_x
		if dif_y.abs == 2 && dif_x.abs == 1
			true
		elsif dif_x.abs == 2 && dif_y.abs == 1
			true
		else
			puts "Knight can only use an L shaped movement"
			false
		end
	end	
end

class Bishop < Piece

	def initialize(colour)
		@white = "\u{2657}"
		@black = "\u{265D}"
		super(colour)
	end

	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		dif_y = from_y - to_y
		dif_x = from_x - to_x
		if dif_x.abs == dif_y.abs
			true if board.clear_path?(from,to)
		else
			puts "Bishop can only move diagonally and or path not clear"
			false
		end
	end		
end

class Pawn < Piece
	attr_accessor :pawn, :colour, :moves
	def initialize(colour, move = 0)
		@white = "\u{2659}"
		@black = "\u{265F}"
		super(colour)
	end

	#Checks whether pawn is moving one square in straight line + checks if empty
	#if moving diagonal that square it's moving to has a pawn
	def legal_move?(board,from,to)
		return false unless super(board,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		#when trying to move diagonally
		if from_x != to_x
			#checks colour of pawn
			if colour == "white"
				#checks only 1 vertical move away
				if (from_y-to_y) == 1
					return true
				else
					puts "No enemy pawn there"
					return false
				end
			else
				if (to_y-from_y) == 1
					return true
				else
					puts "No enemy pawn there"
					return false
				end
			end
		end
		#when trying to move straight
		if colour == "white"
			if from_y == 6
				if (from_y-to_y) <= 2 && board.get_piece(to) == "_"
					return true
				else
					puts "Can only move 1 or 2 spaces from here and or another piece already there"
					return false
				end					
			else
				if (from_y-to_y) == 1 && board.get_piece(to) == "_"
					return true
				else
					puts "Can only move 1 space from here and or another piece already there"
					return false
				end
			end
		else
			if from_y == 1
				if (to_y-from_y) <= 2 && board.get_piece(to) == "_"
					return true
				else
					puts "Can only move 1 or 2 spaces from here and or another piece already there"
					return false
				end
			else
				if (to_y-from_y) == 1 && board.get_piece(to) == "_"
					return true
				else
					puts "Can only move 1 space from here and or another piece already there"
					return false
				end
			end
		end
	end

end