require "spec_helper"

describe "dokku::plugins" do
  it "installs the plugin to the default directory" do
    expect(file("/var/lib/dokku/plugins/available/redis")).to be_directory
  end
end
