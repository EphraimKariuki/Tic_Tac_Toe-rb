# module TicTacToe
  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
      @board = Array.new(3) { Array.new(3) }
      @current_player = player1
      @winner = nil
    end
    def play
      puts "Welcome to Tic Tac Toe!"
      puts "Player 1: #{@player1.name} (#{@player1.marker})"
      puts "Player 2: #{@player2.name} (#{@player2.marker})"
      puts "Let's play!"
      play_round
    end
    def play_round
      while @winner.nil?
        display_board
        player_move
        check_winner
        switch_player
      end
      display_board
      puts "Congratulations, #{@winner}! You won!"
    end
    def display_board
      if @board.flatten.count(nil) == 9
        cell_value = 0
        @board.each_with_index do |row, row_index|
          row.each_with_index do |cell, cell_index|
             cell_value += 1
            row[cell_index] = cell_value
            print "#{row[cell_index]} "
          end
          puts
        end
      else 
        @board.each_with_index do |row, row_index|
          row.each_with_index do |cell, cell_index|
            row[cell_index] = cell
            print "#{cell} "
          end
          puts
        end
        
      end  
    end
    def player_move
      puts "It's #{@current_player.name}'s turn. Enter a number to place your marker:"
      input = gets.chomp
      if @board.flatten.count(input.to_i) == 1
        @board.each do |row|
          row.each_with_index do |cell, cell_index|
            if cell == input.to_i
              row[cell_index] = @current_player.marker
            end
          end 
          # player_move
        end 
      else
        puts "Invalid move. Please try again."
        player_move
      end  
    end
    def check_winner
      # check rows
      @board.each do |row|
        if row.uniq.length == 1 && row.first != nil
          @winner = @current_player
          return
        end
      end
      # check columns
      @board.transpose.each do |col|
        if col.uniq.length == 1 && col.first != nil
          @winner = @current_player
          return
        end
      end  
      # check diagonals
      if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0]  
        @winner = @current_player
        return
      end
      if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2]  
        @winner = @current_player
        return
      end
    end
    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
    def free_cells
      @board.flatten.count(nil)
    end
    
  end
    
  class Player
    attr_accessor :name, :marker
    def initialize(name, marker)
      @name = name
      @marker = marker
    end
    def move(board)
      # code to get player's move 
      puts "It's #{@name}'s turn. Enter a number to place your marker:"
      input = gets.chomp
      row = input[0].to_i - 1
      col = input[1].to_i - 1
      if board[row][col].nil?
        board[row][col] = @marker
      else
        puts "That cell is already occupied. Please try again."
        move(board)
      end 
    end
  end
  class HumanPlayer < Player
    def move(board)
      # code to get player's move
      puts "Enter a number to place your marker:"
      input = gets.chomp
      row = input[0].to_i - 1
      col = input[1].to_i - 1
      if board[row][col].nil?
        board[row][col] = marker
      else
        puts "That cell is already occupied. Please try again."
        move(board)
      end
    end
    def get_move
      # code to get player's move
      puts "Enter a row and column to place your marker (e.g. 1 2):"
      input = gets.chomp
      row = input[0].to_i - 1
      col = input[1].to_i - 1
      [row, col]
    end
    
  end
  
# end
# include TicTacToe 
game = Game.new(HumanPlayer.new("Player 1", "X"), HumanPlayer.new("Player 2", "O"))
game.play
# end