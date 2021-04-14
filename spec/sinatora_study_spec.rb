ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'json'

describe 'APIのテスト' do
  before(:each) do
    category = create(:category)
    idea = create(:idea)
    category2 = create(:category, name: 'test_category2')
    idea2 = create(:idea, category_id: 2, body: 'test_body2')
  end

  describe 'ルートディレクトリにアクセスする' do
    it '登録済みの全てのアイデアを取得する' do
      get '/'
      json = JSON.parse(last_response.body)
      # 正しい数のデータが返されたか確認
      expect(json['data'].length).to eq(2)
    end
  end

  describe '「/test_category」にアクセスするとアイデアを取得する' do
    it '「category_id: 1」(test_category)のアイデアを取得' do
      get '/test_category'
      json = JSON.parse(last_response.body)
       # 正しい数のデータ(「body: test_body」のアイデア1件のみ)が返されたか確認
       expect(json['data'].length).to eq(1)
    end
  end

  describe '登録していないカテゴリー名のリクエストの場合は404エラーとする' do
    it '/test_category3 にアクセスするとステータスコード404を返す' do
      get '/test_category3'
      expect(last_response.status).to eq(404)
    end
  end

  describe 'アイデアを登録する' do
    it '「/test_category/test_body_sub」にアクセスすると「cateogry_id: 1, body: test_body_sub」のアイデアが登録される' do
      # データが1件追加されたか確認
      expect { get '/test_category/test_body_sub' }.to change(Idea, :count).by(+1)
      # 登録成功時にステータスコード201を返すか確認
      expect(last_response.status).to eq(201)

      # 既存のアイデアと新規作成されたアイデア2件が表示されるか確認
      get '/test_category'
      json = JSON.parse(last_response.body)
      expect(json['data'].length).to eq(2)
    end
    it '「/test_category4/test_body4」にアクセスすると「category_id: 4, body: test_body4」のアイデアが登録される' do
      # データが1件追加されたか確認
      expect { get '/test_category4/test_body4' }.to change(Idea, :count).by(+1)
      # 登録成功時にステータスコード201を返すか確認
      expect(last_response.status).to eq(201)

      # カテゴリーが新しく追加されてアイデア一覧が表示されるか確認
       get '/test_category4'
       json = JSON.parse(last_response.body)
       # 新規登録されたのデータ(「body: test_body4」のアイデア1件のみ)が返されたか確認
       expect(json['data'].length).to eq(1)
    end
  end
end