class Game 
  def initialize()
    @p1_health = 100
    @com_health = 100
    @damage = 10
    @r = Random.new
    @tools = ["Rock","Paper","Scissors"]
  end

  def message(text,delay)
    puts text
    $stdout.flush
    sleep delay
  end

  def ai_move()
    move = @r.rand(1..3)
    message("COM chose #{@tools[move-1]}",1.5)
    return move
  end

  def player_move()
    move = ""
    while(move=="") do
      message("Choose your move: 1-Rock,2-Paper,3-Scissors",0)
      input = Integer(gets.chomp) rescue nil
      unless input != nil && (1..3).include?(input)
        message("Invalid move, must type a number between 1 and 3!",0)
      else 
        move = input
      end
    end
    message("Player 1 chose #{@tools[move-1]}",1.5)
    return move
  end

  def round!(p1_move,com_move)
    p1_health = @p1_health
    com_health = @com_health

    if p1_move == com_move
      @p1_health = @p1_health - @damage 
      @com_health = @com_health - @damage
    elsif (p1_move == 1 && com_move == 3) then (@com_health = @com_health - @damage)
    elsif (p1_move == 3 && com_move == 1) then (@p1_health = @p1_health - @damage)
    elsif p1_move > com_move then (@com_health = @com_health - @damage)
    elsif p1_move < com_move then (@p1_health = @p1_health - @damage)
    end

    if (@p1_health < p1_health && @com_health < com_health ) then message("Round Result: Tie!",1.5)
    elsif (@p1_health < p1_health) then message("Round Result: COM Wins!",1.5)
    elsif (@com_health < com_health) then message("Round Result: Player 1 Wins!",1.5)
    end
  end

  def start()
    while(@p1_health > 0 && @com_health > 0) do
      puts "\e[H\e[2J"
      message("Player 1 Health = #{@p1_health} | COM Health = #{@com_health}",0)
      round!(player_move,ai_move)
    end
    if @p1_health == @com_health
      message("\n>>>>>> Final Result: Tie! <<<<<<",0)
    elsif @p1_health > @com_health
      message("\n>>>>>> Final Result: Player 1 Wins! <<<<<<",0)
    else
      message("\n>>>>>> Final Result: COM Wins! <<<<<<",0)
    end
    game_end()
  end
  
  def game_end()
    print "\nPress any button to exit..."
    $stdout.flush
    gets
  end
end

Game.new.start
