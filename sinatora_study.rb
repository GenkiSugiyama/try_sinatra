require 'sinatra'
require './sinatra/activerecord'
require './models/category.rb'
require './models/idea.rb'
require 'sinatra/reloader'
require 'json'

set :database_file, "./config/database.yml"

get '/' do
  # ideasを全件取得、1レコードずつハッシュ化し配列に格納
  # ideas = []
  # for i in 1..Idea.all.size do
  #   idea = Idea.find(i)
  #   parent_category = Category.find(idea.category_id)
  #   idea_hash = {}
  #   idea_hash["id"] = idea.id
  #   idea_hash["category"] = parent_category.name
  #   idea_hash["body"] = idea.body
  #   ideas.push(idea_hash)
  # end
  # data = { "data": ideas }
  # return data.to_json
  "Hello World"
end

# アイデア登録API
get '/:category_name/:body' do
  # パラメーターのいずれかがない場合はエラーを返す
  if params[:category_name].empty? or params[:body].empty?
    return { status: "error", code: 402 }.to_json
  end

  category = Category.find_by(name: params[:category_name])
  puts category.class
  if category.check_exist
    idea = Idea.new(category_id: category.id, body: params[:body])
    if idea.save
      { result: "success", code: 201 }.to_json
    else
      { result: "failure" }.to_json
    end
  else
    new_category = Category.new(name: params[:category_name])
    if new_category.save
      { result: "success", code: 201 }.to_json
    else
      { result: "failure" }.to_json
    end
  end
end

# アイデア取得API
get '/:category_name' do
  if params[:category_name].present?
    params_category = Category.find_by(name: params[:category_name])
    # カテゴリが存在していなければ404
    if params_category.nil?
      not_found
    end

    # 親カテゴリ名でideaを検索し1レコードずつハッシュ化
    searched_ideas = Idea.where(category_id: params_category.id)
    ideas = []
    for i in 0..searched_ideas.size - 1 do
      idea_hash = {}
      idea_hash["id"] = searched_ideas[i].id
      idea_hash["category"] = params_category.name
      idea_hash["body"] = searched_ideas[i].body
      ideas.push(idea_hash)
    end
    data = { "data": ideas }
    return data.to_json
  else
    redirect "/"
  end
end

not_found do
  "404 error"
end
