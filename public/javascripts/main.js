app = angular.module("nomnom", [])


function awesomeCtrl($scope) {

  $scope.cats = [{name: "Dobby", color:"red"}, 
            {name: "Tiger Cat", color: "black"}, 
            {name: "Battle Cat", color: "green"}];


  $scope.updateStuff = function(){
    alert($scope.stuff);
  };
}