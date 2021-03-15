require 'rails_helper'

module DjWeb
  RSpec.describe DelayedJob do
    describe 'scopes' do
      describe '#enqueued' do
        before do
          create_list(:delayed_job, 3)
        end

        it 'has 3 records' do
          expect(described_class.enqueued.count).to eq(3)
        end
      end

      describe '#pending' do
        before do
          create_list(:delayed_job, 3, attempts: 0, locked_at: nil)
        end

        it 'has 3 records' do
          expect(described_class.pending.count).to eq(3)
        end
      end

      describe '#working' do
        before do
          create_list(:delayed_job, 3, failed_at: nil, locked_at: Time.now)
        end

        it 'has 3 records' do
          expect(described_class.working.count).to eq(3)
        end
      end

      describe '#failed' do
        before do
          create_list(:delayed_job, 3, last_error: 'something')
        end

        it 'has 3 records' do
          expect(described_class.failed.count).to eq(3)
        end
      end
    end
  end
end
