class Board
	attr_accessor :board, :white_king, :white_queen, :white_pawn, :white_rook, :white_bishop, :white_knight
	def initialize
		@white_king = "\u{2654}"
		@white_queen = "\u{2655}"
		@white_rook = "\u{2656}"
		@white_bishop = "\u{2657}"
		@white_knight = "\u{2658}"
		@white_pawn = "\u{2659}"
		@black_king = "\u{265A}"
		@black_queen = "\u{265B}"
		@black_rook = "\u{265C}"
		@black_bishop = "\u{265D}"
		@black_knight = "\u{265E}"
		@black_pawn = "\u{265F}"
		eight = [@black_rook,@black_knight,@black_bishop,@black_queen,@black_king,@black_bishop,@black_knight,@black_rook]
		seven = [@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn,@black_pawn]
		six = [" "," "," "," "," "," "," "," "]
		five = [" "," "," "," "," "," "," "," "]
		four = [" "," "," "," "," "," "," "," "]
		three = [" "," "," "," "," "," "," "," "]
		two = [@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn,@white_pawn]
		one = [@white_rook,@white_knight,@white_bishop,@white_queen,@white_king,@white_bishop,@white_knight,@white_rook]
		@board = [eight,seven,six,five,four,three,two,one]
	end

	def pawn_move?(colour,from,to)
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		if from_x != to_x
			#check location for enemy pawn otherwise illegal
		end
		if colour == white
			if (to-from) == 1
				true
			else
				false
				puts "pawn can't move there"
			end
		else
			if (from-to) == 1
				true
			else
				false
				puts "pawn can't move there"
			end
		end
	end

	def move_piece(piece,from,to)
		p = white_pawn if piece == "white_pawn"
		from_y = from[1]
		from_x = from[0]
		to_y = to[1]
		to_x = to[0]
		board[from_y][from_x] = " "
    board[to_y][to_x] = p
  end

	def display_board
		board.each do |row|
			row.each do |element|
				print "#{element} "
			end
			puts
		end
	end
end

a = Board.new
a.display_board
a.move_piece("white_pawn",[0,6],[0,5])
a.display_board

		#six = ["\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}"]
		#five = ["\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}"]
		#four = ["\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}"]
		#three = ["\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}","\u{2B1B}","\u{2B1C}"]