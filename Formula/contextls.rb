class Contextls < Formula
  desc "List the context / memory / instruction files each AI coding tool loads for a folder"
  homepage "https://github.com/danielwanja/contextls"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.2.0/contextls-aarch64-apple-darwin.tar.xz"
      sha256 "de621a30701bd973f7fbe7b0071078fbb1e9102c0d0625976cd00ffc84836a46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.2.0/contextls-x86_64-apple-darwin.tar.xz"
      sha256 "000b18e8ed56861bbe04b9398285a593d95eefb6d450b456a71337f672a15234"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.2.0/contextls-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04d1426c71fa672fd4093645f8fca81cfb827df2022d1327ba54f2d409da39c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.2.0/contextls-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "caa73a4e7a72cd0ca7ca80821420c5496bd8b0b15ac475a52848f3494f3e90d9"
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
