<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${kcSanitize(msg("errorTitle"))?no_esc}
    <#elseif section = "form">
        <div class="space-y-4">
            <div class="kc-alert kc-alert-error">
                <p class="font-semibold">${msg("error")}</p>
                <p class="mt-2 text-sm">${kcSanitize(message.summary)?no_esc}</p>
            </div>
            <#if !skipLink??>
                <div class="flex flex-wrap gap-4 text-sm">
                    <#if client?? && client.baseUrl?has_content>
                        <a class="kc-link" id="backToApplication" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
                    </#if>
                    <a class="kc-link" href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
