# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repos::SearchService do
  let(:body) { subject.body }

  subject { described_class.call(params) }

  context 'when no params hash provided' do
    let(:params) { {} }

    it { is_expected.not_to be_success }
    it { expect(body).to eq('Search string should be present') }
  end

  context 'when no search string provided' do
    let(:params) { { q: '' } }

    it { is_expected.not_to be_success }
    it { expect(body).to eq('Search string should be present') }
  end

  context 'when search string provided' do
    let(:params) { { q: 'ruby' } }

    it { is_expected.to be_success }
    it { expect(body).to eq([{ description: 'The Ruby Programming Language [mirror]', html_url: 'https://github.com/ruby/ruby' }]) }
  end

  context 'when pagination params are provided' do
    let(:params) { { q: 'ruby', page: '1', per_page: '3' } }

    it do
      expect(body).to eq([
                           { description: 'The Ruby Programming Language [mirror]', html_url: 'https://github.com/ruby/ruby' },
                           { description: 'Ruby On Rails', html_url: 'https://github.com/rails/rails' }
                         ])
    end

    # TODO: add test for meta params: pagination and page number is too big
    # TODO: add test for too many request error
  end
end
