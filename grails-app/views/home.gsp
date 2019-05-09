<%@ page import="streama.Settings" %>
<!doctype html>
<html lang="en" class="no-js" ng-app="streama">
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

  </script>

</head>

<body class="ng-cloak" style="background-image: url('/assets/bg_index2.jpg')">
<div class="page-container">
    <g:render template="/templates/header_simple"></g:render>


  <div class="content ng-cloak">
  <div style=" padding-top: 200px; text-align: center; margin: auto; font-size: 34px; max-width: 40%; font-weight: 700; ">
    <div>Assista ao melhor do terror sobrenatural, gore, psicológico, clássico e muito mais.</div>

    <div class="btn-group" style="margin: 0px 0;padding-top: 40px;">
      <button class="btn btn-primary pull-right ng-binding" onclick="location.href='/cadastro'" style="
      font-size: 25px;">
        ASSISTIR AGORA
      </button>
    </div>
  </div>
    <ui-view/>
  </div>

  <div class="page-container-push"></div>
</div>

<g:render template="/templates/footer"></g:render>

<asset:javascript src="vendor.js" />
<asset:javascript src="streama/streama.js" />

<g:googleAnalytics/>
</body>
</html>
