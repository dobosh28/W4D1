require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) # evaluator is "us" for now
    if evaluator == :x
      opponent = :o
    else
      opponent = :x
    end

    if @board.over? 
      if @board.winner == evaluator || @board.winner.nil?
        return false
      else
        return true
      end
    end

    if @next_mover_mark == evaluator # currently player's turn
      return self.children.all? {|child| child.losing_node?(evaluator)}
    elsif @next_mover_mark == opponent # opponent's turn
      return self.children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if evaluator == :x
      opponent = :o
    else
      opponent = :x
    end

    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end

    if @next_mover_mark == evaluator # currently player's turn
      return self.children.any? {|child| child.winning_node?(evaluator)}
    elsif @next_mover_mark == opponent # opponent's turn
      return self.children.all? {|child| child.winning_node?(evaluator)}
    end
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
