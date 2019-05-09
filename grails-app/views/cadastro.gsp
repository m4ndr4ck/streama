<%@ page import="grails.converters.JSON" %>
<%@ page import="streama.Settings" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <title>${Settings.findByName('title').value}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <style type="text/css">
  [ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
    display: none !important;
  }
  </style>

  <asset:stylesheet src="vendor.css"/>
  <asset:stylesheet src="application.css"/>

  <g:linkRelIconSetting setting="${Settings.findByName('favicon').value}"></g:linkRelIconSetting>

  <script type="text/javascript">
    window.contextPath = "${request.contextPath}";
  </script>
</head>

<body ng-app="streama.auth" >
<g:cssBackgroundSetting selector=".login-page" setting="${Settings.findByName('loginBackground').value}"></g:cssBackgroundSetting>
<div class="page-container login-page">
  <div id='login' class="ng-cloak">
    <g:imgSetting class="auth-logo"  setting="${Settings.findByName('logo').value}" alt="${streama.Settings.findByName('title').value} Logo"></g:imgSetting>
    <div class='inner'>

      <g:if test='${flash.message}'>
        <div class='login_message'>${flash.message}</div>
      </g:if>

      <form  id='loginForm' class='cssform form-horizontal' ng-controller="authController"  ng-submit="signup()" autocomplete='off'>

        <div class="form-group">
          <div class="col-lg-12">
            <input type="text" name="username" ng-model="email" class="form-control" placeholder="{{'CADASTRO.EMAIL' | translate}}">
          </div>
        </div>

        <div class="form-group">
          <div class="col-lg-12">
            <input type="password" name='password' ng-model="password" class="form-control" placeholder="{{'CADASTRO.PASS' | translate}}">
          </div>
        </div>

        <div class="form-group">
          <div class="col-lg-12">
            <input type="password" name="password_confirm" ng-model="password_confirm" name='password_confirm' class="form-control" placeholder="{{'CADASTRO.REPEAT_PASS' | translate}}">
          </div>
        </div>
        <span>
          <g:if test="${streama.Settings.findBySettingsKey('First Time Login Info')?.value == 'true'}">
            {{'LOGIN.FIRST_TIME_HINT' | translate}}
          </g:if>
          <input style="display: none;" type='checkbox' name='remember_me' id='remember_me' checked='checked'/>

          <button type="submit" class="btn btn-primary pull-right">{{'CADASTRO.SUBMIT' | translate}} &nbsp; <i class="ion-chevron-right"></i></button></span>
      </form>
    </div>
  </div>
  <div class="page-container-push"></div>
</div>

<g:render template="/templates/footer"></g:render>


<asset:javascript src="vendor.js" />
<asset:javascript src="/streama/streama.translations.js" />

<script type='text/javascript'>
  <!--



  var headers = new Headers({
    "Content-Type": "application/json",
    "Accept": "application/json"
  });

  angular.module('streama.auth', ['streama.translations', 'LocalStorageModule']);

  angular.module('streama.auth').controller('authController', function ($scope, $location, $window, $http) {
    $scope.signup = function() {
      $http({
        method: 'POST',
        url: '/cadastro/createUser',
        headers: headers,
        data: {
          username: $scope.email,
          password: $scope.password,
          password_confirm: $scope.password_confirm,
        }
      }).then(function successCallback(response) {
        console.log($scope.email);
        console.log(response);
        window.location.href = '/z#!/dash';
        // console.log(response.data[0].key);
        // console.log(response.data[0].tkTextValues[0].text);
        // console.log(response.data.length)
      }, function errorCallback(response) {
        console.log('error');
      });
    }
  })
  // -->
</script>


<g:googleAnalytics/>

</body>
</html>
