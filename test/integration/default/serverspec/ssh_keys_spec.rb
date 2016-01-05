require "spec_helper"

describe "dokku::ssh_keys" do
  it "puts the ssh key into authorized_keys" do
    authorized_keys = file("/home/dokku/.ssh/authorized_keys")

    expect(authorized_keys).to contain("public_key")
  end
end
