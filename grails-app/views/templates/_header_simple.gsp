<%@ page import="streama.Settings" %>
<header class="main" ng-if="!isCurrentState('player')">
  <div class="pull-left flex">
    <a class="logo" ui-sref="dash">
      <g:imgSetting setting="${Settings.findByName('logo').value}" alt="${streama.Settings.findByName('title').value} Logo"></g:imgSetting>
    </a>
  </div>

  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    <ul class="nav navbar-nav">

      <sec:ifLoggedIn>
      <li>
        <div class="dash-search form-group has-feedback">
          <input type="text" placeholder="Buscar.." class="form-control input-xs" ng-model="dashSearch"
                 typeahead-append-to-body="true" uib-typeahead="(item.title || item.name) for item in searchMedia($viewValue)"
                 typeahead-on-select="selectFromSearch($item)" typeahead-template-url="/streama/typeahead--media.htm" typeahead-loading="baseData.loading"/>
          <span class="form-control-feedback ion-android-search" aria-hidden="true"></span>
        </div>
      </li>
      </sec:ifLoggedIn>

      <sec:ifLoggedIn>
        <li><a ui-sref="dash">{{'DASHBOARD.TITLE' | translate}}</a></li>
      </sec:ifLoggedIn>

      <sec:ifAnyGranted roles="ROLE_CONTENT_MANAGER">
        <li><a ui-sref="admin.shows">{{'MANAGE_CONTENT' | translate}}</a></li>
      </sec:ifAnyGranted>

      <sec:ifAnyGranted roles="ROLE_ADMIN">
        <li><a ui-sref="settings.settings">{{'ADMIN' | translate}}</a></li>
      </sec:ifAnyGranted>

      <sec:ifNotLoggedIn>
        <li>
          <div class="btn-group" style="margin: 0px 0;">
            <button class="btn btn-primary pull-right" ng-click="loginUser()">{{'Entrar' | translate}}</button>
          </div>
        </li>
      </sec:ifNotLoggedIn>

      <sec:ifLoggedIn>
        <li>
          <div class="btn-group" uib-dropdown is-open="status.isopen" style="margin: 4px 0;">
            <button id="single-button" type="button" class="btn btn-primary btn-sm header-btn profile-select-dropdown"
                    uib-dropdown-toggle ng-disabled="disabled">
              <div class="avatar-in-header" ng-style="{'background-color': '#'+($root.currentProfile.avatarColor || 'AB682B')}">
                <img src="/assets/streama-profile-smiley.png" alt="">
              </div>
              <p>{{$root.currentProfile.profileName || $root.currentUser.fullName || $root.currentUser.username}}</p>
              <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right"
                uib-dropdown-menu role="menu" aria-labelledby="single-button">
              <li role="menuitem" class="header-profile-item" ng-repeat="prof in $root.usersProfiles" ng-click="$root.setCurrentSubProfile(prof)">
                <div class="avatar-in-header" ng-style="{'background-color': '#'+(prof.avatarColor || 'AB682B')}">
                  <img src="/assets/streama-profile-smiley.png" alt="">
                </div>
                <a>{{prof.profileName}}</a>
              </li>
              <li class="divider"></li>
              <li role="menuitem">
                <a ui-sref="sub-profiles">{{'MANAGE_SUB_PROFILES' | translate}}</a>
              </li>
              <li class="divider"></li>
              <li role="menuitem"><a ui-sref="help">{{'HELP_FAQ' | translate}}</a></li>
              <li role="menuitem"><a ui-sref="userSettings">{{'PROFILE_SETTINGS' | translate}}</a></li>
              <li class="divider"></li>
              <li><g:link uri="/logoff">{{'Sair' | translate}}</g:link></li>
            </ul>
          </div>
        </li>
      </sec:ifLoggedIn>

    </ul>
  </div>

  <i class="ion-navicon navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"></i>
</header>
