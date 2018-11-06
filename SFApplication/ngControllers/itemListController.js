app.controller('ItemListController', function ($scope, $http) {

    //initialize objects
    $scope.item = {};

    $scope.refreshList = function () {
        $http({
            method: "GET",
            url: "/Items/ListItems",
        }).then(function (response) {
            $scope.items = [];
            $scope.items = response.data;

            //get counts
            $scope.synced = ($.grep($scope.items, function (item) {
                return item.Status == "Synced";
            })).length;
            $scope.custom = ($.grep($scope.items, function (item) {
                return item.Status == "Custom";
            })).length;
            $scope.imported = ($.grep($scope.items, function (item) {
                return item.Status == "Imported";
            })).length;

        }).then($scope.refreshPopups());
    };

    $scope.refreshPopups = function () {

        $(document).ready(function () {
            $(".delete-item-btn").on("click", function (e) {
                e.preventDefault(e.target.dataset.itemId);
                $scope.deleteItem(e.target.dataset.itemId);
            });
        });
    };

    $scope.indexLoad = function () {
        $scope.items = [];
        $scope.synced = 0;
        $scope.custom = 0;
        $scope.imported = 0;

        delete($scope.filter_status);
        $scope.$watch('filter_status', function () {
            $scope.refreshPopups();
        });

        delete($scope.filter_fld_code);
        $scope.$watch('filter_fld_code', function () {
            $scope.refreshPopups();
        });

        delete($scope.filter_vendor_code);
        $scope.$watch('filter_vendor_code', function () {
            $scope.refreshPopups();
        });

        delete($scope.filter_fdl_desc);
        $scope.$watch('filter_fdl_desc', function () {
            $scope.refreshPopups();
        });

        delete($scope.filter_vendor_desc);
        $scope.$watch('filter_vendor_desc', function () {
            $scope.refreshPopups();
        });

        $http({
            method: "GET",
            url: "/Items/ListItems",
        }).then(function (response) {
            $scope.items = response.data;

            //get counts
            $scope.synced = ($.grep($scope.items, function (item) {
                return item.Status == "Synced";
            })).length;
            $scope.custom = ($.grep($scope.items, function (item) {
                return item.Status == "Custom";
            })).length;
            $scope.imported = ($.grep($scope.items, function (item) {
                return item.Status == "Imported";
            })).length;
            }).then(function () {
                console.log("done");
                rp();
            });
    };

    $scope.deleteItem = function (id) {
        var confirm_delete = confirm("Are you sure you want to delete this item?");
        if (confirm_delete != true) {
            return;
        }

        $http({
            method: "POST",
            url: "/Items/DeleteItem/",
            data: {
                'id': id
            }
        }).then(function (response) {
            handleRepsonse(response);
        });
    };

    function handleRepsonse(response) {

        if (response.hasOwnProperty("data")) {
            //handle validation errors
            if (response.data.hasOwnProperty("Errors")) {
                if (response.data.Errors != null) {

                    var serverErrors = response.data.Errors;

                    //reset validation message for all elements
                    $('input.validation-error').removeClass('validation-error');
                    $('select.validation-error').removeClass('validation-error');
                    $('textarea.validation-error').removeClass('validation-error');
                    $('span.validation-message').addClass('hidden');

                    //add validation message to relevant elements
                    for (var i = 0; i < serverErrors.length; i++) {
                        $scope.errors[serverErrors[i].Key] = serverErrors[i].Value;
                        $('#' + serverErrors[i].Key).addClass('validation-error');
                        $('span.' + serverErrors[i].Key).removeClass('hidden');
                    }
                }
            }


            //close window if successful
            if (response.data.hasOwnProperty("MessageType") && response.data.hasOwnProperty("Message")) {
                //display message from server
                if (response.data.Message != null) {
                    //alert(response.data.Message);
                }

                if (response.data.MessageType == "success" && response.data.ShowDialog == true) {
                    window.dispatchEvent(new Event("scopeUpdated"));
                }
            }
        }
    }

    window.addEventListener("scopeUpdated", function () {
        $scope.refreshList();
    });


});