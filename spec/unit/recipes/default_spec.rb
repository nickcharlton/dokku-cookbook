#
# Cookbook Name:: dokku
# Spec:: default
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::default" do
  context "when all attributes are default, on an unspecified platform" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_command("which nginx").and_return("/usr/bin/nginx")
    end

    it "includes the install recipe" do
      expect(chef_run).to include_recipe "dokku::install"
    end
  end
end
