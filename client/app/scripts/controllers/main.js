'use strict';

angular.module('oncheckinApp')
  .controller('MainCtrl', function ($scope) {
  })
  .controller('NewEventDialogCtrl', function ($scope, $modalInstance, chapterId, Event, $filter) {

    $scope.event = {};
    $scope.event.startDate = $filter('date')(Date.now(), 'yyyy-MM-dd');

    var save = function() {
      var event = new Event();
      event.chapter_id = chapterId;
      event.name = $scope.event.name;
      event.description = $scope.event.description;

      var timezone = 'EDT';

      var startTime = [$scope.event.startDate, $scope.event.startTime, timezone].join(' ');
      event.start_time = startTime;

      var endTime = [$scope.event.endDate, $scope.event.endTime, timezone].join(' ');
      event.end_time = $scope.event.endTime;

      event.$save(function(p, h) {
        console.log(p, h);
      });
//console.log(event);
      return event;
    };

    $scope.save = function() {
      $scope.close(save());
    };

    $scope.close = function(result) {
      $modalInstance.close(result);
    };
  })
  .controller('NewParticipantDialogCtrl', function ($scope, $modalInstance, chapterId, eventId, Participant) {
    
    $scope.isWithinEvent = angular.isDefined(eventId);

/*
    $scope.firstName = '';
    $scope.lastName = '';
    $scope.alias = '';
    $scope.recordedSince = '';
    */
    $scope.participant = {};
    $scope.participant.recordedAttendanceCount = 0;
    $scope.participant.recordedHostCount = 0;

    var save = function() {
      var participant = new Participant();
      participant.first_name = $scope.participant.firstName;
      participant.last_name = $scope.participant.lastName;
      participant.alias = $scope.participant.alias;
      participant.affiliation = {
        chapter_id: chapterId,
        recorded_since: $scope.participant.recordedSince,
        recorded_attendance_count: $scope.participant.recordedAttendanceCount,
        recorded_host_count: $scope.participant.recordedHostCount
      };
      //participant.event_id = eventId;
      participant.$save(function(p, h) {
        console.log(p, h);
      });

      return participant;
    };

    $scope.save = function() {
      //console.log($scope);
      //save();
      $scope.close(save());
    };

    $scope.saveAndAttend = function() {
      $scope.close();
    };

    $scope.close = function(result) {
      $modalInstance.close(result);
    };
  });