# Silent Heritage, built from source: both versions of the game, the classic
# one (silent_heritage) and the extended one (silent_heritage_extended). Built
# on the player's Mac, the programs need no notarization.
class SilentHeritage < Formula
  desc "Open-source engine for Silent Hunter (1995), played with its original files"
  homepage "https://github.com/conning-tower/SilentHeritage"
  license "MIT"
  head "https://github.com/conning-tower/SilentHeritage.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on :macos

  on_macos do
    depends_on macos: :ventura
  end

  # SDL at the commit the project's CMakeLists.txt pins, checked out by
  # Homebrew: the build itself downloads nothing.
  resource "sdl3" do
    url "https://github.com/libsdl-org/SDL.git",
        revision: "829a65d769d935c4852f8159e964312c0957260a"
  end

  def install
    resource("sdl3").stage(buildpath/"sdl3")
    { "classic" => "silent_heritage", "extended" => "silent_heritage_extended" }.each do |variant, executable|
      system "cmake", "-S", ".", "-B", "build-#{variant}", "-G", "Ninja",
             "-DSH_VARIANT=#{variant}", "-DSH_BUILD_TESTS=OFF", "-DSH_SANITIZE=OFF",
             "-DFETCHCONTENT_SOURCE_DIR_SDL3=#{buildpath}/sdl3", "-DFETCHCONTENT_FULLY_DISCONNECTED=ON",
             *std_cmake_args
      system "cmake", "--build", "build-#{variant}", "--target", executable
      bin.install "build-#{variant}/src/app/#{executable}"
    end
  end

  def caveats
    <<~EOS
      Silent Heritage plays your own copy of Silent Hunter: on the first start,
      it asks for the folder of your install (the one holding SH.EXE and DATA).
      Start the classic version with `silent_heritage`, the extended one with
      `silent_heritage_extended`. Saves go to
      ~/Library/Application Support/Conning Tower/.
    EOS
  end

  test do
    assert_predicate bin/"silent_heritage", :executable?
    assert_predicate bin/"silent_heritage_extended", :executable?
  end
end
