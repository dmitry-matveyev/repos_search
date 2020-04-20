# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Repos', type: :request do
  let(:service) { Repos::SearchService }

  describe '#index' do
    before do
      permit_params = ActionController::Parameters.new(params).permit!
      expect(service).to receive(:call).with(permit_params).and_return(result)
      get '/api/v1/repos', params: params
    end

    subject { response }

    context 'when no search string provided' do
      let(:params) { {} }
      let(:errors) { { q: 'should be present' } }
      let(:result) { failure_result(errors) }

      it { is_expected.to have_http_status(422) }
      it { expect(response.body).to eq(errors.to_json) }
    end

    context 'when search string provided' do
      let(:params) { { q: 'test' } }
      let(:items) { [{ description: 'test', html_url: 'https://example.net' }] }
      let(:result) { success_result(items) }

      it { is_expected.to have_http_status(200) }
      it { expect(response.body).to eq(items.to_json) }
    end

    # This checks if pagination params are not forgotten to be permitted in controller
    # TODO: use https://github.com/thoughtbot/shoulda-matchers/blob/v2.8.0/lib/shoulda/matchers/action_controller/strong_parameters_matcher.rb
    context 'when pagination params provided' do
      let(:params) { { q: 'test', page: '1', per_page: '10' } }
      let(:items) { [{}] }
      let(:result) { success_result(items) }

      it { is_expected.to have_http_status(200) }
    end
  end
end
