
require "base64"
require 'dotenv'
require 'pry-byebug'
Dotenv.load
$mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']



class Tasks::Emailer

def initialize(params)    
    begin

        @email = params[:email]
        @name = params[:name]
        @sender_email = params[:sender_email]
        @sender_name= params[:sender_name]
        @subject = params[:subject]
        @template_name = params[:template_name]
        @file_path = params[:file_path]
    rescue Exception => e
      p ("An error occurred #{e.backtrace} - #{e.class} -- #{e.message}")
    end
end

def sender_email
  @sender_email.nil? ? "mentor@embibe.com" : @sender_email
end 

def sender_name 
  @sender_name.nil? ? "Embibe Mentor" : @sender_name
end 

def to 
  [{"email"=>@email,
  "name"=>@name,
  "type"=>"to"}] 
end 
def file_name
  @file_path.nil? ? @file_path : (File.basename @file_path, ".*")
end

def base_name
  @file_path.nil? ? @file_path : (File.extname  @file_path).split('.').last
end 

def content
  @file_path.nil? ? @file_path : (Base64.encode64(File.read(@file_path)))
end 

def attachment
  [{"name"=>file_name,
  "content"=>content,
  "type"=>base_name}]
end

def message_data
        {
         "subject"=>@subject,
         "from_email"=>sender_email,
         "from_name"=>sender_name,
         "to"=>to,
         "attachments"=> attachment,
         "headers"=>{"Reply-To"=>sender_email},
         "important"=>true,
         "track_opens"=>true,
         "track_clicks"=>true,
         "auto_text"=>nil,
         "auto_html"=>nil,
         "inline_css"=>nil,
         "url_strip_qs"=>nil,
         "preserve_recipients"=>nil,
         "view_content_link"=>nil,
         "tracking_domain"=>nil,
         "signing_domain"=>nil,
         "return_path_domain"=>nil,
         "merge"=>true,
         "merge_language"=>"mailchimp",
         "tags"=>'',#[data["tags"]],
         "send_at"=> ''#data['send_time']
      }
end

def api_key
  $mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']  
end

def template_content
  [{"name"=>"","content"=>""}]
end

def async 
  false 
end 

def ip_pool 
  "Main Pool"
end

def send
  begin
    
    result = @template_name.nil? ? ($mandrill.messages.send  message_data, async, ip_pool) : ($mandrill.messages.send_template @template_name, template_content, message_data_template, async, ip_pool)
    rescue Exception => e
      p ("An error occurred #{e.backtrace} - #{e.class} -- #{e.message}")
      false
    end

end

end
