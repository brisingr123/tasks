require "tasks/version"
require "tasks/emailer"
require "tasks/query"
require 'pry-byebug'

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
