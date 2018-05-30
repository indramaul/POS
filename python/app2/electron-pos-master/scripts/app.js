(function () {
    'use strict';

    angular
    .module('app', [
        'ui.router',
        'ngAnimate',
        'ngMaterial'
    ])

        .config(config)
        .run(run);
   

    config.$inject=['$urlRouterProvider', '$stateProvider'];

    function config($urlRouterProvider, $stateProvider) {
        $urlRouterProvider.otherwise('/login');
    }

    run.$inject = [];
    function run() {
    }
})();