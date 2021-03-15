require 'rails_helper'

module DjWeb
  RSpec.describe JobsController, type: :controller do
    routes { DjWeb::Engine.routes }

    before { http_login }

    describe 'GET #enqueued' do
      before do
        create_list(:delayed_job, 3)
        
        get :enqueued
      end

      it 'renders :enqueued template' do
        expect(response).to render_template :enqueued
      end

      it 'has :ok http status' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'GET #pending' do
      before do
        create_list(:delayed_job, 3)

        get :pending
      end

      it 'renders :pending template' do
        expect(response).to render_template :pending
      end

      it 'has :ok http status' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'GET #working' do
      before do
        create_list(:delayed_job, 3, locked_at: Time.now)
        
        get :working
      end

      it 'renders :working template' do
        expect(response).to render_template :working
      end

      it 'has :ok http status' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'GET #failed' do
      before do
        create_list(:delayed_job, 3, last_error: 'Error something')

        get :failed
      end


      it 'renders :failed template' do
        expect(response).to render_template :failed
      end

      it 'has :ok http status' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'PATCH #retry' do
      context 'when record found' do
        let(:record) { create(:delayed_job) }
        
        before do
          patch :retry, params: { id: record.id }
        end

        it 'redirects to jobs#show' do
          expect(response).to redirect_to job_path(record)
        end
      end

      context 'when record not found' do
        before do
          patch :retry, params: { id: 0 }
        end

        it 'redirects to pages#index' do
          expect(response).to redirect_to pages_path
        end
      end
    end

    describe 'PATCH #reload' do
      let(:record) { create(:delayed_job) }

      before do
        patch :reload, params: { id: record.id }
      end

      it 'redirects to jobs#show' do
        expect(response).to redirect_to job_path(record)
      end
    end

    describe 'DELETE #destroy' do
      let(:record) { create(:delayed_job) }

      before do
        delete :destroy, params: { id: record.id }
      end

      it 'redirects to jobs#enqueued' do
        expect(response).to redirect_to enqueued_jobs_path
      end
    end

    describe 'GET #show' do
      let(:record) { create(:delayed_job) }

      before do
        get :show, params: { id: record.id }
      end

      it 'renders :show template' do
        expect(response).to render_template :show
      end
    end

    describe 'PATCH #reload_all' do
      before do
        create_list(:delayed_job, 3)
        
        patch :reload_all
      end

      it 'redirects to jobs#enqueued' do
        expect(response).to redirect_to enqueued_jobs_path
      end
    end

    describe 'DELETE #destroy_all' do
      before do
        create_list(:delayed_job, 3)

        delete :destroy_all
      end

      it 'redirects_to jobs#failed' do
        expect(response).to redirect_to failed_jobs_path
      end
    end
  end
end
