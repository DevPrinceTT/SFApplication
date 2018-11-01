app.controller('ItemController', function ($scope, $http) {
   
    //initialize objects
    $scope.item = {};
    $scope.errors = [];

    $scope.refreshPopups = function () {
        $(document).ready(function () {
            //if pen is clicked
            $(".edit-item-btn").on("click", function (e) {
                e.preventDefault();
                var url = '/Items/EditItem/' + e.target.dataset.itemId;

                popupwindow(url, 300, 600, $scope.refreshList);
            });


            $(".delete-item-btn").on("click", function (e) {
                e.preventDefault(e.target.dataset.itemId);
                $scope.deleteItem(e.target.dataset.itemId);
            });
        });
    };

    $scope.refreshList = function () {
        console.log("triggered");
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
        });
    };

    $scope.indexLoad = function () {
        $scope.items = [];
        $scope.synced = 0;
        $scope.custom = 0;
        $scope.imported = 0;

        $scope.$watch('filter_status', function () {
            $scope.refreshPopups();
        });

        $scope.$watch('filter_fld_code', function () {
            $scope.refreshPopups();
        });

        $scope.$watch('filter_vendor_code', function () {
            $scope.refreshPopups();
        });

        $scope.$watch('filter_fdl_desc', function () {
            $scope.refreshPopups();
        });

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
        });
    };

    $scope.closePopup = function () {
        var user = confirm("Are you sure you want to close this window?");
        if (user) {
            window.close();
        }
    };

    $scope.saveItem = function () {

        //merege changes
        $scope.item = $.extend($scope.item, $scope.item.model);

        $http({
            method: "POST",
            url: "/Items/EditItem",
            data: {
                'collection': JSON.stringify($scope.item)
            }
        }).then(function (response) {
            handleRepsonse(response);
        });
    };

    $scope.addItem = function () {
        $http({
            method: "POST",
            url: "/Items/AddItem",
            data: {
                'collection': JSON.stringify($scope.item)
            }
        }).then(function (response) {
            handleRepsonse(response);
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

    $scope.populateForEdit = function (model) {
        $scope.item = model;
        $scope.$apply();
    }

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
                    alert(response.data.Message);
                }

                if (response.data.MessageType == "success" && response.data.ShowDialog == true) {
                    //close window
                    window.close();
                }
            }
        }
    }

});