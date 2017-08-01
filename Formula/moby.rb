require "language/go"

class Moby < Formula
  desc "Container assembly tool"
  homepage "https://github.com/moby/tool"
  head "https://github.com/moby/tool.git", :revision => "36217e5145f1e54807490c09cc389f5e3ac99075"

  depends_on "go" => :build

  def install
    mkdir_p buildpath/"src/github.com/moby"
    ln_s buildpath, buildpath/"src/github.com/moby/tool"

    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"

    system "make"

    bin.install "moby"
  end

  test do
    output = shell_output(bin/"moby version")
    assert_match "moby version", output
  end
end
