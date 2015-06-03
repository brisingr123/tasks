# Tasks

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tasks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tasks

## Usage

To use the query class: 
  params= { query: 'select * from attempts limit 1',file_name: 'hello.csv'}
  run Tasks.query params 

  file_name is an optional field. If you give file name, the data will be stored in a CSV

To use the Email Class: 
  params={
        email: = 'example',
        name: = 'example',
        sender_email: = 'example',
        sender_nam:e= 'example',
        subject: = 'example',
        template_name: = 'example',
        file_path: = 'example'}
  
  run Tasks.email params

  Template Name is to be given when you are sending a template
  File path is to be given if you are attaching a file
  if no sender name is given, a default email address is used. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tasks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
