require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、password、password_confirmation、first_name、first_name_kana、
      last_name、last_name_kana、birthdayが存在すれば登録できる" do
      expect(@user).to be_valid
      end
      it "passwordが6文字以上かつ英数字混合であれば登録できる" do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
      it "first_name_kana、last_name_kanaがカタカナであれば登録できる" do
        @user.first_name_kana = "タナカ"
        @user.last_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?        
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?        
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.birthday = @user.birthday
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下もしくは英数字混合じゃないのであれば登録できない" do
        @user.password = "a"
        @user.password_confirmation = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "first_name_kanaがカタカナ以外であれば登録できない" do
        @user.first_name_kana = "tanaka"
        @user.last_name_kana = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
    end
  end
end
