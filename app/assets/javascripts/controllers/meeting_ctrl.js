(function() {
  'use strict';

  angular.module("app").controller("meetingsCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get('/api/v1/meetings.json').then(function(response) {
        $scope.meetings = response.data;
      })
    }

    $scope.sortByDate = function(orderAttribute) {
      $scope.orderAttribute = orderAttribute;
      $scope.isReverse = !$scope.isReverse;
    }

    $scope.createMeeting = function(meeting) {
      console.log(meeting);
      $http.post('/api/v1/meetings.json', meeting).success(function(response) {
        console.log(response);
        $scope.meetings.push(meeting);
        $scope.meeting = {};
      })
    }
  });
})();
