# Mock::Bandwidth
[![Gem Version](https://badge.fury.io/rb/mock-bandwidth.svg)](https://badge.fury.io/rb/mock-twilio)
![mock-bandwidth](https://github.com/schoolstatus/mock-twilio/actions/workflows/ruby.yml/badge.svg)

This is a SchoolStatus implementation to mock Bandwidth-sdk to perform requests to [bandwidth-oai](https://docs.stoplight.io/docs/prism/83dbbd75532cf-http-mocking)


# Installation

To install using bundler grab the latest stable version:

```ruby
gem install mock-bandwidth
```

## Requirements
- [Bandwidth-oai](https://docs.stoplight.io/docs/prism/83dbbd75532cf-http-mocking)
- [Bandwidth-sdk](https://github.com/Bandwidth/ruby-sdk)

## Defaults Prism

- `proxy_address = bandwidth_mock_server`
- `proxy_port = 4010`
- `proxy_protocol = http`

## Features Support

| Support | Mock::Bandwidth   |
| ------------- | ------------- |
| :white_check_mark: | `Bandwidth::MessagesApi.new.create_message(account_id, body)`  |


## How to use
Initializer sample

```ruby
Bandwidth.configure do |config| # Configure Basic Auth
  config.username = "username"
  config.password = "password"
  config.configure_faraday_connection do |connection|
    connection.proxy = "http://mock-server.test"
    connection.use Mock::Bandwidth::Middleware::Proxy
  end
end
```

Example
```ruby
from = "+18001234123123"
application_id = "12341234"
account_id = "123123"
text = "sms text"
to = "+17001234123123"

body = Bandwidth::MessageRequest.new(
  {
    from: from,
    application_id: application_id,
    to: [to],
    text: text
  }
)
messaging_api_instance = Bandwidth::MessagesApi.new
response = messaging_api_instance.create_message(account_id, body)

=> #<Bandwidth::Message:0x00005f39e4efcae0 @application_id="12341234", @from="+18001234123123", @id="1737987840867jqaf7b3rad1a6fn", @owner="+18001234123123", @text="sms text", @to=["+17001234123123"]>
```

## Run tests
```unix
rake test
```
