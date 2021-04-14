ENV['RACK_ENV'] = 'test'
require "spec_helper"

describe "get root directory" do
  it "should allow accessing the home page" do
    get "/"
    expect(last_response).to be_ok
  end
end