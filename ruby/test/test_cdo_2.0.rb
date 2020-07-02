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
    @cdo.debug = true
    @tempStore = CdoTempfileStore.new
  end

  def test_cdo
    assert_equal(true,@cdo.check)
    pp @cdo.config
    pp (@cdo.methods - Object.methods).sort
    assert(@cdo.respond_to?(:has_nc4), "Could not find netcdf4 output format")
    assert(@cdo.respond_to?(:has_nc5), "Could not find netcdf5 output format")
  end

  def test_op
    pp @cdo.operators
  end
  def test_chainternal
    obj = @cdo.methA('r10x2').divc(7).add.infiles('ifileA').mulc(0.1).infiles('ifileB')
    puts obj.cmd
  end

  def test_runChain
    obj = @cdo.remapnn('r10x2').mulc(34.2).topo
    obj.run
  end

  def test_combineChains

    objA = Cdo.new.remapnn('r10x2').mulc(34.2).topo.dup
    objB = Cdo.new.remapnn('r10x2').mulc(34.2).topo.dup

    puts @cdo.add('a',objA,objB).cmd

  end
  def test_objectSeparation
    cdo = Cdo.new
    puts "ID = |#{cdo.objects_id}|"
    @cdo.mulc.objects_id
    @cdo.addc.objects_id

    puts @cdo.cmd
  end
end
