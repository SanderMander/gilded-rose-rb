# frozen_string_literal: true

class RegularItemProcessor < ItemProcessor
  def new_sell_in
    sell_in - 1
  end

  def new_quality
    new_value = if sell_in.positive?
                  quality - 1
                else
                  quality - 2
    end
    return MINIMUM_QUALITY if new_value < MINIMUM_QUALITY
    new_value
  end
end
