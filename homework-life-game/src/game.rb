class Game
  ALIVE = 'o'
  DEAD = ' '

  def initialize(matrix)
    @matrix = matrix
  end

  def print(line_breaker = "")
    @matrix.reduce('') { |sum, row| sum + print_row(row) + line_breaker + "\r\n" }
  end

  def print_row(row)
    row.reduce('') { |cellSum, cell| cellSum + cell }
  end

  def alive?(x, y)
    @matrix[x][y] == ALIVE
  end

  def next
    if @matrix.empty? || @matrix.first.empty?
      return Game.new @matrix
    end

    Game.new next_tick_matrix()
  end

  def next_tick_matrix
    new_matrix = Array.new(@matrix.length) { Array.new(@matrix[0].length) }
    @matrix.each_index do |x|
      @matrix[x].each_index do |y|
        new_matrix[x][y] = get_life_by_checking_around(x, y)
      end
    end
    new_matrix
  end


  def get_life_by_checking_around(x, y)
    if alive?(x, y) && has_2_or_3_live_cells_around?(x, y)
        return ALIVE
    end

    if !alive?(x, y) && has_3_live_cells_around?(x, y)
      return ALIVE
    end

    DEAD
  end

  def has_3_live_cells_around?(x, y)
    counter = get_live_cells_count_around(x, y)
    counter == 3
  end

  def has_2_or_3_live_cells_around?(x, y)
    counter = get_live_cells_count_around(x, y)
    (2..3).include?(counter)
  end

  def get_live_cells_count_around(x, y)
    counter = 0
    counter+=1 if has_life_left?(x, y)
    counter+=1 if has_life_right?(x, y)
    counter+=1 if has_life_up?(x, y)
    counter+=1 if has_life_down?(x, y)
    counter+=1 if has_life_up_left?(x, y)
    counter+=1 if has_life_up_right?(x, y)
    counter+=1 if has_life_down_left?(x, y)
    counter+=1 if has_life_down_right?(x, y)
    counter
  end

  def has_life_up?(x, y)
    has_life?(x - 1, y)
  end

  def has_life_up_left?(x, y)
    has_life?(x - 1, y - 1)
  end

  def has_life_up_right?(x, y)
    has_life?(x - 1, y + 1)
  end

  def has_life_down_right?(x, y)
    has_life?(x + 1, y + 1)
  end

  def has_life_down_left?(x, y)
    has_life?(x + 1, y - 1)
  end

  def has_life_down?(x, y)
    has_life?(x + 1, y)
  end

  def has_life_right?(x, y)
    has_life?(x, y + 1)
  end

  def has_life_left?(x, y)
    has_life?(x, y - 1)
  end

  def has_life?(x, y)
    x >= 0 && x < @matrix.length && y >= 0 && y < @matrix[0].length && @matrix[x][y] == ALIVE
  end

end
