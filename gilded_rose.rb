class ItemProcessor
  PROCESSORS_MAP = {
    'Aged Brie' => 'AgedBrieProcessor',
    'Sulfuras, Hand of Ragnaros' => 'SulfurasProcessor',
    'Backstage passes to a TAFKAL80ETC concert' => 'BackstageProcessor'
  }.freeze
  DEFAULT_PROCESSOR = 'RegularItemProcessor'.freeze

  def self.call(item)
    class_name = PROCESSORS_MAP[item.name] || DEFAULT_PROCESSOR
    Object.const_get(class_name).new(item).process
  end

  def initialize(item)
    @item = item
  end

  def process
    new_values = {
      name: @item.name,
      sell_in: new_sell_in,
      quality: new_quality
    }
    @item.name = new_values[:name]
    @item.sell_in = new_values[:sell_in]
    @item.quality = new_values[:quality]
  end

  private

    def sell_in
      @item.sell_in
    end

    def quality
      @item.quality
    end

    def new_sell_in
      raise NotImplementedError
    end

    def new_quality
      raise NotImplementedError
    end
end

class RegularItemProcessor < ItemProcessor

  def new_sell_in
    sell_in - 1
  end

  def new_quality
    new_value = if sell_in > 0
      quality - 1
    else
      quality - 2
    end
    new_value = 0 if new_value < 0
    new_value
  end
end

class AgedBrieProcessor < ItemProcessor
  def new_sell_in
    sell_in - 1
  end

  def new_quality
    new_value = quality + 1
    new_value = 50 if new_value > 50
    new_value
  end
end

class SulfurasProcessor < ItemProcessor

  def new_sell_in
    sell_in
  end

  def new_quality
    quality
  end

end
class BackstageProcessor < ItemProcessor

  def new_sell_in
    sell_in - 1
  end

  def new_quality
    return 0 if sell_in < 0
    increment = if sell_in < 6
      3
    elsif sell_in < 11
      2
    else
      1
    end
    quality + increment
  end

end


class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      ItemProcessor.call(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
