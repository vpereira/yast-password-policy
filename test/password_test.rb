require_relative "test_helper"
require "fileutils"

describe Password::Password do
  before do
    FileUtils.rm_f(YAML_CONFIG)
    @my_policy = {
      difok:   8,
      minlen:  15,
      dcredit: 1,
      ucredit: -2,
      lcredit: -1
    }
    @p = Password::Password.new(policy: @my_policy)
  end

  it "Password::current_policy returns DEFAULT_POLICY" do
    Password::Password.current_policy.must_be :==, DEFAULT_POLICY
  end

  it "should not be nil" do
    @p.wont_be_nil
  end

  describe "default endpoints" do
    it "should not be nil" do
      @p.endpoints.wont_be_nil
    end
    it "should have 2 endpoints" do
      @p.endpoints.size.must_be :==, 3
    end
  end

  describe "with custom endpoint" do
    before do
      @pp = Password::Password.new(
        policy: @my_policy, endpoints: { foo: "/bar" }
      )
    end

    it "should have the custom endpoint" do
      @pp.endpoints[0].wont_be_nil
      @pp.endpoints[0].name.must_be :==, :foo
    end
  end
  describe "with saved policy" do
    before do
      @my_policy = {
        difok:   13,
        minlen:  15,
        dcredit: 1,
        ucredit: -2,
        lcredit: -1
      }
      Password::Password.new(policy: @my_policy).save_policy
      @p = Password::Password.current_policy
    end
    it "should use values from saved policy" do
      @p[:difok].must_be :==, 13
    end
  end
end
