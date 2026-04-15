<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if message??>
            ${message.summary}
        <#else>
            ${msg("errorTitle")}
        </#if>
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>
                    <#if message??>
                        ${message.summary}
                    <#else>
                        ${msg("errorTitle")}
                    </#if>
                </h1>
            </div>

            <!-- Error details -->
            <#if message??>
                <div class="kc-alert-error" role="alert">
                    <div class="font-semibold mb-2">${msg("error")}</div>
                    <div>${message.summary}</div>
                    <#if message.type??>
                        <div class="text-sm mt-2 text-gray-600">Type: ${message.type}</div>
                    </#if>
                </div>
            </#if>

            <#if skipLink??>
                <#else>
                    <#if client?? && client.baseUrl??>
                        <div class="mt-6 text-center">
                            <a class="kc-link" href="${client.baseUrl}">${msg("backToApplication")}</a>
                        </div>
                    </#if>
            </#if>

            <!-- Back to login -->
            <#if !skipLink??>
                <div class="mt-6 text-center">
                    <a class="kc-link" href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
