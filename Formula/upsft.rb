class Upsft < Formula
  desc "A simple CLI tool to update multiple dependencies"
  homepage "https://github.com/devharshthakur/upsft"
  version "1.1.2"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/devharshthakur/upsft/releases/download/v1.1.2/upsft-aarch64-apple-darwin.tar.xz"
    sha256 "950a82d8253ace4cea1247a3d70c054df6a1a5127a927e1224fc49492c8bdc76"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "upsft" if OS.mac? && Hardware::CPU.arm?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
