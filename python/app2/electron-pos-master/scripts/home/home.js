(function () {
    'use strict';

    angular
        .module('app')
        .controller('homeCtrl', homeCtrl);

    homeCtrl.$inject = ['$scope','$stateParams', 'PosServices', '$state'];
    function homeCtrl($scope,$stateParams, PosServices, $state) {
        var vm = this;
        vm.kasir_id = $stateParams.name;

        vm.cashier_name = null;
        vm.toko = null;
        vm.toko_id = null;
        vm.toko_alamat = null;
        vm.makanan = [];
        vm.minuman = [];
        vm.invoice = Math.floor(Math.random() * 90000) + 10000;
        vm.number = [1,2,3,4,5,6,7,8,9,0];
        vm.show_bayar = false;
        vm.bayar = 0;
        vm.show_delete = [];

        vm.sugest_bayar = [10000,20000,50000,100000];

        getToko();
        getMakanan();
        getMinuman();
        getKasir();

        function getKasir(){
            PosServices.kasir().then(function(response){
              response.data.data.forEach(function(item, index){
                 if(item.Id == vm.kasir_id){
                   vm.cashier_name = item.Name;
                 }
              });
            });
        }

        function getToko() {
          PosServices.toko().then(function(response){
              if(response){
                response.data.data.forEach(function(item, index){
                  vm.toko_id = item.Id;
                  vm.toko = item.Name;
                  vm.toko_alamat = item.alamat;
                })
              }
            }, function(error){
               alert(error)
            })
        }

        function getMakanan() {
          PosServices.makanan().then(function(response){
              vm.makanan = response.data.data;
            }, function(error){
               alert(error)
            })
        }

        function getMinuman() {
          PosServices.minuman().then(function(response){
               vm.minuman = response.data.data;
            }, function(error){
               alert(error)
            })
        }


        vm.itemsCnt = 1;
        vm.order = [];

        vm.add = function (item) {
          var d = new Date,
           dformat = [d.getFullYear() ,d.getMonth()+1,
               d.getDate()
               ].join('-')+' '+
              [d.getHours(),
               d.getMinutes(),
               d.getSeconds()].join(':');
            var foodItem = {
                transaksi_invoice: vm.invoice,
                transaksi_tanggal: dformat,
                transaksi_toko_id: vm.toko_id,
                transaksi_kasir_id: vm.kasir_id,
                transaksi_barang_id: item.Id,
                transaksi_jumlah:1,
                transaksi_harga: item.harga,
                transaksi_pajak:0,
                transaksi_potongan:0,
                transaksi_total: item.harga,
                nama: item.Name
            };
            MergeObjectProperties(foodItem);
        };

        function MergeObjectProperties(obj) {
                var name = obj.transaksi_barang_id;
                var exists = checkProperty(name, vm.order)
                if (exists === false){
                    vm.order.push(obj);
                } else {
                    vm.order[exists]["transaksi_jumlah"] = obj.transaksi_jumlah + vm.order[exists]["transaksi_jumlah"];
                    vm.order[exists]["transaksi_total"] = obj.transaksi_total + vm.order[exists]["transaksi_total"];
                }

            angular.forEach(vm.order,function (v,k) {
                vm.show_delete[k] = false
            });
        }

        function checkProperty(prop, newObj) {
            var result = false;
             newObj.forEach(function (item, key) {
                if (newObj[key]["transaksi_barang_id"] === prop) {
                    result = key
                }
            });
            return result;
        }


        vm.getSum = function () {
            var i = 0,
                sum = 0;
            for (; i < vm.order.length; i++) {
                sum += parseInt(vm.order[i].transaksi_total, 10);
            }
            return sum;
        };

        vm.getSuggestBayar = function() {
          // var sum = vm.getSum();
            // var bayar = 0
            // if(sum < 50000) {
            //     var bayar = 50000;
            //   } else if(sum >= 50000 && sum <= 100000) {
            //     var bayar = 100000;
            //   } else if(sum >= 100000 && sum <= 150000) {
            //     var bayar = 150000;
            //   } else if(sum >= 150000 && sum <= 200000) {
            //     var bayar = 200000;
            //   }
            //
            // vm.bayar = bayar;
            // return bayar;

        };
        vm.deleteItem = function (index) {
            vm.show_delete[index] = false;
            vm.order.splice(index, 1);
        };

        vm.onSwipeLeft = function (index) {
            vm.show_delete[index] = true;
        };

        vm.clickKey = 0;
        vm.bayar_input = 0;
        vm.clickKeyboard = function(number) {
          if(vm.clickKey == 0){
             vm.clickKey = number.toString();
          } else {
            vm.clickKey = vm.clickKey + number.toString();
          }
          vm.bayar_input = parseInt(vm.clickKey);
        };

        vm.clickSuggest = function(bayar) {
          vm.bayar_input += bayar;
        };

        vm.clearBayar = function() {
          vm.clickKey = 0;
          vm.bayar_input = 0;
        };

        vm.showBayar = function() {
          vm.show_bayar = true;
        };

        vm.print = false;
        vm.checkout = function (index) {
          vm.order.forEach(function(item, index){
               var params = {
                invoice: item.transaksi_invoice,
                tanggal: item.transaksi_tanggal,
                toko: item.transaksi_toko_id,
                kasir: item.transaksi_kasir_id,
                barang: item.transaksi_barang_id,
                jumlah:item.transaksi_jumlah,
                harga: item.transaksi_harga,
                pajak:item.transaksi_pajak,
                potongan:item.transaksi_potongan,
                total: item.transaksi_total
             };

            PosServices.transaksi(params).then(function(response){
             if(response.status == 200){
                vm.print = true;
              }
            }, function(error){
               alert(error)
            })
          });
            var kembalian = vm.bayar_input - vm.getSum();
            alert("Total Kembalian : Rp. " + kembalian);
            print()

        };

        function print() {
          var params = {
            invoice:vm.invoice
          };
          PosServices.print(params).then(function(response){
              if(response.status == 200){
                 $state.go('home',{name: vm.kasir_id},{reload:true})
              }
            }, function(error){
               alert(error)
            })
        }

        vm.clearOrder = function () {
            vm.order = [];
        };

        vm.back = function () {
            vm.order = [];
            vm.show_bayar = false;
        };

    }
})();
