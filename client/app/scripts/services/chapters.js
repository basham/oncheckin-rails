'use strict';

angular.module('oncheckinApp')
  .factory('Chapters', function ($resource) {
    return $resource('/api/1/chapters');
  })
  .factory('Chapter', function ($resource) {
    return $resource('/api/1/chapters/:chapterId', { chapterId: '@id' });
  })
  .factory('ChapterParticipants', function ($resource) {
    return $resource('/api/1/chapters/:chapterId/participants', { chapterId: '@id' });
  })
  .factory('ChapterEvents', function ($resource) {
    return $resource('/api/1/chapters/:chapterId/events', { chapterId: '@id' });
  });
