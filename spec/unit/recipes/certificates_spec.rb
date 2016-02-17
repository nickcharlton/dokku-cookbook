#
# Cookbook Name:: dokku
# Spec:: certificates
#
# Copyright (c) 2015 Nick Charlton, MIT licensed.

require "spec_helper"

describe "dokku::certificates" do
  context "when all attributes are default" do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it "can load a certificate from a data bag" do
      stub_data_bag("dokku_certificates").and_return(["demo_app"])
      stub_data_bag_item("dokku_certificates", "demo_app").and_return(
        "id" => "demo-app", "cert" => "CERT", "key" => "KEY")

      expect(chef_run).to add_dokku_certificate("demo-app").with(
        cert: "CERT", key: "KEY")
    end

    it "can load a global certificate from a data bag" do
      stub_data_bag("dokku_certificates").and_return(["wildcard"])
      stub_data_bag_item("dokku_certificates", "wildcard").and_return(
        "id" => "wildcard", "global" => true, "cert" => "CERT", "key" => "KEY")

      expect(chef_run).to add_dokku_certificate("wildcard").with(
        global: true, cert: "CERT", key: "KEY")
    end
  end
end
