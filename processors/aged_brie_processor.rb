# frozen_string_literal: true

class AgedBrieProcessor < ItemProcessor
  MAXIMUM_QUALITY = 50
  def new_sell_in
    sell_in - 1
  end

  def new_quality
    new_value = quality + 1
    return  MAXIMUM_QUALITY if new_value > MAXIMUM_QUALITY
    new_value
  end
end
