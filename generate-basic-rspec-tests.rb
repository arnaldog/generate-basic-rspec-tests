require 'fileutils'

class RspecFiles
  attr_accessor :path
  attr_accessor :list, :already_created_list, :to_create_list

  def initialize(options = {})
    raise ArgumentError unless options.keys.include?(:path)
    @path = options[:path]

    @list, @already_created_list, @to_create_list = [], [], []
    initialize_list
    initialize_already_created_list
    initialize_to_create_list
  end

  def initialize_list
    Dir.entries(path).each{ |item| @list << item if item =~ /[A-Za-z0-9]*.rb/ }
  end

  def initialize_already_created_list
    @list.each { |input| @already_created_list << input if File.file?("spec/models/#{input.split(".")[0]}_spec.rb") }
  end

  def initialize_to_create_list
    @to_create_list = @list - @already_created_list
  end

  def create_non_created_files
    @to_create_list.each{|file| FileUtils.touch("spec/models/#{file.split('.'[0])}_spec.rb") }
  end
end

class Main
  def self.run
    @rspec_files = RspecFiles.new(path: ARGV[0])
    @rspec_files.create_non_created_files
  end

  raise ArgumentError unless ARGV.length == 1
  run
end

