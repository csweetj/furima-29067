require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "ニックネームとEメール、パスワード、パスワード(確認用)、苗字、苗字(全角カタカナ)、
      名前、名前(全角カタカナ)、誕生日が存在すれば登録できる" do
      expect(@user).to be_valid
      end
      it "パスワードが6文字以上かつ英数字混合であれば登録できる" do
        @user.password = "123abc"
        @user.password_confirmation = "123abc"
        expect(@user).to be_valid
      end
      it "Eメールは＠を含むものであれば登録ができる" do
        @user.email = "aaa@bbb.ccc"
        expect(@user).to be_valid
      end
      it "苗字、名前があれば登録できる" do
        @user.first_name = "aaa"
        @user.last_name = "bbb"
        expect(@user).to be_valid
      end    
      it "苗字(全角カタカナ)、名前(全角カタカナ)がカタカナであれば登録できる" do
        @user.first_name_kana = "タナカ"
        @user.last_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "ニックネームが空だと登録できない" do
        @user.nickname = ""
        @user.valid?        
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "Eメールが空では登録できない" do
        @user.email = ""
        @user.valid?        
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "Eメールに＠を含まないのであれば登録ができない" do
        @user.email = "aaa"
        @user.valid?        
        expect(@user.errors.full_messages).to include("Eメールに@を入力してください")
      end
      it "重複したEメールが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.birthday = @user.birthday
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "パスワードが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "パスワードが5文字以下もしくは英数字混合じゃないのであれば登録できない" do
        @user.password = "a"
        @user.password_confirmation = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
        expect(@user.errors.full_messages).to include("パスワードは半角英数字を入力してください")
      end
      it "パスワードが存在してもパスワード(確認用)が空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "苗字、名前が空あれば登録できない" do
        @user.first_name = ""
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "苗字(全角カタカナ)、名前(全角カタカナ)が空あれば登録できない" do
        @user.first_name_kana = ""
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角カタカナ)を入力してください")
        expect(@user.errors.full_messages).to include("苗字(全角カタカナ)は全角カタカナで入力してください")
        expect(@user.errors.full_messages).to include("名前(全角カタカナ)を入力してください")
        expect(@user.errors.full_messages).to include("名前(全角カタカナ)は全角カタカナで入力してください")
      end
      it "苗字(全角カタカナ)、名前(全角カタカナ)がカタカナ以外であれば登録できない" do
        @user.first_name_kana = "tanaka"
        @user.last_name_kana = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角カタカナ)は全角カタカナで入力してください")
        expect(@user.errors.full_messages).to include("名前(全角カタカナ)は全角カタカナで入力してください")
      end
      it "誕生日が空だと登録ができない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
