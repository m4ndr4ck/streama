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

<body >
<g:cssBackgroundSetting selector=".login-page" setting="${Settings.findByName('loginBackground').value}"></g:cssBackgroundSetting>
<div class="page-container login-page">
  <div class="modal-body">
    <form class="form-horizontal">

      <div ng-class="{'has-error has-feedback': error, 'has-success has-feedback': validUser}">
        <label class="control-label" ng-show="error">{{error}}</label>
        <div class="form-group" >
          <div class="col-sm-3">
            <label class="control-label">Username</label>
          </div>
          <div class="col-sm-8">
            <input type="text" class="form-control" ng-model="user.username" placeholder="Username" ng-model-options="{updateOn: 'blur'}" ng-change="checkAvailability(false, user.username)">
            <span class="ion-close form-control-feedback" ng-show="error" aria-hidden="true"></span>
            <span class="ion-checkmark form-control-feedback" ng-show="validUser" aria-hidden="true"></span>
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="col-sm-8 col-sm-offset-3">
          <label> <input type="checkbox" ng-model="user.enabled"/> &nbsp; Enabled (user can log in and view videos)</label>
        </div>
        <div class="col-sm-8 col-sm-offset-3">
          <label> <input type="checkbox" ng-model="user.accountExpired"/> &nbsp; Expire account</label>
        </div>
      </div>
      <!--<div class="form-group">-->
      <!--<div class="col-sm-10 ">-->
      <!--<label> <input type="checkbox" ng-model="user.accountExpired"/> &nbsp; Expire account</label>-->
      <!--</div>-->
      <!--</div>-->
      <div class="form-group">
        <div class="col-sm-3">
          <label class="control-label">Roles</label>
        </div>
        <div class="col-sm-8">
          <div class="form-control" style="height: auto;">
            <div ng-repeat="role in roles">
              <input type="checkbox" name="authorities[]" value="{{role.id}}" ng-checked="checkAuthorities(role.id)" ng-click="toggleAuthorities(role)"> {{role.displayName}}
            </div>
          </div>
        </div>
      </div>

      <div class="form-group" >
        <div class="col-sm-3">
          <label class="control-label">{{'PROFIlE.LANGUAGE' | translate}}</label>
        </div>
        <div class="col-sm-8">
          <select class="form-control" ng-model="user.language" ng-options="lang as ('LANGUAGE_'+lang | translate) for lang in $root.availableLanguages"></select>
        </div>
      </div>

    </form>
  </div>

  <div class="modal-footer">
    <button  class="btn btn-success" ng-disabled="!valid && !user.id" ng-click="saveAndCreateUser(user)">Save & Create User</button>
    <button class="btn btn-success" ng-click="createUser()">Save User</button>
    <button type="button" class="btn btn-danger" ng-click="cancel()">Cancel</button>
  </div>

  <div class="page-container-push"></div>
</div>

<g:render template="/templates/footer"></g:render>


<asset:javascript src="vendor.js" />
<asset:javascript src="/streama/streama.translations.js" />




<g:googleAnalytics/>

</body>
</html>
