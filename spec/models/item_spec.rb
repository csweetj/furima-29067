require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/image/Railsの処理の流れ_0409.png')
  end

  describe '商品の出品' do
    context "商品を出品できる場合" do
      it "商品名、画像、商品説明、値段、カテゴリー、商品の状態、配送料、発送元、発送日数があれば商品を出品できる" do
        expect(@item).to be_valid
      end
    end
  end
 
  context "商品を出品できない場合" do
    it "商品名が空だと商品を出品できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end     
    it "画像が空だと商品を出品できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end     
    it "商品説明が空だと商品を出品できない" do
      @item.describe = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Describe can't be blank")
      
    end 
    it "値段が空だと商品を出品できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
      expect(@item.errors.full_messages).to include("Price must be number")
    end       
    it "値段が¥300〜¥9,999,999以外を入力した場合商品を出品できない" do
      @item.price = "aaa"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
    end
    it "値段が¥300以下を入力した場合商品を出品できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
    end
    it "値段が¥9,999,999以上を入力した場合商品を出品できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price between ¥300〜¥9,999,999")
    end
    it "カテゴリーが未選択だと出品できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it "商品状態が未選択だと出品できない" do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it "配達日が未選択だと出品できない" do
      @item.delivery_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery day can't be blank")
    end
    it "運賃が未選択だと出品できない" do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
    end
    it "出荷元が未選択だと出品できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "ユーザーが紐付いていないとツイートは保存できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end