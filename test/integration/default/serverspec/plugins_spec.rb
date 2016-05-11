require "spec_helper"

describe "dokku::plugins" do
  let(:redis_path) { "/var/lib/dokku/plugins/available/redis" }

  it "installs the plugin to the default directory" do
    expect(file(redis_path)).to be_directory
  end

  it "installs the plugin at a specific commit" do
    cmd = command("GIT_DIR=#{redis_path}/.git git rev-parse HEAD")

    expect(cmd.stdout).to match(/659cd084/)
  end
end
