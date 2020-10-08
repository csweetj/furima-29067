require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @order_address = FactoryBot.build(:address)
  end

  describe '注文成功' do
    context "商品を注文できる場合" do
      it "token、postal_code、prefecture_id、city、house_number、building_name、phone_numberがあれば保存ができることる" do
        expect(@order_address).to be_valid
      end
    end
  end
end
