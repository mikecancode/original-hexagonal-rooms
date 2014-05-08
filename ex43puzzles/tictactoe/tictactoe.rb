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
    @top_line = Array.new(3, nil)
    @middle_line = Array.new(3, nil)
    @bottom_line = Array.new(3, nil)
    @left_column = Array.new(3, nil)
    @middle_column = Array.new(3, nil)
    @right_column = Array.new(3, nil)
    @top_left_to_bottom_right_diagonal = Array.new(3, nil)
    @bottom_left_to_top_right_diagonal = Array.new(3, nil)
  end
  
  def setup_board
    (0..8).each { |i| @board[i] = i + 1 }
    get_rows_from_board
  end

  def get_rows_from_board
    (0..2).each { |i| @top_line[i] = @board[i] }
    (0..2).each { |i| @middle_line[i] = @board[i+3] }
    (0..2).each { |i| @bottom_line[i] = @board[i+6] }
  end

  def get_columns_from_board
    (0..2).each { |i| @left_column[i] = @board[3*i] }
    (0..2).each { |i| @middle_column[i] = @board[3*i+1] }
    (0..2).each { |i| @right_column[i] = @board[3*i+2] }
  end

  def get_diagonals_from_board
    (0..2).each { |i| @top_left_to_bottom_right_diagonal[i] = @board[4*i] }
    (0..2).each { |i| @bottom_left_to_top_right_diagonal[i] = @board[2*i+2] }
  end

  def play
#    show_empty_board
#    show_board_with_one_play_at_00
#    show_board_with_numbers
    setup_board
    show_board_with_numbers_generalized
    get_and_check_symbol
    puts "Please enter a whole number between 1 and 9 inclusive."
    players_move = get_and_check_move
    print @board; puts
    get_rows_from_board
    show_board_with_numbers_generalized
    print @top_line; puts
    print @middle_line; puts
    print @bottom_line; puts
    print @left_column; puts
    print @middle_column; puts
    print @right_column; puts
    print @top_left_to_bottom_right_diagonal; puts
    print @bottom_left_to_top_right_diagonal; puts
  end
        
  def prompt
    print "> "
    gets.chomp.downcase
  end
  
  def get_and_check_symbol
    puts "Would you like to be X or O?"
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
  end
  
  def kosher_move?(move)
    while !(1..9).to_a.include?(move)
      puts (1..9).to_a
      puts "That is not a whole number between 1 and 9 inclusive!  Please try again."
      move = prompt.to_i
    end
    move
  end

  
  
  # Below is the code for showing the board.
  # 3 simple implementations are hard-coded, one more generalized version is there as well.
  # One with the numbers 1 through 9; one with an X at 0,0, one with no plays;
  #  then a more generalized version of the one in 1 through 9.
  # I need to look at the general form given in the first implementation.
  # The plan at this point is that the game goes on the numbers are replaced by Xs and Os.
  # The more generalized version allows for this by variable substitution.
  # Though I still like the idea of giant ASCII Xs and Os and smaller numbers.
  # We'll see if that gets implemented or not.
  
  def show_board_with_numbers_generalized
    title = "This is a board with numbers, generalized:"
    top_bit(title)
    number_line(@top_line)
    in_between_framework
    number_line(@middle_line)
    in_between_framework
    number_line(@bottom_line)
    vertical_line_bits
    vertical_edging
  end

  def top_bit(title)
    puts
    puts title
    vertical_edging
    vertical_line_bits
    horizontal_spacing
  end

  def number_line(line_array)
    (0..2).each do |i|
      print " " * 3
      print "#{line_array[i]}"
      print " " * 3
      if i == 2
        puts
        return
      end
      print "|"
    end
  end

  def in_between_framework
    vertical_line_bits
    horizontal_line
    puts
    vertical_line_bits
    horizontal_spacing
  end

  
  def show_board_with_numbers
    puts
    puts "This is a board with numbers:"
    vertical_edging
    vertical_line_bits
    horizontal_spacing
    print "   7   "
    print "|"
    print "   8   "
    print "|"
    print "   9   "
    puts
    vertical_line_bits
    horizontal_line
    puts
    vertical_line_bits
    horizontal_spacing
    print "   4   "
    print "|"
    print "   5   "
    print "|"
    print "   6   "
    puts
    vertical_line_bits
    horizontal_line
    puts
    vertical_line_bits
    horizontal_spacing
    print "   1   "
    print "|"
    print "   2   "
    print "|"
    print "   3   "
    puts
    vertical_line_bits
    vertical_edging
  end
  
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