# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

kennel = Kennel.find_or_create_by_name('Blooming Fools')
kennel.location = 'Bloomington, IN'
kennel.url = 'http://www.bfh3.com'
kennel.description = 'Hash House Harriers club hashing alternating Saturdays, full moons. Runners, walkers welcome. $6 for 3-5mi trail, post-trail ritual, party.'
kennel.save

hasher1 = Hasher.find_or_create_by_hash_name('White Lightning')
hasher1.first_name = 'John'
hasher1.last_name = 'Branigin'
hasher1.save

affiliation = Affiliation.find_or_create_by_kennel_id_and_hasher_id(kennel.id, hasher1.id)
affiliation.recorded_attendance_count = 342
affiliation.recorded_hare_count = 99
affiliation.recorded_since = Date.parse('2013-06-22')
affiliation.save

hasher2 = Hasher.find_or_create_by_hash_name('Mothershucker')
hasher2.first_name = 'Allen'
hasher2.last_name = 'Edwards'
hasher2.save

affiliation = Affiliation.find_or_create_by_kennel_id_and_hasher_id(kennel.id, hasher2.id)
affiliation.recorded_attendance_count = 104
affiliation.recorded_hare_count = 31
affiliation.recorded_since = Date.parse('2013-06-08')
affiliation.save

event = Event.find_or_create_by_name('Freshwater Fourth of July Hash')
event.kennel = kennel
event.start_time = DateTime.parse('2013-07-04T16:00:00-04:00')
event.description = 'What’s a Fourth of July to the Blooming Fools but another chance to get out into the glorious wide open American landscape and celebrate what this country’s really all about?'
event.save

attendance = Attendance.find_or_create_by_event_id_and_hasher_id(event.id, hasher1.id)
attendance.tag_list = 'hare'
attendance.save

attendance = Attendance.find_or_create_by_event_id_and_hasher_id(event.id, hasher2.id)
attendance.tag_list = 'hare'
attendance.save