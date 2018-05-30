(function () {
    'use strict';

    angular
        .module('app')
        .config(config);

    config.$inject = ['$stateProvider'];

    function config($stateProvider) {


        $stateProvider.state('login', {
            url: '/login',
            templateUrl: 'views/login.html',
            controller: 'loginCtrl',
            controllerAs: 'vm'
        });
        $stateProvider.state('home', {
                url: '/home/:name',
                templateUrl: 'views/home.html',
                controller: 'homeCtrl',
                controllerAs: 'vm'
        });
    }
})();