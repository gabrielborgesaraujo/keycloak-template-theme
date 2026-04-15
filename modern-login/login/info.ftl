<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
        <div class="space-y-4">
            <div class="kc-alert kc-alert-info">
                <p>${kcSanitize(message.summary)?no_esc}<#if requiredActions??><#list requiredActions>: <strong><#items as reqActionItem>${kcSanitize(msg("requiredAction.${reqActionItem}"))?no_esc}<#sep>, </#items></strong></#list></#if></p>
            </div>
            <#if !skipLink??>
                <div class="flex flex-wrap gap-4 text-sm">
                    <#if pageRedirectUri?has_content>
                        <a class="kc-link" href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                    <#elseif actionUri?has_content>
                        <a class="kc-link" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a>
                    <#elseif client?? && client.baseUrl?has_content>
                        <a class="kc-link" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                    </#if>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
