require "fileutils"
require "erb"

module Password
  # class to handle different endpoints
  class Endpoint
    attr_reader :name, :path, :template, :orig

    def initialize(params)
      @policy   = params[:policy]
      @name     = params[:name]
      @path     = params[:path]
      @template = build_template_path
      @orig = build_orig_path
    end

    def dispatch
      # dont backup the file if backup already exists
      # TODO lock file before operation
      FileUtils.cp @path, @orig unless File.exist? @orig
      # atomic write
      File.open(@path, File::RDWR | File::CREAT, 0o644) do |f|
        f.flock(File::LOCK_EX)
        f.write(ERB.new(File.read(@template)).result(binding))
      end
    end

    def revert
      # TODO: lock file before operation
      FileUtils.mv @orig, @path if File.exist? @orig
    end

    protected

    def build_template_path
      fname = File.basename(@path)
      File.expand_path File.join(File.dirname(__FILE__), "..", "..", "..", "templates", "#{fname}.erb")
    end

    def build_orig_path
      @path + ".orig"
    end
  end
end
