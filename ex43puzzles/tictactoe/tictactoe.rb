# This version of TicTacToe will not use an AI that is as intelligent as possible
# Instead, it will use an algorithm that plays randomly unless a user win is imminent,
#   in which case it will block that win (two in one line by the user).
# If the user plays and forces a win, it will block randomly and lose.
# Thus the user can win eventually, in theory, though there is always a chance that
# the program will get lucky.  So a win from the user is required to win the game.

class TicTacToe

  def play
    show_empty_board
  end

  def show_empty_board
    puts
    puts "This is an empty board:"
    vertical_edging
    3.times{vertical_line_bits}
    horizontal_line
    puts
    3.times{vertical_line_bits}
    horizontal_line
    puts
    3.times{vertical_line_bits}
    vertical_edging
  end

  def vertical_line_bits
    horizontal_edging
    horizontal_spacing
    print "|"
    horizontal_spacing
    print "|"
    puts
  end

  def horizontal_line
    horizontal_edging
    20.times{print "-"}
  end    
  
  def vertical_edging
    3.times{puts}
  end

  def horizontal_spacing
    6.times{print " "}            
  end

  def horizontal_edging
    6.times{print " "}            
  end
    
end

new_game = TicTacToe.new
new_game.play