app.controller('ToolsController', function ($scope, $http, $uibModal) {
    $scope.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];


    $scope.itemsList = [];
    $.get("/Forecast/GetForecastItems/1").then(function (response) {
        $scope.itemsList = response.ForecastItems;
        $scope.$apply();
    });

    $scope.closePopup = function () {
        $uibModal.dismiss('cancel');
    };


});