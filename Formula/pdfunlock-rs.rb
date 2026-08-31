class PdfunlockRs < Formula
  desc "Cli to unlock pdf"
  homepage "https://github.com/devharshthakur/pdfunlock-rs"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/devharshthakur/pdfunlock-rs/releases/download/v0.0.1/pdfunlock-rs-aarch64-apple-darwin.tar.xz"
      sha256 "90556815888bdc119f08fc4b898654d80fcd0e28c71f84b5e67ffbf65a267361"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devharshthakur/pdfunlock-rs/releases/download/v0.0.1/pdfunlock-rs-x86_64-apple-darwin.tar.xz"
      sha256 "3fd7f270cb082a9b95b6a05df59c3dc31b50e0066aaf76db563355fd02a0ef51"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/devharshthakur/pdfunlock-rs/releases/download/v0.0.1/pdfunlock-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "da035ddaae72e7c578f4912fe76cf76e5f76125bc1cc0c01ed23a5c98f674f2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/devharshthakur/pdfunlock-rs/releases/download/v0.0.1/pdfunlock-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "74f8867d550c610372046a4c98a9955e7396818bbbdb3c2120d099c9c8c2d799"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "pdfunlock-rs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pdfunlock-rs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pdfunlock-rs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pdfunlock-rs"
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
