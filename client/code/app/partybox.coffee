window.onYouTubePlayerReady = ->
  console.log "Youtube player ready"
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")
  console.log "Loading video"

window.getTemplate = (name) ->
  $("#tmpl-#{name}").html()


angular.module('partybox', [])
  .config(['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when('/', { template: getTemplate("home"), controller: HomeCtrl })
      .when('/player', { template: getTemplate("party-player"), controller: PartyBoxCtrl })
      .otherwise({ redirectTo: '/404' })
   ])

window.HomeCtrl = ($scope, $routeParams) ->
  console.log "HomeCtrl!", $scope, $routeParams

window.PartyBoxCtrl = ($scope, $routeParams) ->
  console.log "PartyBoxCtrl!", $scope, $routeParams
