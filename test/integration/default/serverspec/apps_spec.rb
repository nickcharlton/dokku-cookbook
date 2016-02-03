require "spec_helper"

describe "dokku::apps" do
  it "creates the app directory" do
    expect(file("/home/dokku/demo-app")).to be_directory
  end
end
