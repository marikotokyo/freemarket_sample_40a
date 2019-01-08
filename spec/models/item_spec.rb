require 'rails_helper'
describe Item do
  describe '#create' do

    it "必須項目が全てあれば保存できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "出品画像が空白では保存できない" do
      image = build(:image, image: nil)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end

    it "商品名が空白では保存できない" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の説明が空白では保存できない" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("を入力してください")
    end

    it "カテゴリーが空白では保存できない" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "ブランドが空白でも保存できる" do
      item = build(:item, brand: nil)
      expect(item).to be_valid
    end

    it "サイズが空白では保存できない" do
      item = build(:item, size_id: nil)
      item.valid?
      expect(item.errors[:size_id]).to include("を入力してください")
    end

    it "商品の状態が空白では保存できない" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "発送料の負担が空白では保存できない" do
      item = build(:item, shipping_fee: nil)
      item.valid?
      expect(item.errors[:shipping_fee]).to include("を入力してください")
    end

    it "発送元の地域が空白では保存できない" do
      item = build(:item, shipping_from: nil)
      item.valid?
      expect(item.errors[:shipping_from]).to include("を入力してください")
    end

    it "発送までの日数が空白では保存できない" do
      item = build(:item, shipping_date: nil)
      item.valid?
      expect(item.errors[:shipping_date]).to include("を入力してください")
    end

    it "価格が空白では保存できない" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "商品名が41字以上は保存できない" do
      string = "あ" * 41
      item = build(:item, name: string)
      item.valid?
      expect(item.errors[:name][0]).to include("は40文字以内で入力してください")
    end

    it "商品名が40字以下は保存できる" do
      string = "あ" * 40
      item = build(:item, name: string)
      item.valid?
      expect(item).to be_valid
    end

    it "商品の説明が1001字以上は保存できない" do
      string = "あ" * 1001
      item = build(:item, description: string)
      item.valid?
      expect(item.errors[:description][0]).to include("は1000文字以内で入力してください")
    end

    it "商品の説明が1000字以下は保存できる" do
      string = "あ" * 1000
      item = build(:item, description: string)
      item.valid?
      expect(item).to be_valid
    end

    it "販売価格が9_999_999以上は保存できない" do
      int = 10 * 1000 * 1000
      item = build(:item, price: int)
      item.valid?
      expect(item.errors[:price][0]).to include("は9999999以下の値にしてください")
    end

    it "販売価格が300以下は保存できない" do
      int = 3 * 100
      item = build(:item, price: int)
      item.valid?
      expect(item).to be_valid
    end

  end

end
