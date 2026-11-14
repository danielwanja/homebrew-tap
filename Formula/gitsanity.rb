class Gitsanity < Formula
  desc "Git history analytics for the terminal"
  homepage "https://github.com/danielwanja/gitsanity"
  version "2.0.0-alpha.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.2/gitsanity-aarch64-apple-darwin.tar.xz"
      sha256 "ec1250c570eeab08a831bcef73b848743da81cf93def841bbd54f07b372268c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.2/gitsanity-x86_64-apple-darwin.tar.xz"
      sha256 "485a39866e5f5c77f62c98062131556fe0ba727f5e988c4d56bfac4c6e6e8dc4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.2/gitsanity-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "227a5a18edc4e386ed5006c370a7d80eec5d408eb40a4b7d85aee88fb69e67b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.2/gitsanity-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "da26c6d8d8160575643fbdd66b61cc68ef3090c1d77be8ef7230ebda74a5fb6b"
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
      bin.install "gitsanity"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "gitsanity"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "gitsanity"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "gitsanity"
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
