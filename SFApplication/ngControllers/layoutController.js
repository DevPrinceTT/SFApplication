app.controller('layoutController', function ($scope, $uibModal, $compile) {
    $scope.openComponentModal = function () {

        var modalInstance = $uibModal.open({
            animation: false,
            templateUrl: $scope.url,
            controller: $scope.controller,
            backdrop: 'static',
            size: ($scope.size != null) ? $scope.size : 'sm',
            controllerAs: '$subScope'
        });
    };

    $scope.cancel = function () {
        modalInstance.dismiss('cancel');
    };
    

});