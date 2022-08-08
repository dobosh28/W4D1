require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over? 
      if @board.winner == evaluator || @board.winner.nil?
        return false
      else
        return true
      end
    end

    if evaluator == :o
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end
 # :x if human player :o is computer

  def winning_node?(evaluator)
    
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  # :o, :x
  def children
    all_empty_positions = []
    (0...@board.rows.length).each do |i|
      (0...@board.rows.length).each do |j|
        all_empty_positions << [i,j] if @board.empty?([i,j])
      end
    end

    children = []

    all_empty_positions.each do |pos|
      dupped_board = @board.dup
      dupped_board[pos] = @next_mover_mark

      if @next_mover_mark == :o 
        next_next_mover_mark = :x
      else
        next_next_mover_mark = :o 
      end

      child = TicTacToeNode.new(dupped_board, next_next_mover_mark, pos)
      children << child
    end

    children
  end

end
