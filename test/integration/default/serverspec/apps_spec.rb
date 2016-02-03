require "spec_helper"

describe "dokku::apps" do
  it "creates the app directory" do
    expect(file("/home/dokku/demo-app")).to be_directory
  end

  it "renames an app" do
    pending "it's impossible to rename an app without first deploying it."

    expect(file("/home/dokku/app-for-renaming")).not_to be_directory
    expect(file("/home/dokku/renamed-app")).to be_directory
  end
end
