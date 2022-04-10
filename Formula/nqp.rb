class Nqp < Formula
  desc "Lightweight Perl 6-like environment for virtual machines"
  homepage "https://github.com/Raku/nqp"
  url "https://github.com/Raku/nqp/releases/download/2022.03/nqp-2022.03.tar.gz"
  sha256 "a95e778970c4d09c091d2aa299c05036208ce4b4b0d3a7af373198c12258b306"
  license "Artistic-2.0"

  bottle do
    sha256 arm64_monterey: "2fcf5411f84049b5ed9c33ea59b0670dab4a15e7f1fa9306b495d0e75eaffd7b"
    sha256 arm64_big_sur:  "85ca3d2703380e861c38b11cdb06491fcb9d6d6ff8f164df7bba50a57193509b"
    sha256 monterey:       "b41ab0d9aa8af807119c68f5410e7948c3805922163439bf2f41da7217521a7c"
    sha256 big_sur:        "bb3b483b2f847317a8eb56c841c50a3ab9d8378c037667d9937225029d5442d2"
    sha256 catalina:       "02f937da745f1560f4f8de56ef930e17af51cf11c31f9a2a36c68c94f804c97c"
    sha256 x86_64_linux:   "708d729ea4d0d0f85072ede576b26b70ae2575080466dfca001ba9173600e638"
  end

  depends_on "libtommath"
  depends_on "moarvm"

  conflicts_with "rakudo-star", because: "rakudo-star currently ships with nqp included"

  def install
    system "perl", "Configure.pl",
                   "--backends=moar",
                   "--prefix=#{prefix}",
                   "--with-moar=#{Formula["moarvm"].bin}/moar"
    system "make"
    system "make", "install"
  end

  test do
    out = shell_output("#{bin}/nqp -e 'for (0,1,2,3,4,5,6,7,8,9) { print($_) }'")
    assert_equal "0123456789", out
  end
end
