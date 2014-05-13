# This version of TicTacToe will not use an AI that is as intelligent as possible
# Instead, it will use an algorithm that plays randomly unless a user win is imminent,
#   in which case it will block that win (two in one line by the user).
# If the user plays and forces a win, it will block randomly and lose.
# Thus the user can win eventually, in theory, though there is always a chance that
# the program will get lucky.  So a win from the user is required to win the game.

class TicTacToe

  # @players_symbol will be either X or O
  # @board stores either an X, an O, or one of the numbers 1-9 as each element
  # @triples is an array of 3-element arrays - the 3 rows, 3 columns, and 2 diagonals

  X_DISPLAY = ["  #       #  ", "    #   #    ", "      #      "]
  O_DISPLAY = ["    *****    ", "   *     *   ", "  *       *  "]

  def initialize
    @board = Array.new(9)
  end
  
  def get_triples(board)
    triples = Array.new(8) { Array.new(3) }
    (0..2).each do |i|
      (0..2).each do |j| 
        triples[i][j] = board[3*i+j]
        triples[i+3][j] = board[i+3*j]
        triples[6][j] = board[4*j]
        triples[7][j] = board[6-2*j]
      end
    end
    print triples
  end

  # show_triples is just to view the arrays - won't be used in the final code

  def show_triples
    triples = get_triples(@board)
    print triples
#    show_board
    (0..7).each { |triple| print triples[triple]; puts }
  end

  def create_test_board(board)
    board[0] = "X"
    board[2] = "O"
    board[4] = "X"
    board[5] = "O"
    board[8] = "O"
  end

  def play
    create_test_board(@board)
    show_board_with_giant_ascii_art_hard_coded
    print_an_X
    puts
    print_an_O
    puts
    print_a_five
=begin
    show_board(@board)    
    show_triples
    get_check_and_store_symbol
    win_for_player = false
    win_for_AI = false
    stalemate = false
    loop do
      if win_for_player?
        break
      end
      show_board
      please_enter
      players_move = get_check_and_store_move
      ai_plays
      if win_for_AI?
        win_for_AI = true
        break
      end    
    end
    show_board
    if stalemate
      puts "Looks like a draw."
      invitation
    elsif win_for_AI
      puts "Oh no, the TicTacToe master has won."
      invitation
    else
      puts "Congratulations!  You've Won!"    
    end
=end
  end

  def please_enter
    puts "Please enter ... "
  end

  def prompt
    print "> "
    gets.chomp.downcase
  end
  
  def get_check_and_store_symbol
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
  
  def get_check_and_store_move
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

  def win_for_player?
    get_triples_from_board
    if any_in_a_row?(3)
      return true
    end
    false
  end
  
  def any_in_a_row?(duple_or_triple)    
    block_move = nil
    @triples.each do |triple|
      i = 0
      (0..2).each do |j|
        if triple[j] == @players_symbol
          i += 1
        elsif (0..1).include? triple[j]
          block_move = triple[j]
        end
        if i == duple_or_triple
          return true, block_move
        end
      end
    end
    false
  end

  def ai_plays
    if stalemate?
      stalemate = true
      return
    elsif opportunity_for_ai_win?
      play_AI_win
      win_for_AI = true
      return
    elsif player_has_blockable_duple?
      block_duple(duple)
    else
      play_randomly
    end      
  end
    
  def stalemate?
  
  end
  
  def invitation
    puts "Please come back and try again."
  end

  

  def opportunity_for_AI_win?
  end
  
  def play_AI_win
  end
  
  def player_has_blockable_duple?
  end
  
  def block_duple(duple)
  end
  
  def play_randomly
  end
  
  def win_for_AI?
  end
  
  def get_unplayed_numbers
    @board.each do |i|
      (1..9)
    end
  end
  
  def find_winning_triple
  end

  # Below is the code for showing the board.  Two versions are shown.
  # One with the numbers 1 through 9 hard-coded, and one which uses the row instance variables.
  # show_board is the one used in the game; I'm keeping show_board_hard_coded for reference.
  # Also, I still like the idea of giant ASCII Xs and Os and smaller numbers.
  # I may still implement that version..
  
  
#  def show_board
#    title = "This is the board:"
#    top_bit(title)
#    number_line(@top_row)
#    in_between_framework
#    number_line(@middle_row)
#    in_between_framework
#    number_line(@bottom_row)
#    vertical_line_bits
#    vertical_edging
#  end

#  def top_bit(title)
#    puts
#    puts title
#    vertical_edging
#    vertical_line_bits
#    horizontal_spacing
#  end

#  def in_between_framework
#    vertical_line_bits
#    horizontal_line
#    puts
#    vertical_line_bits
#    horizontal_spacing
#  end
  
  
=begin  
  Anshul:  Here's an idea, try something like:
  def display_cell_row(symbol, cell_number, row_number)
  row_number is 0, 1, or 2     # edit: or 3 or 4!! -mike
   Anshul:  cell_number is 1-9
   me:  so it picks from the symbol or cell_number, depending?
   Anshul:  yeah, if symbol is non-nil, it will ignore cell_number 
  in all cases, it returns a 3-char string    # edit: 5-char! -mike
   Anshul:  then show_board could use that function, calling it when appropriate
=end

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
      print "-" * 13 + "|"
    end
    print "-" * 13
  end    
  
  def vertical_edging
    3.times{puts}
  end

  def horizontal_spacing
    print " " * 13      
  end
  
  def display_cell_row(symbol, cell_number, row_number)
    if symbol == "X" and row_number <= 2
      return X_DISPLAY[row_number]
    elsif symbol == "X" and row_number > 2
      return X_DISPLAY[4 - row_number]
    elsif symbol == "O" and row_number <= 2
      return O_DISPLAY[row_number]
    elsif symbol == "O" and row_number > 2
      return O_DISPLAY[4 - row_number]
    elsif row_number != 2
      return " " * 13
    else
      return " " * 6 + (cell_number).to_s + " " * 6
    end
  end

  # Nothing belowe this point (and still in the class) will be used in the final version

  # The next three methods were just written to test out desplay_cell_row

  def print_an_X
    (0..4).each do |row|
      print display_cell_row("X", 1, row)
      puts
    end
  end

  def print_an_O
    (0..4).each do |row|
      print display_cell_row("O", 1, row)
      puts
    end
  end

  def print_a_five
    (0..4).each do |row|
      print display_cell_row(nil, 5, row)
      puts
    end
  end
  
  # Below is the "longhand" version of the bigger board with ASCII art, to get a sense of the layout
  
  def show_board_with_giant_ascii_art_hard_coded
    puts
    puts "This is a very hard-coded board with giant ASCII art and numbers:"
    vertical_edging
    vertical_line_bits
    horizontal_spacing
    print "  #       #  "
    print "|"
    print " " * 13
    print "|"
    print "    *****    "
    puts
    horizontal_spacing
    print "    #   #    "
    print "|"
    print " " * 13
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing
    print "      #      "
    print "|"
    print "      2      "
    print "|"
    print "  *       *  "
    puts
    horizontal_spacing
    print "    #   #    "
    print "|"
    print " " * 13
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing
    print "  #       #  "
    print "|"
    print " " * 13
    print "|"
    print "    *****    "
    puts
    vertical_line_bits
    horizontal_line
    puts
    vertical_line_bits
    horizontal_spacing
    print " " * 13
    print "|"
    print "  #       #  "
    print "|"
    print "    *****    "
    puts
    horizontal_spacing
    print " " * 13
    print "|"
    print "    #   #    "
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing
    print "      4      "
    print "|"
    print "      #      "
    print "|"
    print "  *       *  "
    puts
    horizontal_spacing
    print " " * 13
    print "|"
    print "    #   #    "
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing
    print " " * 13
    print "|"
    print "  #       #  "
    print "|"
    print "    *****    "
    puts
    vertical_line_bits
    horizontal_line
    puts
    vertical_line_bits
    horizontal_spacing
    print " " * 13
    print "|"
    print " " * 13
    print "|"
    print "    *****    "
    puts
    horizontal_spacing
    print " " * 13
    print "|"
    print " " * 13
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing
    print "      7      "
    print "|"
    print "      8      "
    print "|"
    print "  *       *  "
    puts
    horizontal_spacing
    print " " * 13
    print "|"
    print " " * 13
    print "|"
    print "   *     *   "
    puts
    horizontal_spacing    
    print " " * 13
    print "|"
    print " " * 13
    print "|"
    print "    *****    "
    puts
    vertical_line_bits
    vertical_edging
  end
    
  # The version below was written to just get a sense of the original (smaller) layout
  
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