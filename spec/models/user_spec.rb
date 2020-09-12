require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "nameのバリデーション確認" do
    context "半角英数字ではバリデーションされる" do
      it "1文字目は半角文字、2文字以降半角英数字である" do
        expect(@user).to be_valid
      end
      it "1文字目が数字である" do
        @user.name = "0test"
        expect(@user).to be_invalid
      end
      it "全角文字が含まれている" do
        @user.name = "テスト"
        expect(@user).to be_invalid
      end
    end

    context "空では保存されない" do
      it "空ではない場合" do
        expect(@user).to be_valid
      end
      it "空の場合" do
        @user.name = " "
        expect(@user).to be_invalid
      end
    end

    context "２文字未満では保存されない" do
      it "2文字未満の場合" do
        @user.name = "a"
        expect(@user).to be_invalid
      end
      it "2文字以上の場合" do
        @user.name = "a" * 2
        expect(@user).to be_valid
      end
    end
    
    context "20文字を超えると保存されない" do
      it "20文字を超える場合" do
        @user.name = "a" * 21
        expect(@user).to be_invalid
      end
      it "20文字以内の場合" do
        @user.name = "a" * 20
        expect(@user).to be_valid
      end
    end

    it "一意性である" do
      duplicate_user = @user.dup
      duplicate_user.name = @user.name.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end
  end

  describe "emailのバリデーションの確認" do
    context "emailが空でない" do
      it "空でない場合" do
        expect(@user).to be_valid
      end
      it "空の場合" do
        @user.email = " "
        expect(@user).to be_invalid
      end
    end

    context "emailのフォーマットの確認" do
      it "正しいフォーマット" do
        expect(@user).to be_valid
      end
      context "間違ったフォーマット1" do
        it "間違ったフォーマット" do
          @user.email = "foo@example@com"
          expect(@user).to be_invalid
        end
        it "間違ったフォーマット2" do
          @user.email = "foo@example,com"
          expect(@user).to be_invalid
        end
        it "間違ったフォーマット3" do
          @user.email = "foo@example"
          expect(@user).to be_invalid
        end
        it "間違ったフォーマット4" do
          @user.email = "foo@example_foo.com"
          expect(@user).to be_invalid
        end
      end
    end
  end
  
  context "passwordが空でない" do
    it "空でない場合" do
      expect(@user).to be_valid
    end
    it "passwordが空欄でない" do
      @user.password_digest = " "
      expect(@user).to be_invalid
    end
  end
end
