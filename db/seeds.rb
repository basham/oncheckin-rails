# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chapter = Chapter.find_or_create_by_name('Blooming Fools')
chapter.location = 'Bloomington, IN'
chapter.url = 'http://www.bfh3.com'
chapter.description = 'Hash House Harriers club hashing alternating Saturdays, full moons. Runners, walkers welcome. $6 for 3-5mi trail, post-trail ritual, party.'
chapter.save

participant1 = Participant.find_or_create_by_alias('White Lightning')
participant1.first_name = 'John'
participant1.last_name = 'Branigin'
participant1.save

affiliation = Affiliation.find_or_create_by_chapter_id_and_participant_id(chapter.id, participant1.id)
affiliation.recorded_attendance_count = 342
affiliation.recorded_host_count = 99
affiliation.recorded_since = Date.parse('2013-06-22')
affiliation.save

participant2 = Participant.find_or_create_by_alias('Mothershucker')
participant2.first_name = 'Allen'
participant2.last_name = 'Edwards'
participant2.save

affiliation = Affiliation.find_or_create_by_chapter_id_and_participant_id(chapter.id, participant2.id)
affiliation.recorded_attendance_count = 104
affiliation.recorded_host_count = 31
affiliation.recorded_since = Date.parse('2013-06-08')
affiliation.save

event = Event.find_or_create_by_name('Freshwater Fourth of July Hash')
event.chapter = chapter
event.start_time = DateTime.parse('2013-07-04T16:00:00-04:00')
event.description = 'What’s a Fourth of July to the Blooming Fools but another chance to get out into the glorious wide open American landscape and celebrate what this country’s really all about?'
event.save

attendance = Attendance.find_or_create_by_event_id_and_participant_id(event.id, participant1.id)
attendance.tag_list = 'host'
attendance.save

attendance = Attendance.find_or_create_by_event_id_and_participant_id(event.id, participant2.id)
attendance.tag_list = 'host'
attendance.save