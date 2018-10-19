app.controller('ToolsController', function ($scope, $http) {

    $scope.itemsList = [];
    for (var i = 1; i <= 50; i++) {
        $scope.itemsList.push(blankItem(i));
    }

    $scope.refreshPopups = function () {
        $(document).ready(function () {
            //if pen is clicked
            $("td.editable i.edit-icon").on("click", function (e) {
                e.preventDefault();
                var url = '/Forecast/Consumed/' + e.target.dataset.itemId + '?m=' + String(e.target.dataset.itemMonth);
                if (e.target.dataset.hasOwnProperty("itemRevised")) {
                    if (e.target.dataset.itemRevised != null) {
                        url += '&r=' + e.target.dataset.itemRevised;
                    }

                }
                // Fixes dual-screen position                         Most browsers      Firefox
                var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : window.screenX;
                var dualScreenTop = window.screenTop != undefined ? window.screenTop : window.screenY;

                var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
                var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

                var left = ((width / 2) - (1000 / 2)) + dualScreenLeft;
                var top = ((height / 2) - (400 / 2)) + dualScreenTop;

                window.open(url, 'popup', 'width=900,height=500,left=' + left + ',top=' + top + ', scrollbars=no,resizable=no');
                window.somefunction = function () {
                    console.log("test");
                }
            });
        });
    };

    $scope.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    function blankItem(id) {
        return {
            ItemId: id,
            ItemName: "test item - " + id,
            ItemDesc: "Desc - " + id,
            Weight: (Math.random() * 100),
            M: (Math.random() * 10),
            I: (Math.random() * 10),
            P: (Math.random() * 10),
            ForecastData: [{
                month: 1,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 2,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 3,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 4,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 5,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 6,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 7,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 8,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 9,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 10,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 11,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            },
            {
                month: 12,
                consumption: 0,
                forecast: 0,
                revised: 0,
                actual: 0
            }]
        };
    };

    /** CONSUMER POPUP **/

    $scope.closePopup = function () {
        var user = confirm("Are you sure you want to close this window?");
        if (user) {
            window.close();
        }
    };

    $scope.saveDetails = function () {
        $scope.details = { 'test': 'test data' };

        $http({
            method: "POST",
            url: "/Forecast/Details",
            data: {
                'collection': JSON.stringify($scope.details)
            }
        }).then(function (response) {
            console.log(response);
        });
    };

});