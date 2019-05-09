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
        <li><a href="/z#!/dash">{{'DASHBOARD.TITLE' | translate}}</a></li>
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
              <p>{{$root.currentUser.username.split('@')[0]}}</p>
              <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right"
                uib-dropdown-menu role="menu" aria-labelledby="single-button">
              <li role="menuitem"><a ui-sref="help">{{'HELP_FAQ' | translate}}</a></li>
              <li class="divider"></li>
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
