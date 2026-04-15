<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <#if message??>
            ${message.summary}
        <#else>
            ${msg("infoTitle")}
        </#if>
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>
                    <#if message??>
                        ${message.summary}
                    <#else>
                        ${msg("infoTitle")}
                    </#if>
                </h1>
            </div>

            <!-- Info message -->
            <#if message??>
                <div class="kc-alert-info" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Required actions -->
            <#if requiredActions?? && requiredActions?has_content>
                <div class="mt-6">
                    <p class="text-sm font-medium text-gray-700 mb-3">${msg("requiredActions")}</p>
                    <ul class="space-y-2">
                        <#list requiredActions as action>
                            <li class="text-sm text-gray-600">${action}</li>
                        </#list>
                    </ul>
                </div>
            </#if>

            <!-- Action buttons -->
            <#if actionUri??>
                <div class="mt-6">
                    <a href="${actionUri}" class="kc-btn kc-btn-primary">
                        ${msg("proceed")}
                    </a>
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
        </div>
    </#if>
</@layout.registrationLayout>
