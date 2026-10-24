class Contextls < Formula
  desc "List the context / memory / instruction files each AI coding tool loads for a folder"
  homepage "https://github.com/danielwanja/contextls"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.1.0/contextls-aarch64-apple-darwin.tar.xz"
      sha256 "5b7ac65bb5d48f90eb01f78cc87e19cddb952dff61f683a0530fd08b67f57831"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.1.0/contextls-x86_64-apple-darwin.tar.xz"
      sha256 "1200485504238061e2c9c7b7c5b59b450c9c79ff539bc8c282fd392d4451a714"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/contextls/releases/download/v0.1.0/contextls-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "608602b79375bec54481da86e453926a7f16fa4ce389fa6fa9721ec74c712c95"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/contextls/releases/download/v0.1.0/contextls-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd6c9a2982f27ab16493458b16e7060a9f8b819837bc7f9959d18c89b70db377"
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
