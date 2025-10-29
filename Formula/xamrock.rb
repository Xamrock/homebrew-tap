class Xamrock < Formula
  desc "AI-powered mobile app testing from your terminal"
  homepage "https://github.com/Xamrock/CLI"
  url "https://github.com/Xamrock/CLI/archive/refs/tags/0.2.0.tar.gz"
  sha256 "a2b7fcd25ad7f2cc7fe2d7fd62092e43053de8f1a2d39c7590f74cccd1b2e400"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/XamrockCLI" => "xamrock"
  end

  def post_install
    # Ensure the binary is properly linked
    system "brew", "link", "--overwrite", "xamrock" unless (HOMEBREW_PREFIX/"bin/xamrock").exist?
  end

  def caveats
    <<~EOS
      If the 'xamrock' command is not found after installation, run:
        brew link xamrock

      This tool requires Xcode Command Line Tools. If you encounter build errors,
      ensure your Command Line Tools are up to date:
        xcode-select --install

      Or update them from Software Update in System Settings.
    EOS
  end

  test do
    assert_match "USAGE: xamrock", shell_output("#{bin}/xamrock --help")
  end
end
