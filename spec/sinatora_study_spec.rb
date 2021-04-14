ENV['RACK_ENV'] = 'test'
require 'spec_helper'
require 'json'

describe 'ルートディレクトリにアクセスする' do
  it '登録済みの全てのアイデアを取得する' do
    @category = create(:category)
    @idea = create(:idea)

    get '/'
    json = JSON.parse(last_response.body)

    # 通信が成功したか確認
    expect(last_response).to be_ok
    # 正しい数のデータが返されたか確認
    expect(json['data'].length).to eq(1)
  end
end