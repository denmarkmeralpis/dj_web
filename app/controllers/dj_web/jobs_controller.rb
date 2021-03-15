# frozen_string_literal: true

require_dependency 'dj_web/application_controller'

module DjWeb
  class JobsController < ApplicationController
    before_action :find_job, only: %i[retry reload destroy show]

    def enqueued
      @jobs = DelayedJob.enqueued.paginate(page: params[:page], per_page: 10)
    end

    def pending
      @jobs = DelayedJob.pending.paginate(page: params[:page], per_page: 10)
    end

    def working
      @jobs = DelayedJob.working.paginate(page: params[:page], per_page: 10)
    end

    def failed
      @jobs = DelayedJob.failed.paginate(page: params[:page], per_page: 10)
    end

    def retry
      @job.update(run_at: Time.current, failed_at: nil)

      redirect_to job_path(@job), notice: 'Job has been requeued'
    end

    def reload
      @job.update(
        run_at: Time.now,
        failed_at: nil,
        locked_by: nil,
        locked_at: nil,
        last_error: nil,
        attempts: 0
      )

      redirect_to job_path(@job), notice: 'Job has been reloaded'
    end

    def destroy
      @job.delete

      redirect_to enqueued_jobs_path, notice: 'Job has been deleted'
    end

    def show; end

    def reload_all
      DelayedJob.failed.update_all(
        run_at: Time.now,
        failed_at: nil,
        locked_by: nil,
        locked_at: nil,
        last_error: nil,
        attempts: 0
      )

      redirect_to enqueued_jobs_path, notice: 'Jobs has been reloaded'
    end

    def destroy_all
      DelayedJob.failed.delete_all

      redirect_to failed_jobs_path, notice: 'Jobs has beed deleted'
    end

    private

    def find_job
      @job = DelayedJob.find_by(id: params[:id])

      redirect_to pages_path, alert: 'DelayedJob queue not found' unless @job
    end
  end
end
