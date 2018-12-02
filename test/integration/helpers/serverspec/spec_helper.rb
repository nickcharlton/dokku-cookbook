require "serverspec"

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: "windows"
end

file = "/tmp/SKIP_DOCKER_INSTALL_SPEC"
ENV["SKIP_DOCKER_INSTALL_SPEC"] =
  File.exists?(file) ? File.read(file).strip : "false"
