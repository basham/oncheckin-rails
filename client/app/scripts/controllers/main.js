'use strict';

angular.module('oncheckinApp')
  .controller('MainCtrl', function ($scope) {
  })
  .controller('NewEventDialogCtrl', function ($scope, $modalInstance, chapterId) {

    $scope.close = function(result) {
      $modalInstance.close(result);
    };

    //console.log($scope);
    //var chapterId = $modalInstance.options.chapterId;
    /*
    var eventId = $modalInstance.options.eventId;
    
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
      $modalInstance.close(result);
    };
    */
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