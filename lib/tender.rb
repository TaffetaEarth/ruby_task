module Tender

class Lot

  attr_reader :name, :win_bet

  private

  attr_writer :duration

  public

  def initialize(name, start_price)
    @name = name
    @current_price = start_price
  end

  def suggest_bet(bet)
    if !open?
      p "time's up!"
      return false
    end
    if bet.price > @current_price
      return set_bet(bet)
    else
      p "too small bet!"
      return false
    end
  end

  def open?
    @win_bet.nil? || Time.now - @duration <= 30
  end

  def winner_bet
    if open? && @win_bet.nil?
      p "no bets placed!"
    elsif open?
      p "still possible to place a bet!"
    else
      @win_bet
    end
  end

  def set_bet(bet)
    @win_bet = bet
    @current_price = bet.price
    @duration = Time.now
    true
  end

end

class Bet

    attr_reader :price, :name

    def initialize(name, price)
      @name = name
      @price = price
    end

  end

end
