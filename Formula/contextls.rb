class Contextls < Formula
  desc "List the context / memory / instruction files each AI coding tool loads for a folder"
  homepage "https://github.com/danielwanja/contextls"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.3.0/contextls-aarch64-apple-darwin.tar.xz"
      sha256 "013d585feb41953c1fb7c7ffa776a554511168205c0624b75f9661a806f60738"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.3.0/contextls-x86_64-apple-darwin.tar.xz"
      sha256 "df5bb7e5b626cdf39cdb0d1e2817a14ace602b3135bb211c16aa01cd25541be7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.3.0/contextls-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d2cabb4330f3ab345ef0c066314c6fb43fe6b00a8368735a94e85958afe2c945"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.3.0/contextls-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa577250f1fa35fe182a303957bd46c846ecd98a45e80ae1728064de2667b870"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "contextls"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "contextls"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "contextls"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "contextls"
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
