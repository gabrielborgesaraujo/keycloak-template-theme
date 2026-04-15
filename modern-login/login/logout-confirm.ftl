<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div class="space-y-4">
            <div class="kc-alert kc-alert-info">
                ${msg("logoutConfirmHeader")}
            </div>
            <form class="kc-form" action="${url.logoutConfirmAction}" onsubmit="confirmLogout.disabled = true; return true;" method="POST">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                <button class="kc-btn kc-btn-primary" name="confirmLogout" id="kc-logout" type="submit">${msg("doLogout")}</button>
            </form>
            <#if !logoutConfirm.skipLink && (client.baseUrl)?has_content>
                <a class="kc-link text-sm" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
