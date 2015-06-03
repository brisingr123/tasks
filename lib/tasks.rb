require 'mandrill'
require 'dotenv'
require "base64"
require "pg"
require "tasks/version"
require "tasks/emailer"
require "tasks/query"
Dotenv.load


class Tasks

  def initialize params
    @params=params
  end  

  def self.email params
    Tasks::Emailer.new(params).send
  end

  def self.query params
    Tasks::Query.new(params).run
  end

end
