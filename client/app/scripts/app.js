'use strict';

angular.module('oncheckinApp', ['ngResource', 'ui.compat'])
	.config(function($stateProvider, $routeProvider, $urlRouterProvider) {

		//
		// For any unmatched url, send to /route1
		$urlRouterProvider.otherwise('/Chapters');
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
					controller: function($scope, $state, Chapter) {
						$scope.chapter = Chapter.get({ chapterId: $state.params.chapterId });
					}
				})
					.state('app.chapters.detail.events', {
						abstract: true,
						url: '/hashes',
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
				url: '/hashes',
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
					controller: function($scope, $state, Event) {
						$scope.event = Event.get({ eventId: $state.params.eventId });
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
	.run(function($rootScope, $state, $stateParams) {
		$rootScope.$state = $state;
		$rootScope.$stateParams = $stateParams;
		//$state.transitionTo('app.chapters.list');
	});
