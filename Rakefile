require 'rake/clean'
require 'rake/testtask'
require 'fileutils'

task :default => [:spec]

# SPECS ===============================================================
task :spec do |t|
  sh "spec specs"
end

# PACKAGING ============================================================

# Load the gemspec using the same limitations as github
def spec
  @spec ||=
    begin
      require 'rubygems/specification'
      data = File.read('sinbasp.gemspec')
      spec = nil
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
      spec
    end
end

def package(ext='')
  "dist/sinbasp-#{spec.version}" + ext
end

desc 'Build packages'
task :package => %w[.gem .tar.gz].map {|e| package(e)}

desc 'Build and install as local gem'
task :install => package('.gem') do
  sh "gem install #{package('.gem')}"
end

directory 'dist/'
CLOBBER.include('dist')

file package('.gem') => %w[dist/ sinbasp.gemspec] + spec.files do |f|
  sh "gem build sinbasp.gemspec"
  mv File.basename(f.name), f.name
end

file package('.tar.gz') => %w[dist/] + spec.files do |f|
  sh <<-SH
    git archive \
      --prefix=sinbasp-#{source_version}/ \
      --format=tar \
      HEAD | gzip > #{f.name}
  SH
end

# Gemspec Helpers ====================================================

def source_version
  line = File.read('VERSION').chomp
end

project_files =
  FileList[
    '{lib,public,specs,views}/**',
    'Rakefile', 'CHANGES', 'README.rdoc', 'VERSION', 'sinbasp.rb'
  ]
file 'sinbasp.gemspec' => project_files do |f|
  # read spec file and split out manifest section
  spec = File.read(f.name)
  head, manifest, tail = spec.split("  # = MANIFEST =\n")
  # replace version and date
  head.sub!(/\.version = '.*'/, ".version = '#{source_version}'")
  head.sub!(/\.date = '.*'/, ".date = '#{Date.today.to_s}'")
  # determine file list from git ls-files
  files = `git ls-files`.
    split("\n").
    sort.
    reject{ |file| file =~ /^\./ }.
    reject { |file| file =~ /^doc/ }.
    map{ |file| "    #{file}" }.
    join("\n")
  # piece file back together and write...
  manifest = "  s.files = %w[\n#{files}\n  ]\n"
  spec = [head,manifest,tail].join("  # = MANIFEST =\n")
  File.open(f.name, 'w') { |io| io.write(spec) }
  puts "updated #{f.name}"
end
