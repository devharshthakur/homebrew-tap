class Unlkpdf < Formula
  desc "Cli to unlock pdf"
  homepage "https://github.com/devharshthakur/unlkpdf"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/devharshthakur/unlkpdf/releases/download/v0.0.2/unlkpdf-aarch64-apple-darwin.tar.xz"
      sha256 "4036ef43cd4afeed658b9bebbe90ddcdb514d897729956c0662e9949cc3f428a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devharshthakur/unlkpdf/releases/download/v0.0.2/unlkpdf-x86_64-apple-darwin.tar.xz"
      sha256 "653ac42708cdb36ccecd3742e6bfee8ea9db19acf45c3af1a5eb0b5f7b28c4c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/devharshthakur/unlkpdf/releases/download/v0.0.2/unlkpdf-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6856735a4e241d5d5d696a696cfe3ecebbbdba8eafc87eb669c589b1e6820d5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devharshthakur/unlkpdf/releases/download/v0.0.2/unlkpdf-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "882eb11fb7a4a01cb758962c234dcb76c6d5d854af9953cae193cec94f4c0a47"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "unlkpdf"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "unlkpdf"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "unlkpdf"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "unlkpdf"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
