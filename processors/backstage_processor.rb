# frozen_string_literal: true

class BackstageProcessor < ItemProcessor
  MAXIMUM_QUALITY = 50
  def new_sell_in
    sell_in - 1
  end

  def new_quality
    return 0 if sell_in.negative?

    increment = if sell_in < 6
                  3
                elsif sell_in < 11
                  2
                else
                  1
                end
    new_value = quality + increment
    return MAXIMUM_QUALITY if new_value > MAXIMUM_QUALITY
    new_value
  end
end
