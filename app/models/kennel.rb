# == Schema Information
#
# Table name: kennels
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  location    :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Kennel < ActiveRecord::Base
	has_many :events
	has_many :affiliations
	has_many :hashers, through: :affiliations

	def serializable_hash(options={})
		default = { except: [:created_at, :updated_at] }
		options = options.merge(default) { |k, x, y| x + y }
		hash = super options
		hash[:event_count] = events.count if option? options, :events_count
		hash[:hasher_count] = hashers.count if option? options, :events_count
		hash
	end

	def option?(options, opt)
		return options[:only].include?(opt) if options.has_key? :only
		return !options[:except].include?(opt) if options.has_key? :except
		true
	end
end