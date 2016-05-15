require "spec_helper"

describe "dokku::certificates" do
  context "app certificate" do
    it "creates the certificate directory" do
      expect(file("/home/dokku/demo-app/tls")).to be_directory
    end

    it "writes the certificate" do
      expect(file("/home/dokku/demo-app/tls/server.crt")).to contain(
        "0+f6to+n6VWI6TGBJBqlqMoXDeRdGVf8hiZoxyqr+7HvSpYM2bNm6VezO06QX/hu")
    end

    it "writes the private key" do
      expect(file("/home/dokku/demo-app/tls/server.key")).to contain(
        "h1rErLBh3XKKRHr5MwrSQmGGhs7e0od+j1GPVpnSIb2zMAGSBJ8=")
    end
  end
end
