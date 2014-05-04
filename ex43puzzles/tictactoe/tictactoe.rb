# This version of TicTacToe will not use an AI that is as intelligent as possible
# Instead, it will use an algorithm that plays randomly unless a user win is imminent,
#   in which case it will block that win (two in one line by the user).
# If the user plays and forces a win, it will block randomly and lose.
# Thus the user can win eventually, in theory, though there is always a chance that
# the program will get lucky.  So a win from the user is required to win the game.

class TicTacToe

  def initialize
    @players_symbol = nil
    @board = Array.new(9, nil)
  end
  
  def play
    show_empty_board
    show_board_with_one_play_at_00
    puts "Would you like to be X or O?"
    get_and_check_symbol
    puts "Please enter a whole number between 1 and 9 inclusive."
    get_and_check_move
  end

  def prompt
    print "> "
    gets.chomp.downcase
  end
  
  def get_and_check_symbol
    @players_symbol = (kosher_symbol?(prompt))
  end
  
  def kosher_symbol?(choice)
    while !(choice == "x" or choice == "o")
      puts "That choice is neither X nor O!  Please try again."
      choice = prompt
    end
    choice
  end
  
  def get_and_check_move
    players_move = (kosher_move?(prompt.to_i))
    @board[players_move-1] = @players_symbol.upcase
    print @board; puts
  end
  
  def kosher_move?(move)
    while !(1..9).to_a.include?(move)
      puts "That is not a whole number between 1 and 9 inclusive!  Please try again."
      move = prompt
    end
    move
  end

  # Below is the code for showing the board.
  # 2 simple implementations are hard-coded; one play at 0,0 and no plays.
  # Next I want to implement a version that uses the constant below.
  # ONE_PLAY = [0,0]
  # puts "This is a board with one play at (#{ONE_PLAY[0]}, #{ONE_PLAY[1]})"
  # Then I will start considering what happens to the board view as plays are added.
  
  def show_board_with_one_play_at_00
    puts
    puts "This is a board with one play at (0,0)"
    vertical_edging
    2.times do
      3.times{vertical_line_bits}
      horizontal_line
      puts
    end
    vertical_line_bits
    horizontal_spacing
    print "   X   "
    print "|"
    horizontal_spacing
    print "|"
    puts
    vertical_line_bits
    vertical_edging
  end
  
  def show_empty_board
    puts
    puts "This is an empty board:"
    vertical_edging
    2.times do
      3.times{vertical_line_bits}
      horizontal_line
      puts
    end
    3.times{vertical_line_bits}
    vertical_edging
  end

  def vertical_line_bits
    horizontal_spacing
    2.times do
      horizontal_spacing
      print "|"
    end
    puts
  end

  def horizontal_line
    horizontal_spacing
    2.times do
      7.times{print "-"}
      print"|"
    end
    7.times{print "-"}
  end    
  
  def vertical_edging
    3.times{puts}
  end

  def horizontal_spacing
    7.times{print " "}            
  end
    
end

new_game = TicTacToe.new
new_game.play