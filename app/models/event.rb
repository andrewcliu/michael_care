class Event < ApplicationRecord
  alias_attribute :start_time, :start_date
	def self.form_field 
		%w'title end_date start_date description id'
	end

	def form_field
		%w'title end_date start_date description'
	end
end
