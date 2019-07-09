# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    before do
      described_class.new([sample_item]).update_quality
    end

    context 'regular item' do
      let(:sample_item) { Item.new('foo', 2, 10) }
      it 'does not change the name' do
        expect(sample_item.name).to eq 'foo'
      end

      context 'sell_in passes' do
        let(:sample_item) { Item.new('foo', -1, 10) }
        it 'decrease quality by 2' do
          expect(sample_item.quality).to eq 8
        end
      end
      context 'lowest quality' do
        let(:sample_item) { Item.new('foo', 1, 0) }
        it 'not change quality' do
          expect(sample_item.quality).to eq 0
        end
      end
      it 'decrease sell_in by 1' do
        expect(sample_item.sell_in).to eq 1
      end
      it 'decrease quality by 1' do
        expect(sample_item.quality).to eq 9
      end
    end

    context 'Aged Brie item' do
      let(:sample_item) { Item.new('Aged Brie', 2, 10) }
      it 'increase quality' do
        expect(sample_item.quality).to eq 11
      end

      context 'maximum quality' do
        let(:sample_item) { Item.new('Aged Brie', 2, 50) }
        it 'not change quality' do
          expect(sample_item.quality).to eq 50
        end
      end
    end

    context 'Sulfuras item' do
      let(:sample_item) { Item.new('Sulfuras, Hand of Ragnaros', 2, 80) }
      it 'not change quality' do
        expect(sample_item.quality).to eq 80
      end
      it 'not change sell_in' do
        expect(sample_item.sell_in).to eq 2
      end
    end

    context 'Backstage passes item' do
      let(:sample_item) { Item.new('Backstage passes to a TAFKAL80ETC concert', days, 10) }
      context 'more than 10 days left' do
        let(:days) { 11 }
        it 'increase quality by 1' do
          expect(sample_item.quality).to eq 11
        end
      end

      context '10 days left' do
        let(:days) { 10 }
        it 'increase quality by 2' do
          expect(sample_item.quality).to eq 12
        end
      end

      context '5 days left' do
        let(:days) { 5 }
        it 'increase quality by 3' do
          expect(sample_item.quality).to eq 13
        end
      end

      context 'concert passed' do
        let(:days) { -1 }
        it 'drop quality to 0' do
          expect(sample_item.quality).to eq 0
        end
      end

      context 'maximum quality' do
        let(:sample_item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 50) }
        it 'not change quality' do
          expect(sample_item.quality).to eq 50
        end
      end
    end

    context 'Conjured item' do
      let(:sample_item) { Item.new('Conjured apple', 2, 10) }

      context 'sell_in passes' do
        let(:sample_item) { Item.new('Conjured apple', -1, 10) }
        it 'decrease quality by 4' do
          expect(sample_item.quality).to eq 6
        end
      end

      context 'lowest quality' do
        let(:sample_item) { Item.new('Conjured apple', 1, 0) }
        it 'not change quality' do
          expect(sample_item.quality).to eq 0
        end
      end

      it 'decrease quality by 2' do
        expect(sample_item.quality).to eq 8
      end
    end
  end
end
