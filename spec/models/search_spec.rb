# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'Validations' do
    context 'when engine is not present' do
      let(:search) { Search.new }

      it "returns search as invalid" do
        expect(search.valid?).to be_falsey
      end
    end

    context 'when engine is present' do
      context 'and engine is valid' do
        let(:search) { Search.new }

        before do
          search.engine = 'google'
        end

        it "returns search as valid" do
          expect(search.valid?).to be_truthy
        end
      end

      context 'and engine is not valid' do
        let(:search) { Search.new }

        before do
          search.engine = 'unknown'
        end

        it "returns search as invalid" do
          expect(search.valid?).to be_falsey
        end
      end
    end
  end
end
