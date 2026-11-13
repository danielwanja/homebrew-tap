class Gitsanity < Formula
  desc "Git history analytics for the terminal"
  homepage "https://github.com/danielwanja/gitsanity"
  version "2.0.0-alpha.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.1/gitsanity-aarch64-apple-darwin.tar.xz"
      sha256 "c14cd7c903e7b026e8d0aa3cc44f5a9971fe580fa70a7fbc4ccd737eddf97437"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.1/gitsanity-x86_64-apple-darwin.tar.xz"
      sha256 "07b7f6a3a36c5682c414d1817a9c869a6d741368f456f5758c0331ea1c64b21b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.1/gitsanity-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "77a0dbffe1069172104f0219d4f280939797b5234cbf14bca0b3e017ace02075"
    end
    if Hardware::CPU.intel?
      url "https://github.com/danielwanja/gitsanity/releases/download/v2.0.0-alpha.1/gitsanity-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "860c954a4b1dff76f8b9042ffcabac1696e3494e7474a9b5c8c1491c96ae5f82"
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
