require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '注文成功' do
    context "商品を注文できる場合" do
      it "token、postal_code、prefecture_id、city、house_number、building_name、phone_numberがあれば保存ができることる" do
        token = "tok_abcdefghijk00000000000000000"
        expect(@order).to be_valid
      end
    end
  end
end
