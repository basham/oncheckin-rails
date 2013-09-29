'use strict';

angular.module('oncheckinApp')
  .factory('Chapters', function ($resource) {
    return $resource('/api/1/chapters');
  })
  .factory('Chapter', function ($resource) {
    return $resource('/api/1/chapters/:chapterId', { chapterId: '@id' });
  })
  .factory('ChapterParticipants', function ($resource) {
    return $resource('/api/1/chapters/:chapterId/participants', { chapterId: '@chapter_id' });
  })
  .factory('QueryChapterParticipants', function ($http, limitToFilter) {
    return function(chapterId, query) {
      return $http.get('/api/1/chapters/' + chapterId + '/participants?query=' + query).then(function(response) {
        // TODO
        // Limit on server-side.
        return limitToFilter(response.data, 10);
      });
    };
  })
  .factory('ChapterEvents', function ($resource) {
    return $resource('/api/1/chapters/:chapterId/events', { chapterId: '@id' });
  })
  .factory('Event', function ($resource) {
    return $resource('/api/1/events/:eventId', { eventId: '@id' });
  })
  .factory('Participant', function ($resource) {
    //return function(options) {
      return $resource('/api/1/participants/:participantId', { participantId: '@id' }, {
        attend: { method: 'PUT' }
      });
    //};
  })
  .factory('Attendance', function ($resource) {
    return $resource('/api/1/attendances/:attendanceId', { attendanceId: '@id' }, {
      host: { method: 'PUT' }
    });
  })
  .factory('NewParticipantDialog', function ($dialog) {
    var options = {
      backdrop: true,
      keyboard: true,
      backdropClick: true,
      templateUrl: 'partials/dialog.participant.new.html',
      controller: 'NewParticipantDialogCtrl'
    };
    return function(chapterId, eventId) {
      options.chapterId = chapterId;
      options.eventId = eventId;
      return $dialog.dialog(options);
    };
  });