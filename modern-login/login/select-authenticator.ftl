<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header" || section = "show-username">
        <#if section = "header">
            ${msg("loginChooseAuthenticator")}
        </#if>
    <#elseif section = "form">
        <form id="kc-select-credential-form" class="kc-form" action="${url.loginAction}" method="post">
            <div class="kc-selection-list">
                <#list auth.authenticationSelections as authenticationSelection>
                    <button class="kc-selection-item" type="submit" name="authenticationExecution" value="${authenticationSelection.authExecId}">
                        <div class="kc-selection-icon">
                            <i class="${authenticationSelection.iconCssClass!''}" aria-hidden="true"></i>
                        </div>
                        <div class="min-w-0 flex-1">
                            <div class="font-semibold text-gray-900">${msg('${authenticationSelection.displayName}')}</div>
                            <div class="mt-1 text-sm text-gray-600">${msg('${authenticationSelection.helpText}')}</div>
                        </div>
                        <span class="text-primary-600">&rsaquo;</span>
                    </button>
                </#list>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
