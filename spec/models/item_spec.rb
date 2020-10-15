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
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end     
    it "画像が空だと商品を出品できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end     
    it "商品の説明が空だと商品を出品できない" do
      @item.describe = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      
    end 
    it "価格が空だと商品を出品できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を入力してください")
      expect(@item.errors.full_messages).to include("価格は数字でなければなりません")
      expect(@item.errors.full_messages).to include("価格を ¥300〜¥9,999,999の範囲まで入力してください")
    end       
    it "価格が¥300〜¥9,999,999以外を入力した場合商品を出品できない" do
      @item.price = "aaa"
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を ¥300〜¥9,999,999の範囲まで入力してください")
    end
    it "価格が¥300以下を入力した場合商品を出品できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を ¥300〜¥9,999,999の範囲まで入力してください")
    end
    it "価格が¥9,999,999以上を入力した場合商品を出品できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を ¥300〜¥9,999,999の範囲まで入力してください")
    end
    it "カテゴリーが未選択だと出品できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
    end
    it "商品の状態が未選択だと出品できない" do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を選択してください")
    end
    it "発送までの日数が未選択だと出品できない" do
      @item.delivery_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
    end
    it "配送料の負担が未選択だと出品できない" do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
    end
    it "発送元の地域が未選択だと出品できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
    end
    it "ユーザーが紐付いていないとツイートは保存できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Userを入力してください")
    end
  end
end