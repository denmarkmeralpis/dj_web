FactoryBot.define do
  factory :delayed_job, class: DjWeb::DelayedJob do
    run_at { Time.current }
    queue { 'searchkick' }
    handler { Time.current.to_yaml }
  end
end
