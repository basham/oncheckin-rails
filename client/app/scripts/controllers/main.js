'use strict';

angular.module('oncheckinApp')
  .controller('MainCtrl', function ($scope) {
  })
  .controller('NewParticipantDialogCtrl', function ($scope, dialog, Participant) {
    var chapterId = dialog.options.chapterId;
    var eventId = dialog.options.eventId;
    
    $scope.isWithinEvent = angular.isDefined(eventId);

    var save = function() {
      var participant = new Participant();
      participant.first_name = $scope.firstName;
      participant.last_name = $scope.lastName;
      participant.alias = $scope.alias;
      participant.affiliation = {
        chapter_id: chapterId,
        recorded_since: $scope.recordedSince,
        recorded_attendance_count: $scope.recordedAttendanceCount,
        recorded_host_count: $scope.recordedHostCount
      };
      //participant.event_id = eventId;
      participant.$save(function(p, h) {
        console.log(p, h);
      });
    };

    $scope.save = function() {
      //console.log($scope);
      save();
      $scope.close();
    };

    $scope.saveAndAttend = function() {
      $scope.close();
    };

    $scope.close = function(result) {
      dialog.close(result);
    };
  });