# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Repos', type: :request do
  before do
    get '/repos', params: params
  end

  describe '#index' do
    context 'when search for empty string' do
      let(:params) { {} }

      it { expect(response.body).to match(/should be present/) }
    end

    context 'when search sring is present' do
      let(:params) { { q: 'ruby' } }

      it { expect(response.body).to match(/The Ruby Programming Language/) }
    end

    describe 'pagination' do
      let(:params) { { q: 'ruby', page: '2' } }

      it { expect(response.body).to match(%r{<a rel="next" href=\"/\?page=3&amp;q=ruby\">3</a>}) }
      it { expect(response.body).to match(/2/) }
    end
  end
end
