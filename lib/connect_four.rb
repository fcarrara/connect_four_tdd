require './string'
require './player'


class ConnectFour

  attr_accessor :board, :current_player, :last_disc

  ROWS = 6
  COLUMNS = 7

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    # Create array of array (6 rows x 7 cols)
    @board = Array.new(ROWS) { Array.new(COLUMNS) }
    @current_player = ""
    @last_disc = []
  end

  def print_board
    tab = "       "
    arrow = "\u2b07 "
    puts tab + "1 2 3 4 5 6 7"
    puts tab + arrow * 7
    (ROWS - 1).downto(0) do |i|
      print tab
      COLUMNS.times do |j|
        print @board[i][j].nil? ? "\u2b24" + " " : "\u2b24".color(@board[i][j]) + " "
      end
      puts ""
    end
  end

  def play
    puts "\n\n"
    print_board
    puts "\n\n"
    turn = 0

    while !win_game?
      turn += 1
      if turn < 43
        @current_player = @current_player == @player1 ? @player2 : @player1
        print "#{@current_player.name} please select a column: "
        column = gets.chomp
        place_disc(column.to_i - 1)
        puts "\n\n"
        print_board
        puts "\n\n"
      else
        return "Game over. It's a tie!"
      end
    end
    
    return "Game over. #{@current_player.name} wins!"
  end

  def place_disc(column)
    @last_disc[0] = @board.transpose[column].find_index { |x| x.nil? }
    @last_disc[1] = column
    @board[@last_disc[0]][@last_disc[1]] = @current_player.color
    @last_disc
  end

  def four_consecutives?(array)
    array.each_cons(4).any? { |a,b,c,d| [a,b,c,d].uniq == [@current_player.color] }
  end
  
  def win_game?

    return false if @current_player == ""

    row = @last_disc[0]
    column = @last_disc[1]

    # Check row
    return true if four_consecutives?(@board[row])

    # Check column
    return true if four_consecutives?(@board.transpose[column])
    
    # Check diagonals
    return true if any_consecutive_diagonal?
    
    false

  end

  def any_consecutive_diagonal?
    diagonals = [[[-1,-1],[1,1]], # NE and SO
                 [[1,-1],[-1,1]]] # NO and SE
    temp = []

    diagonals.each do |d|
      temp = [@board[@last_disc[0]][@last_disc[1]]]
      d.each do |diagonal|
        row = @last_disc[0] + diagonal[0]
        column = @last_disc[1] + diagonal[1]
          
        while row.between?(0,5) && column.between?(0,6)
          if diagonal == [-1,-1] || diagonal == [1,-1]
            temp.unshift(@board[row][column])
          else
            temp << @board[row][column]
          end
          row = row + diagonal[0]
          column = column + diagonal[1]
        end
      end

      consecutives = four_consecutives?(temp) if temp.size >= 4
      return true if consecutives

    end
    
    false

  end

end