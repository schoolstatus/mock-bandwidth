# frozen_string_literal: true

require "test_helper"

class Mock::TestBandwidth < Minitest::Test
  def test_mock_client_message_sms
    mock_server_response = { "from"=>"string",
                             "to"=>"string",
                             "applicationId"=>"string",
                             "text"=>"string",
                             "owner"=>"string",
                             "id"=>"string",
                            }

    stub_request(:post, "http://mock-server.test/api/v2/users/123123/messages").
      with(body: "{\"applicationId\":\"12341234\",\"to\":[\"+17001234123123\"],\"from\":\"+18001234123123\",\"text\":\"sms text\"}").
      to_return(status: 200, body: mock_server_response.to_json, headers: {})

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

    assert "12341234", response.application_id
    assert from, response.from
    assert from, response.owner
    assert to, response.to
    assert text, response.text
    assert_match(/^\d{13}[a-z0-9]+$/, response.id)
  end
end

