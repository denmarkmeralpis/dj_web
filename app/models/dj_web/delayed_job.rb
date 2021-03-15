# frozen_string_literal: true

module DjWeb
  class DelayedJob < ::Delayed::Job 
    scope :enqueued, -> { all }
    scope :pending,  -> { where(attempts: 0, locked_at: nil) }
    scope :working,  -> { where(failed_at: nil).where.not(locked_at: nil) }
    scope :failed,   -> { where.not(last_error: nil) }

    def failed?
      last_error.present?
    end

    def pending?
      attempts.zero? && locked_at.blank?
    end

    def working?
      failed_at.blank? && locked_at.present?
    end

    def status
      if working?
        'working'
      elsif failed?
        'failed'
      elsif pending?
        'pending'
      else
        'enqueued'
      end
    end
  end
end
