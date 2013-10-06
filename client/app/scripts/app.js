'use strict';

angular.module('oncheckinApp', ['ngResource', 'ui.router', 'ui.bootstrap', 'angular-cache'])
  .config(function($stateProvider, $routeProvider, $urlRouterProvider) {

    //
    // For any unmatched url, send to /route1
    $urlRouterProvider.otherwise('/kennels');
    //
    // Now set up the states
    $stateProvider
      .state('app', {
        abstract: true,
        //templateUrl: 'partials/app.html'
        template: '<div ui-view></div>'
      })
      .state('app.chapters', {
        abstract: true,
        url: '/kennels',
        template: '<div ui-view></div>'
      })
        .state('app.chapters.list', {
          url: '',
          templateUrl: 'partials/app.chapters.list.html',
          controller: function($scope, $state, Chapters) {
            $scope.chapters = Chapters.query();
          }
        })
        .state('app.chapters.detail', {
          url: '/{chapterId}',
          templateUrl: 'partials/app.chapters.detail.html',
          controller: function($scope, $state, Chapter, NewEventDialog, NewParticipantDialog) {
            $scope.chapter = Chapter.get({ chapterId: $state.params.chapterId });

            $scope.openNewEventDialog = function() {
              var d = NewEventDialog($state.params.chapterId);
            };

            $scope.openNewParticipantDialog = function() {
              var d = NewParticipantDialog($state.params.chapterId);
            };
          }
        })
          .state('app.chapters.detail.events', {
            abstract: true,
            url: '/events',
            template: '<div ui-view></div>'
          })
            .state('app.chapters.detail.events.list', {
              url: '',
              templateUrl: 'partials/app.chapters.detail.events.list.html',
              controller: function($scope, $state, ChapterEvents) {
                $scope.events = ChapterEvents.query({ chapterId: $state.params.chapterId });
              }
            })
          .state('app.chapters.detail.participants', {
            abstract: true,
            url: '/hashers',
            template: '<div ui-view></div>'
          })
            .state('app.chapters.detail.participants.list', {
              url: '',
              templateUrl: 'partials/app.chapters.detail.participants.list.html',
              controller: function($scope, $state, ChapterParticipants) {
                $scope.participants = ChapterParticipants.query({ chapterId: $state.params.chapterId });
              }
            })
      .state('app.events', {
        abstract: true,
        url: '/events',
        template: '<div ui-view></div>'
      })
        .state('app.events.list', {
          url: '',
          templateUrl: 'partials/app.events.list.html',
          controller: function($scope, $state, Events) {
            $scope.events = Events.query({ eventId: $state.params.eventId });
          }
        })
        .state('app.events.detail', {
          url: '/{eventId}',
          templateUrl: 'partials/app.events.detail.html',
          controller: function($scope, $state, Event, QueryChapterParticipants, Participant, NewParticipantDialog, Attendance) {
            
            // Load the event
            $scope.event = Event.get({ eventId: $state.params.eventId });

            // Set defaults
            $scope.selectedParticipant = { query: '' };

            // For whatever reason, $resource isn't returning the right kind of promises
            // that would make Typeahead work. So use $http.
            $scope.getParticipants = function(query) {
              return QueryChapterParticipants($scope.event.chapter.id, query);
            };

            $scope.onSelectParticipant = function($item, $model, $label) {
              var p = new Participant();
              p.$attend({ participantId: $model.id, event_id: $scope.event.id }, function(attendance) {
                // Place the new attendance at the top of the guest list
                $scope.event.attendances.unshift(attendance);
                // Sync counters
                $scope.event.guest_count += 1;
              });
              $scope.selectedParticipant.query = '';
            };

            $scope.removeAttendance = function(attendance) {
              var a = new Attendance();
              a.$delete({ attendanceId: attendance.id },function() {
                // Remove the attendance
                $scope.event.attendances.splice( $scope.event.attendances.indexOf(attendance), 1 );
                // Sync counters
                if( attendance.host )
                  $scope.event.host_count += -1;
                else
                  $scope.event.guest_count += -1;
              });
            };

            $scope.changeHostStatus = function(attendance, value) {
              var a = new Attendance();
              a.$host({ attendanceId: attendance.id, host: value }, function() {
                // Update host status
                attendance.host = value;
                // Sync counters
                $scope.event.host_count += value ? 1 : -1;
                $scope.event.guest_count += value ? -1 : 1;
              });
            }

            $scope.openNewParticipantDialog = function() {
              var d = NewParticipantDialog($scope.event.chapter.id, $scope.event.id);
            };
          }
        })
        .state('app.events.print', {
          url: '/{eventId}/print',
          templateUrl: 'partials/app.events.print.html',
          controller: function($scope, $state, EventPrint) {
            $scope.event = EventPrint.get({ eventId: $state.params.eventId });
          }
        })
      .state('app.participants', {
        abstract: true,
        url: '/hashers',
        template: '<div ui-view></div>'
      })
        .state('app.participants.list', {
          url: '',
          templateUrl: 'partials/app.participants.list.html',
          controller: function($scope, $state, Participants) {
            $scope.participants = Participants.query({ participantId: $state.params.participantId });
          }
        })
        .state('app.participants.detail', {
          url: '/{participantId}',
          templateUrl: 'partials/app.participants.detail.html',
          controller: function($scope, $state, Participant) {
            $scope.participant = Participant.get({ participantId: $state.params.participantId });
          }
        })
          .state('app.participants.detail.chapters', {
            abstract: true,
            url: '/kennels',
            template: '<div ui-view></div>'
          })
            .state('app.participants.detail.chapters.list', {
              url: '',
              templateUrl: 'partials/app.participants.detail.chapters.list.html',
              controller: function($scope, $state, ParticipantChapters) {
                $scope.ParticipantChapters = ParticipantChapters.query({ participantId: $state.params.participantId });
              }
            })
            .state('app.participants.detail.chapters.detail', {
              url: '/{chapterId}',
              templateUrl: 'partials/app.participants.detail.chapters.detail.html',
              controller: function($scope, $state, ParticipantChapter) {
                $scope.participantChapter = ParticipantChapter.get({ participantId: $state.params.participantId, chapterId: $state.params.chapterId });
              }
            });

  })
  .run(function($rootScope, $state, $stateParams, $angularCacheFactory, $http) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;
    //$state.transitionTo('app.chapters.list');

    $angularCacheFactory('defaultCache', {
      maxAge: 90000, // Items added to this cache expire after 15 minutes.
      cacheFlushInterval: 600000, // This cache will clear itself every hour.
      aggressiveDelete: true // Items will be deleted from this cache right when they expire.
    });

    //$http.defaults.cache = $angularCacheFactory.get('defaultCache');
  });
