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
    @top_row = Array.new(3, nil)
    @middle_row = Array.new(3, nil)
    @bottom_row = Array.new(3, nil)
    @left_column = Array.new(3, nil)
    @middle_column = Array.new(3, nil)
    @right_column = Array.new(3, nil)
    @top_left_to_bottom_right_diagonal = Array.new(3, nil)
    @bottom_left_to_top_right_diagonal = Array.new(3, nil)
    @triples = Array.new(8, nil)
  end
  
  def setup_board
    (0..8).each { |i| @board[i] = i + 1 }
    get_triples_from_board
  end

  def get_triples_from_board
    (0..2).each { |i| @top_row[i] = @board[i] }
    (0..2).each { |i| @middle_row[i] = @board[i+3] }
    (0..2).each { |i| @bottom_row[i] = @board[i+6] }
    (0..2).each { |i| @left_column[i] = @board[3*i] }
    (0..2).each { |i| @middle_column[i] = @board[3*i+1] }
    (0..2).each { |i| @right_column[i] = @board[3*i+2] }
    (0..2).each { |i| @top_left_to_bottom_right_diagonal[i] = @board[4*i] }
    (0..2).each { |i| @bottom_left_to_top_right_diagonal[i] = @board[6-2*i] }
    @triples = [ @top_row, @middle_row, @bottom_row, @left_column, @middle_column, @right_column,
                  @top_left_to_bottom_right_diagonal, @bottom_left_to_top_right_diagonal
                ]
  end

  # show_triples is just to view the arrays - won't be used in the final code

  def show_triples
    get_triples_from_board
    show_board
    print @top_row; puts
    print @middle_row; puts
    print @bottom_row; puts
    print @left_column; puts
    print @middle_column; puts
    print @right_column; puts
    print @top_left_to_bottom_right_diagonal; puts
    print @bottom_left_to_top_right_diagonal; puts
  end

  def play
    setup_board
    get_and_check_symbol
    while !player_has_winning_triple?
      show_board    
      puts "Please enter a whole number between 1 and 9 inclusive."
      players_move = get_and_check_move
    end
    show_board
    puts "Congratulations!  You've Won!"    
  end
        
  def prompt
    print "> "
    gets.chomp.downcase
  end
  
  def get_and_check_symbol
    puts "Would you like to be X or O?"
    @players_symbol = (kosher_symbol?(prompt)).upcase
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
    @board[players_move-1] = @players_symbol
  end
  
  def kosher_move?(move)
    while !(1..9).to_a.include?(move)
      puts (1..9).to_a
      puts "That is not a whole number between 1 and 9 inclusive!  Please try again."
      move = prompt.to_i
    end
    move
  end

  def player_has_winning_triple?
    get_triples_from_board
    @triples.each do |triple|
      i = 0
      (0..2).each do |j|
        if triple[j] == @players_symbol
          i += 1
        end
        if i == 3
          return true
        end
      end
    end
    false
  end
  
  # Below is the code for showing the board.  Two versions are shown.
  # One with the numbers 1 through 9 hard-coded, and one which uses the row instance variables.
  # show_board is the one used in the game; I'm keeping show_board_hard_coded for reference.
  # Also, I still like the idea of giant ASCII Xs and Os and smaller numbers.
  # I may still implement that version..
  
  def show_board
    title = "This is the board:"
    top_bit(title)
    number_line(@top_row)
    in_between_framework
    number_line(@middle_row)
    in_between_framework
    number_line(@bottom_row)
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

  def show_board_hard_coded
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
      
end

new_game = TicTacToe.new
new_game.play