# This version of TicTacToe does not use an AI that is as intelligent as possible
# Instead, it uses an algorithm that plays randomly unless either an AI win or 
#   a user win is imminent, in which case it plays to win or block.
# If the user plays to forces a win, it will block the first spot it finds.
# Thus the user can win eventually, in theory, though there is always a chance that
#   the program will get lucky if the user is not paying attention.
# So a win from the user is required to win the game.

class TicTacToe

  # @players_symbol will be either "X" or "O" - their choice.
  # @ai_symbol will be whichever the player does not choose.
  # @board stores either an "X", an "O", or nothing as each element
  # @triples is an array of 3-element arrays - the 3 rows, 3 columns, and 2 diagonals;
  #   it is used to check for win and potential win situations.

  DISPLAY = { "X" => ["    #       #    ",
                      "      #   #      ",
                      "        #        "],
                      
              "O" => ["      *****      ",
                      "     *     *     ",
                      "    *       *    "]
            }

  def initialize
    @board = Array.new(9)
    @symbols = ["X", "O"]
  end
  
  def get_triples(board)
    triples = Array.new(8) { Array.new(3) }
    (0..2).each do |i|
      (0..2).each do |j| 
        triples[i][j] = board[3*i+j]    # rows
        triples[i+3][j] = board[i+3*j]  # columns
        triples[6][j] = board[4*j]      # 1st diagonal
        triples[7][j] = board[6-2*j]    # 2nd diagonal
      end
    end
    triples
  end

  def prompt
    print "> "
    gets.chomp.downcase
  end
  
  def please_press_enter_to_continue
    puts "The TicTacToe master will now play."
    puts "Please press enter to see the master's move."
    prompt
  end
  
  def get_check_and_store_symbols
    puts "Would you like to be X or O?"
    @players_symbol = (kosher_symbol?(prompt)).upcase    
    @ai_symbol = @symbols[(@symbols.index(@players_symbol) + 1).modulo(2)]
  end
  
  def kosher_symbol?(choice)
    while !(choice == "x" or choice == "o")
      puts "That choice is neither X nor O!  Please try again."
      choice = prompt
    end
    choice
  end
  
  def get_check_and_store_move(board)
    puts "Please make your move by entering any of the numbers that are still available on the board."
    players_move = kosher_move?(prompt.to_i, board)
    board[players_move-1] = @players_symbol
  end
  
  def kosher_move?(move, board)
    while !(1..9).to_a.include?(move) or board[move - 1] != nil
      puts "That is not a number that is still available on the board!  Please try again."
      move = prompt.to_i
    end
    move
  end
  
  # play is the main engine of the game.
  
  def play
    game_state = "start"
    get_check_and_store_symbols
    loop do
      display_board(@board)
      get_check_and_store_move(@board)
      display_board(@board)
      if player_wins?(@board)
        break
      elsif stalemate?(@board)
        game_state = "stalemate"
        break
      end
      please_press_enter_to_continue
      ai_plays(@board)     
      if ai_wins?(@board)
        display_board(@board)
        game_state = "ai wins"
        break
      elsif stalemate?(@board)
        display_board(@board)
        game_state = "stalemate"
        break
      end
    end    
    if game_state == "stalemate"
      puts "Looks like a draw."
      invitation
    elsif game_state == "ai wins"
      puts "Oh no, the TicTacToe master has won."
      invitation
    else
      puts "Congratulations!  You've Won!"    
    end
  end  
  
  def invitation
    puts "Please come back and try again."
  end
    
  def player_wins?(board)
    any_in_a_row?(board, 3, @players_symbol)
  end

  def stalemate?(board)
    board_full?(board) and !player_wins?(board) and !ai_wins?(board)
  end
  
  def board_full?(board)
    board.all?
  end

  def ai_wins?(board)
    any_in_a_row?(board, 3, @ai_symbol)
  end

  def ai_plays(board)
    ai_can_win, winning_triple = any_in_a_row?(board, 2, @ai_symbol)
    ai_can_block, blockable_triple = any_in_a_row?(board, 2, @players_symbol)
    if ai_can_win
      ai_plays_in_cell(winning_triple, board)
    elsif ai_can_block
      ai_plays_in_cell(blockable_triple, board)
    else
      ai_plays_randomly(board)
    end      
  end
  
  # count determines whether we are checking for a win (count = 3)
  #   or looking for a space to play in (count = 2).
  # In the latter case, the function will return a second argument,
  #   which is used to find an empty cell to play in.

  def any_in_a_row?(board, count, symbol)
    get_triples(board).each do |triple|
      i = 0
      any_empty_cell = false
      (0..2).each do |j|
        if triple[j] == symbol
          i += 1
        elsif triple[j] == nil
          any_empty_cell = true
        end
      end
      if i == count
        if count == 3
          return true
        elsif count == 2 and any_empty_cell == true
          return true, get_triples(board).index(triple)
        end
      end
    end
    false
  end

  def ai_plays_in_cell(triple, board)
    i = get_triples(board)[triple].index { |cell| cell == nil }
    if (0..2).include? triple             # rows
      board[i + 3 * triple] = @ai_symbol
    elsif (3..5).include? triple          # columns
      board[3 * i + triple - 3] = @ai_symbol
    elsif triple == 6                     # 1st diagonal
      board[4 * i] = @ai_symbol
    elsif triple == 7                     # 2nd diagonal
      board[6 - 2 * i] = @ai_symbol
    end
  end              
  
  def ai_plays_randomly(board)
    board[(board.map.with_index { |element, i| i if element == nil }).compact.sample] = @ai_symbol
  end

  # Below is display_board, and its related functions.
  # It displays whatever is in @board, if @board is passed to it. 
  # The display format is a small number for a nil in @board or a large ASCII symbol for an X or O.
    
  def display_board(board)
    puts "\nHere is the board so far:"
    vertical_space
    puts vertical_line_bits
    (0..2).each do |i|
      (0..4).each do |j|
        print horizontal_space
        puts *(0..2).map { |k| display_cell_row(board[3 * i + k], 3 * i + k + 1, j) }.join("|")
      end
      puts vertical_line_bits
      if i < 2
        puts horizontal_line
        puts vertical_line_bits
      else
        vertical_space
      end
    end
  end
    
  # abs allows for using the symmetry of the X and O displays so DISPLAY only needs 3 elements for each
  
  def display_cell_row(symbol, cell_number, row_number)
    if symbol
      DISPLAY[symbol][ -(row_number - 2).abs + 2 ]
    elsif row_number == 2
      " " * 8 + cell_number.to_s + " " * 8
    else
      horizontal_space
    end
  end
  
  # Below are four helper functions that are used in display_board and display_cell_row

  def vertical_line_bits
    horizontal_space + ([horizontal_space] * 3).join("|")
  end

  def horizontal_line
    horizontal_space + (["-" * 17] * 3).join("|")
  end    
  
  def vertical_space
    3.times{puts}
  end

  def horizontal_space
    " " * 17
  end

end

new_game = TicTacToe.new
new_game.play