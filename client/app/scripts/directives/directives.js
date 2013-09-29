'use strict';

angular.module('oncheckinApp')
  .directive('modal', function() {
    return {
      restrict: 'E',
      replace: true,
      transclude: true,
      scope: { title: '@', close: '&' },
      templateUrl: 'template/modal/modal.html'
    };
  });