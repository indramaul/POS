(function () {
    'use strict';

    angular
        .module('app')
        .controller('loginCtrl', loginCtrl);

    loginCtrl.$inject = ['$state', 'PosServices'];
    function loginCtrl($state, PosServices) {
        var vm = this;

        vm.cashier_name='';
        vm.kasir = [];

        getKasir();

        function getKasir(){
            PosServices.kasir().then(function(response){
              vm.kasir = response.data.data;
            });
        }

        vm.GoToMenu = function (name) {
          $state.go('home',{name: name},{reload:true})
        };
    }
})();
