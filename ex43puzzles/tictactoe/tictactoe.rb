# This version of TicTacToe will not use an AI that is as intelligent as possible
# Instead, it will use an algorithm that plays randomly unless a user win is imminent,
#   in which case it will block that win (two in one line by the user).
# If the user plays and forces a win, it will block randomly and lose.
# Thus the user can win eventually, in theory, though there is always a chance that
# the program will get lucky.  So a win from the user is required to win the game.

class TicTacToe

  def play
    show_empty_board
    show_board_with_one_play_at_00
  end

  ONE_PLAY = [0,0]

  #    puts "This is a board with one play at (#{ONE_PLAY[0]}, #{ONE_PLAY[1]})"
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