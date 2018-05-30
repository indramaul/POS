(function(){
    'use strict';

    angular
        .module('app')
        .service('PosServices',PosServices);


    PosServices.$inject=['$http','$state'];
    function PosServices($http,$state) {
        var url = 'http://127.0.0.1:5002/';
        var service = {
            toko:toko,
            kasir:kasir,
            minuman:minuman,
            makanan:makanan,
            transaksi:transaksi,
            print:print,
            login:login

        };

        return service;

        function toko() {
            return $http.get(url + 'toko',{});
        }

        function kasir() {
            return $http.get(url + 'kasir',{});
        }

        function minuman() {
            return $http.get(url + 'minuman',{});
        }

        function makanan() {
           return $http.get(url + 'makanan', {});
        }

        function transaksi(params) {
            return $http.post(url + 'transaksi', params,{});

        }

        function login(params) {
            return $http.post(url + 'login', params,{});
        }

        function print(params) {
          //  return $http.post(url + 'print', params, {});
          //change for print on jendela
            return $http.post('http://127.0.0.1:5002/print', params, {});
        }
    }
})();
