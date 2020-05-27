RSpec.describe GithubService::Fetcher do
  subject { described_class.new(api_action) }
  let(:request_options) { GithubService::RequestOptions.new(path: 'any/path') }
  let(:api_action) { instance_double(GithubService::ApiAction, request_options: request_options) }
  let(:timed_out) { false }
  let(:response_code) { 200 }
  let(:response_body) { '{"items": []}' }
  let(:response_double) do
    instance_double(Typhoeus::Response, body: response_body, code: response_code, timed_out?: timed_out)
  end
  let(:request_double) do
    instance_double(Typhoeus::Request,
                    run: nil,
                    response: response_double,
                    )
  end

  before do
    allow(subject).to receive(:request).and_return(request_double).times
  end


  it 'parses response JSON' do
    expect(subject.run!).to eq([])
  end

  context 'response code is invalid' do
    [0, 400].each do |response_code|
      let(:response_code) { response_code }
      it { expect { subject.run! }.to raise_error(RuntimeError, "Request failed to be processed") }
    end
  end

  context 'response body is invalid' do
    let(:response_body) { 'something invalid' }
    it { expect { subject.run! }.to raise_error(RuntimeError, "Unprocessable data received from Github") }
  end

  context 'response does not contain items key' do
    let(:response_body) { '{"ok": true}' }
    it { expect { subject.run! }.to raise_error(RuntimeError, "Unprocessable data received from Github") }
  end

  context 'request timed out' do
    let(:timed_out) { true }
    it { expect { subject.run! }.to raise_error(RuntimeError, "Request timed out") }
  end
end