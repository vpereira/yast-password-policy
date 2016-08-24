require_relative "test_helper"

include Password

describe Endpoint do
  before do
    @my_policy = {
      difok:   8,
      minlen:  15,
      dcredit: 1
    }
    @my_endpoint = {
      pwd: "/tmp/foo.conf"
    }
  end

  it "should not be explode" do
    proc { Endpoint.new(policy: @my_policy, name: :pwd, path: "/tmp/foo.conf") }.must_be_silent
  end

  it "should not be nil" do
    Endpoint.new(policy: @my_policy, name: :pwd, path: "/tmp/foo.conf").wont_be_nil
  end

  describe "attributes" do
    before do
      @e = Endpoint.new(policy: @my_policy, name: :pwd, path: "/tmp/foo.conf")
    end
    it "should have a path" do
      @e.must_respond_to :path
      @e.path.wont_be_nil
      @e.path.must_be :==, "/tmp/foo.conf"
    end

    it "should have a orig" do
      @e.must_respond_to :orig
      @e.orig.wont_be_nil
      @e.orig.must_be :==, "/tmp/foo.conf.orig"
    end

    it "should have a template" do
      @e.must_respond_to :template
      @e.template.wont_be_nil
      @e.template.must_be :==, File.expand_path(File.join(File.dirname(__FILE__), "..", "templates", "foo.conf.erb"))
    end
  end
end
