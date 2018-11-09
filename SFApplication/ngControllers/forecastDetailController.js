app.controller('ForecastDetailController', function ($scope, $http) {
    $scope.closePopup = function () {
       // $uibModalInstance.dismiss('cancel');
    };


    $scope.populateList = function (id, month) {
        if (id == null || month == null || typeof(month) != "number") {
            return false;
        }

        //
        var formatter = new Intl.DateTimeFormat("en", { month: "long" });

        $scope.MonthName = formatter.format(new Date().setMonth(month - 1));

        $.get('/Forecast/GetConsumerReport/' + id + '?month=' + month)
            .then(function (response) {
                $scope.Customers = {};
                $scope.Customers = response
            })
            .then(function () {
                $scope.$apply();
                $("#loading").hide();
            });
    };

    $scope.saveDetails = function () {

        $http({
            method: "POST",
            url: "/Forecast/Details",
            data: {
                'collection': JSON.stringify($scope.details)
            }
        }).then(function (response) {
            $scope.$apply();
        });
    };

});