require 'spec_helper'

describe ConnectFour do
  
  let(:player1) { Player.new("Fab", :red) }
  let(:player2) { Player.new("Elya", :blue) }
  let(:game) { ConnectFour.new(player1, player2) }

  context "#win_game?" do

    before :each do
      game.current_player = player1
      game.last_disc = [3,4]
    end

    it "returns true if four consecutive discs in same row are the same color" do
      game.board[3][4] = :red
      game.board[3][3] = :red
      game.board[3][2] = :red
      game.board[3][1] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if four consecutive discs in same column are the same color" do
      game.board[3][4] = :red
      game.board[2][4] = :red
      game.board[1][4] = :red
      game.board[0][4] = :red
      expect(game.win_game?).to be true
    end

    it "returns true if four consecutive discs in any diagonal are the same color" do
      game.board[3][4] = :red
      game.board[2][3] = :red
      game.board[1][2] = :red
      game.board[0][1] = :red
      expect(game.win_game?).to be true
    end

    it "returns false if four consecutive discs in same row are not the same color" do
      game.board[3][4] = :red
      game.board[3][3] = :blue
      game.board[3][2] = :red
      game.board[3][1] = :red
      expect(game.win_game?).to be false
    end

    it "returns false if four consecutive discs in same column are not the same color" do
      game.board[3][4] = :red
      game.board[2][4] = :blue
      game.board[1][4] = :red
      game.board[0][4] = :red
      expect(game.win_game?).to be false
    end

    it "returns false if four consecutive discs in any diagonal are not the same color" do
      game.board[3][4] = :red
      game.board[2][3] = :blue
      game.board[1][2] = :red
      game.board[0][1] = :red
      expect(game.win_game?).to be false
    end

  end
  
  context "#place_disc" do
    before :each do
      game.board[0][0] = :red
    end

    it "should return [i,j] as last disc" do
      expect(game.place_disc(0)).to eq([1,0])
    end
  end

  context "#play" do
    it "returns Player 1 won if rows are same color" do
      allow(game).to receive(:gets).and_return("1\n", "1\n,", "2\n", "2\n", "3\n", "3\n", "4\n")
      expect(game.play).to eq("Game over. #{player1.name} wins!")
    end

    it "returns Player 1 won if columns are same color" do
      allow(game).to receive(:gets).and_return("1\n", "2\n,", "1\n", "2\n", "1\n", "2\n", "1\n")
      expect(game.play).to eq("Game over. #{player1.name} wins!")
    end

    it "returns Player 1 won if diagonal are same color" do
      allow(game).to receive(:gets).and_return("1\n", "2\n,", "2\n", "3\n", "3\n", "4\n", "3\n", 
                                               "4\n", "4\n", "1\n", "4\n", "1\n", "4\n")
      expect(game.play).to eq("Game over. #{player1.name} wins!")
    end

    it "returns tie game" do
      allow(game).to receive(:gets).and_return("1\n", "2\,", "3\n", "4\n", "5\n", "6\n", "7\n", 
                                               "1\n", "2\,", "3\n", "4\n", "5\n", "6\n", "7\n",
                                               "1\n", "2\,", "3\n", "4\n", "5\n", "6\n", "7\n",
                                               "2\n", "1\,", "4\n", "3\n", "6\n", "5\n", "1\n", 
                                               "7\n", "3\n,", "2\n", "5\n", "4\n", "7\n", "6\n", 
                                               "2\n", "1\n,", "4\n", "3\n", "6\n", "5\n", "7\n")
      expect(game.play).to eq("Game over. It's a tie!")
    end
  end

end