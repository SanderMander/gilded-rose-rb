# frozen_string_literal: true

$LOAD_PATH << './processors'
require 'item_processor'
require 'regular_item_processor'
require 'aged_brie_processor'
require 'sulfuras_processor'
require 'backstage_processor'
require 'conjured_processor'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
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

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
