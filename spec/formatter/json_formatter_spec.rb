$:.unshift File.dirname(__FILE__)
require "spec_helper"
require 'time'
require 'yajl'

describe Mixlib::Log::JSONFormatter do
  before(:each) do
    @formatter = Mixlib::Log::JSONFormatter.new
    Mixlib::Log::JSONFormatter.show_time = false
  end

  it "should create a proper json log" do
    time = Time.new
    teststr = "{\"s\":\"monkey\",\"m\":\"mos def\"}\n"
    @formatter.call("monkey", time, "test", "mos def").should == teststr
  end

  it "should create a proper json log with time" do
    Mixlib::Log::JSONFormatter.show_time = true
    time = Time.new
    iso8601 = time.iso8601()
    teststr = "{\"s\":\"monkey\",\"time\":\"#{iso8601}\",\"m\":\"mos def\"}\n"
    @formatter.call("monkey", time, "test", "mos def").should == teststr
  end

  it "should be able to log objects" do
    time = Time.new
    teststr = "{\"s\":\"error\",\"m\":\"cool\",\"e\":123,\"error\":\"darn\"}\n"
    @formatter.call('error', time, 'test',
      { m: 'cool', e: 123, error: 'darn' }).should == teststr
  end
end
