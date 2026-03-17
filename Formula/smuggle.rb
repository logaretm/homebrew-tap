class Smuggle < Formula
  desc "Smuggle local npm packages into your projects — no symlinks, no lockfile pollution"
  homepage "https://github.com/logaretm/smuggle"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/logaretm/smuggle/releases/download/v#{version}/smuggle-aarch64-apple-darwin.tar.gz"
      # sha256 "PLACEHOLDER"
    else
      url "https://github.com/logaretm/smuggle/releases/download/v#{version}/smuggle-x86_64-apple-darwin.tar.gz"
      # sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/logaretm/smuggle/releases/download/v#{version}/smuggle-aarch64-unknown-linux-gnu.tar.gz"
      # sha256 "PLACEHOLDER"
    else
      url "https://github.com/logaretm/smuggle/releases/download/v#{version}/smuggle-x86_64-unknown-linux-gnu.tar.gz"
      # sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "smuggle"
  end

  test do
    assert_match "smuggle", shell_output("#{bin}/smuggle --help")
  end
end
