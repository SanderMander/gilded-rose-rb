# frozen_string_literal: true

class ItemProcessor
  PROCESSORS_MAP = {
    'Aged Brie' => 'AgedBrieProcessor',
    'Sulfuras, Hand of Ragnaros' => 'SulfurasProcessor',
    'Backstage passes to a TAFKAL80ETC concert' => 'BackstageProcessor',
    'Conjured apple' => 'ConjuredProcessor'
  }.freeze
  DEFAULT_PROCESSOR = 'RegularItemProcessor'
  MINIMUM_QUALITY = 0

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
