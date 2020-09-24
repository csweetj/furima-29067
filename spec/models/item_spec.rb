require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/image/Railsの処理の流れ_0409.png')
    @item.category_id = 2
    @item.condition_id = 2
    @item.delivery_day_id = 2
    @item.delivery_fee_id = 2
    @item.prefecture_id = 2
  end

  describe '商品の出品' do
    context "商品を出品できる場合" do
      it "商品名、画像、商品説明、値段、カテゴリー、商品の状態、配送料、発送元、発送日数があれば商品を出品できる" do
        expect(@item).to be_valid
      end
    end
  end
 
  context "商品を出品できない場合" do
    it "商品名、画像、商品説明、値段がないと商品を出品できない" do
      @item.name = ""
      @item.image = nil
      @item.describe = ""
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
      expect(@item.errors.full_messages).to include("Image can't be blank")
      expect(@item.errors.full_messages).to include("Describe can't be blank")
      expect(@item.errors.full_messages).to include("Price can't be blank")
      expect(@item.errors.full_messages).to include("Price must be number")
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
    end     
    it "カテゴリー、商品の状態、配送料、発送元、発送日数が未選択だと出品できない" do
      @item.category_id = 1
      @item.condition_id = 1
      @item.delivery_day_id = 1
      @item.delivery_fee_id = 1
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
      expect(@item.errors.full_messages).to include("Condition can't be blank")
      expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "値段が¥300〜¥9,999,999以外と入力された場合商品を出品できない" do
      @item.price = "aaa"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
    end
    it "ユーザーが紐付いていないとツイートは保存できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end