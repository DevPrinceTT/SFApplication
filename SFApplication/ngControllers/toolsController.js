app.controller('ToolsController', function ($scope, $http) {
    $scope.itemsList = [];
    for (var i = 1; i <= 50; i++) {
        $scope.itemsList.push(blankItem(i));
    }

    $scope.test = function () {
        $(document).ready(function () {
            console.log($('.popup-open.consumed'));
            $('.popup-open.consumed').click(function (e) {
                e.preventDefault();
                window.open('/Forecast/Consumed/' + e.target.dataset.itemId + '?m=' + e.target.dataset.itemMonth, 'popup', 'width=600,height=600,scrollbars=no,resizable=no');
            });
        });
    };

    $scope.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    //$scope.openConsumption = function (e) {
    //    console.log(e);
    //    window.open('yourLink', 'popup', 'width=600,height=600,scrollbars=no,resizable=no');
    //    return false;
    //}

    function blankItem(id) {
        return {
            ItemId: id,
            ItemName: "item - " + id,
            Weight: (Math.random()*100),
            M: (Math.random()*10),
            I: (Math.random()*10),
            P: (Math.random() * 10),
            ForecastData: [{
                month: 1,
                consumption: "I" + id + "-M1-con",
                forecast: "I" + id + "-M1-fc",
                revised: "I" + id + "-M1-rev",
                actual: "I" + id + "-M1-act"
            },
            {
                month: 2,
                consumption: "I-" + id + "-M2-con",
                forecast: "I" + id + "-M2-fc",
                revised: "I" + id + "-M2-rev",
                actual: "I" + id + "-M2-act"
            },
            {
                month: 3,
                consumption: "I" + id +"-M3-con",
                forecast: "I" + id + "-M3-fc",
                revised: "I" + id + "-M3-rev",
                actual: "I" + id + "-M3-act"
            },
            {
                month: 4,
                consumption: "I" + id + "-M4-con",
                forecast: "I" + id + "-M4-fc",
                revised: "I" + id + "-M4-rev",
                actual: "I" + id + "-M4-act"
            },
            {
                month: 5,
                consumption: "I" + id + "-M5-con",
                forecast: "I" + id + "-M5-fc",
                revised: "I" + id + "-M5-rev",
                actual: "I" + id + "-M5-act"
            },
            {
                month: 6,
                consumption: "I" + id + "-M6-con",
                forecast: "I" + id + "-M6-fc",
                revised: "I" + id + "-M6-rev",
                actual: "I" + id + "-M6-act"
            },
            {
                month: 7,
                consumption: "I" + id + "-M7-con",
                forecast: "I" + id + "-M7-fc",
                revised: "I" + id + "-M7-rev",
                actual: "I" + id + "-M7-act"
            },
            {
                month: 8,
                consumption: "I" + id + "-M8-con",
                forecast: "I" + id + "-M8-fc",
                revised: "I" + id + "-M8-rev",
                actual: "I" + id + "-M8-act"
            },
            {
                month: 9,
                consumption: "I" + id + "-M9-con",
                forecast: "I" + id + "-M9-fc",
                revised: "I" + id + "-M9-rev",
                actual: "I" + id + "-M9-act"
            },
            {
                month: 10,
                consumption: "I" + id + "-M10-con",
                forecast: "I" + id + "-M10-fc",
                revised: "I" + id + "-M10-rev",
                actual: "I" + id + "-M10-act"
            },
            {
                month: 11,
                consumption: "I" + id + "-M11-con",
                forecast: "I" + id + "-M11-fc",
                revised: "I" + id + "-M11-rev",
                actual: "I" + id + "-M11-act"
            },
            {
                month: 12,
                consumption: "I" + id + "-M12-con",
                forecast: "I" + id + "-M12-fc",
                revised: "I" + id + "-M12-rev",
                actual: "I" + id + "-M12-act"
            }]
        };
    };
});