app.controller('ToolsController', function ($scope, $http) {
    $scope.itemsList = [];
    for (var i = 1; i <= 1000; i++) {
        $scope.itemsList.push(blankItem(i));
    }

    $scope.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    function blankItem(id) {
        return {
            ItemId: "item-" + id,
            ItemName: null,
            ForecastData: [{
                month: 1,
                consumption: "item-" + id + "c1",
                forecast: "item-" + id + "f1",
                revised: "item-" + id + "r1",
                actual: "item-" + id + "a1"
            },
            {
                month: 2,
                consumption: "item-" + id + "c2",
                forecast: "item-" + id + "f2",
                revised: "item-" + id + "r2",
                actual: "item-" + id + "a2"
            },
            {
                month: 3,
                consumption: "item-" + id + "c3",
                forecast: "item-" + id + "f3",
                revised: "item-" + id + "r3",
                actual: "item-" + id + "a3"
            },
            {
                month: 4,
                consumption: "item-" + id + "c4",
                forecast: "item-" + id + "f4",
                revised: "item-" + id + "r4",
                actual: "item-" + id + "a4"
            },
            {
                month: 5,
                consumption: "item-" + id + "c5",
                forecast: "item-" + id + "f5",
                revised: "item-" + id + "r5",
                actual: "item-" + id + "a5"
            },
            {
                month: 6,
                consumption: "item-" + id + "c6",
                forecast: "item-" + id + "f6",
                revised: "item-" + id + "r6",
                actual: "item-" + id + "a6"
            },
            {
                month: 7,
                consumption: "item-" + id + "c7",
                forecast: "item-" + id + "f7",
                revised: "item-" + id +  "r7",
                actual: "item-" + id + "a7"
            },
            {
                month: 8,
                consumption: "item-" + id +  "c8",
                forecast: "item-" + id + "f8",
                revised: "item-" + id + "r8",
                actual: "item-" + id + "a8"
            },
            {
                month: 9,
                consumption: "item-" + id + "c9",
                forecast: "item-" + id +  "f9",
                revised: "item-" + id + "r9",
                actual: "item-" + id + "a9"
            },
            {
                month: 10,
                consumption: "item-" + id + "c10",
                forecast: "item-" + id +"f10",
                revised: "item-" + id +  "r10",
                actual: "item-" + id + "a10"
            },
            {
                month: 11,
                consumption: "item-" + id +  "c11",
                forecast: "item-" + id + "f11",
                revised: "item-" + id + "r11",
                actual: "item-" + id + "a11"
            },
            {
                month: 12,
                consumption: "item-" + id + "c12",
                forecast: "item-" + id + "f12",
                revised: "item-" + id + "r12",
                actual: "item-" + id + "a12"
            }
            ]
        };
    };
});