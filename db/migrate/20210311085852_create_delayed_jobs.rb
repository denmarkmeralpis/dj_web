class CreateDelayedJobs < ActiveRecord::Migration[5.2]
  def self.up
    if ActiveRecord::Base.connection.table_exists?('delayed_jobs')
      puts "-- delayed_jobs already created"
    else
      create_table :delayed_jobs do |table|
        table.integer :priority, default: 0, null: false 
        table.integer :attempts, default: 0, null: false 
        table.text :handler,                 null: false 
        table.text :last_error                           
        table.datetime :run_at                           
        table.datetime :locked_at                        
        table.datetime :failed_at                        
        table.string :locked_by                          
        table.string :queue                              
        table.timestamps null: true
      end

      add_index :delayed_jobs, %i[priority run_at], name: 'delayed_jobs_priority'
    end
  end

  def self.down
    if ActiveRecord::Base.connection.table_exists?('delayed_jobs')
      drop_table :delayed_jobs
    end
  end
end
