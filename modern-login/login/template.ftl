<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html class="<#if properties.kcHtmlClass??>${properties.kcHtmlClass}</#if>"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title><#if title??>${title}<#else>${msg("loginTitle", (realm.displayName!''))}</#if></title>

    <#if properties.kcFaviconUrl??>
        <link rel="icon" href="${url.resourcesPath}/${properties.kcFaviconUrl}" type="image/x-icon" />
    </#if>

    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link rel="stylesheet" href="${url.resourcesPath}/${style}">
        </#list>
    </#if>

    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" defer></script>
        </#list>
    </#if>

    <#if properties.import?has_content>
        <#list properties.import?split(' ') as import>
            <#import "${import}" as imported>
        </#list>
    </#if>

    <style>
        /* Inline critical CSS for faster rendering */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
    </style>
</head>

<body class="<#if bodyClass?has_content>${bodyClass}</#if>">
    <div class="min-h-screen flex items-center justify-center p-4">
        <#nested "header">
        <#nested "form">
        <#if displayInfo>
            <#nested "info">
        </#if>
    </div>

    <#if displayInfo>
        <div id="kc-info" class="kc-info">
            <#nested "info">
        </div>
    </#if>

    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" defer></script>
        </#list>
    </#if>
</body>
</html>
</#macro>
