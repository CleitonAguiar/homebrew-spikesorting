require 'formula'

class Klusters < Formula
  homepage 'http://klusters.sourceforge.net/'
  head 'http://git.code.sf.net/p/klusters/klusters', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'libklustersshared'

  option 'with-debug', 'Build with debug symbols'

  env :std

  def install
    if build.with? 'debug'
      # Debug symbols need to find the source so build in the prefix
      cp_r "#{pwd}", "#{prefix}/src"
      cd "#{prefix}/src"

      # Set build type to release with debug symbols
      ENV.append "CXXFLAGS", "-g -O2"
    end

    system "cmake", ".", *std_cmake_args 
    system "make install"
  end
end
