app.controller('layoutController', function ($scope, $uibModal, $compile) {
    $scope.openComponentModal = function () {
        var modalInstance = $uibModal.open({
            animation: false,
            templateUrl: $scope.url,
            controller: $scope.controller
            //controllerAs: '$scope'
            //size: 'sm'
        });
    };

    $scope.cancel = function () {
        modalInstance.dismiss('cancel');
    };
    

});