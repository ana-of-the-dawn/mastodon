# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join('app', 'lib', 'sanitize_config.rb')

describe Sanitize::Config do
  describe '::MASTODON_STRICT' do
    subject { Sanitize::Config::MASTODON_STRICT }

    it 'keeps h1' do
      expect(Sanitize.fragment('<h1>Foo</h1>', subject)).to eq '<h1>Foo</h1>'
    end

    it 'keeps ul' do
      expect(Sanitize.fragment('<p>Check out:</p><ul><li>Foo</li><li>Bar</li></ul>', subject)).to eq '<p>Check out:</p><ul><li>Foo</li><li>Bar</li></ul>'
    end

    it 'keep links in lists' do
      expect(Sanitize.fragment('<p>Check out:</p><ul><li><a href="https://joinmastodon.org" rel="nofollow noopener" target="_blank">joinmastodon.org</a></li><li>Bar</li></ul>', subject)).to eq '<p>Check out:</p><p><a href="https://joinmastodon.org" rel="nofollow noopener" target="_blank">joinmastodon.org</a><br>Bar</p>'
    end
  end
end
