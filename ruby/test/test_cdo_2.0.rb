$:.unshift File.join(File.dirname(__FILE__),"..","lib")
require 'cdo'

require 'minitest/autorun'


#===============================================================================
def rm(files); files.each {|f| FileUtils.rm(f) if File.exists?(f)};end


class TestCdo < Minitest::Test

  DEFAULT_CDO_PATH = 'cdo'

  @@show           = ENV.has_key?('SHOW')
  @@maintainermode = ENV.has_key?('MAINTAINERMODE')
  @@debug          = ENV.has_key?('DEBUG')

  def setup
    @cdo = Cdo.new
    @tempStore = CdoTempfileStore.new
  end

  def test_cdo
    assert_equal(true,@cdo.check)
    pp @cdo.config
    pp (@cdo.methods - Object.methods).sort
    assert(@cdo.respond_to?(:has_nc4), "Could not find netcdf4 output format")
    assert(@cdo.respond_to?(:has_nc5), "Could not find netcdf5 output format")
  end

  def test_chainternal
    obj = @cdo.methA('r10x2').divc(7).add.infiles('ifileA').mulc(0.1).infiles('ifileB')
    puts obj.cmd.join(' ')
  end
end
