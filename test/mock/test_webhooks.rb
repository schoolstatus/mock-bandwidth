# frozen_string_literal: true

require "test_helper"

class Mock::TestBandwidth < Minitest::Test
  def setup
    time = Time.local(2025, 1, 28, 12, 0, 0)
    Timecop.freeze(time)
  end

  def test_mock_webhook_message_trigger
    request_env =  {"_json"=>
                    [{"time"=>"Tue, 28 Jan 2025 12:00:00 -0600",
                      "type"=>"message-delivered",
                      "to"=>"+17001234123",
                      "description"=>"Message delivered to carrier.",
                      "message"=>
                    {"id"=>"id123",
                     "owner"=>"+18001234123",
                     "applicationId"=>"12341234",
                     "time"=>"Tue, 28 Jan 2025 12:00:00 -0600",
                     "segmentCount"=>1,
                     "direction"=>"out",
                     "to"=>["+17001234123"],
                     "from"=>"+18001234123",
                     "text"=>"sms text",
                     "tag"=>""}}]}

    stub_request(:post, "http://my-server.com/webhooks/bandwidth/messages_updates").
      with(body: request_env.to_json).
      to_return(status: 200, body: "", headers: {})

    payload = { "from"=>"+18001234123",
             "to"=>"+17001234123",
             "applicationId"=>"12341234",
             "text"=>"sms text",
             "owner"=>"+18001234123",
             "id"=>"id123",
    }

    response = Mock::Bandwidth::Webhooks::Messages.trigger("id123", payload)

    assert_equal 200, response.code
    assert_equal request_env, JSON.parse(response.request.options[:body])
  end

  def test_mock_webhook_message_trigger_error
    service_response = {"error"=>{"code"=>50001, "message"=>"There was an error related with the Bandwidth API"}}
    request_env =  {"_json"=>
                    [{"time"=>"Tue, 28 Jan 2025 12:00:00 -0600",
                      "type"=>"message-delivered",
                      "to"=>"+17001234123",
                      "description"=>"Message delivered to carrier.",
                      "message"=>
                    {"id"=>"id123",
                     "owner"=>"+18001234123",
                     "applicationId"=>"12341234",
                     "time"=>"Tue, 28 Jan 2025 12:00:00 -0600",
                     "segmentCount"=>1,
                     "direction"=>"out",
                     "to"=>["+17001234123"],
                     "from"=>"+18001234123",
                     "text"=>"sms text",
                     "tag"=>""}}]}

    stub_request(:post, "http://my-server.com/webhooks/bandwidth/messages_updates").
      with(body: request_env.to_json).
      to_return(status: 500, body: service_response.to_json, headers: { "Content-Type" => "application/json"} )

    payload = { "from"=>"+18001234123",
             "to"=>"+17001234123",
             "applicationId"=>"12341234",
             "text"=>"sms text",
             "owner"=>"+18001234123",
             "id"=>"id123",
    }


    assert_raises(Mock::Bandwidth::Webhooks::RestError) { Mock::Bandwidth::Webhooks::Messages.trigger("id123", payload) }
  end
end
