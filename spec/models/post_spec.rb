require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @post = FactoryBot.build(:post)
  end

  context "bodyが空のバリデーション" do
    it "空でないとき" do
      expect(@post).to be_valid
    end
    it "空のとき" do
      @post.body = " "
      expect(@post).to be_invalid
    end
  end

  describe "bodyが1文字以上、140文字以下である" do
    context "bodyが1文字以上の確認" do
      it "0文字のとき" do
        @post.body = "a" * 0
        expect(@post).to be_invalid
      end
      it "1文字以上のとき" do
        @post.body = "a"
        expect(@post).to be_valid
      end
    end
    context "bodyが140文字以下の確認" do
      it "141文字のとき" do
        @post.body = "a" * 141
        expect(@post).to be_invalid
      end
      it "140文字のとき" do
        @post.body = "a" * 140
        expect(@post).to be_valid
      end
    end
  end
end
