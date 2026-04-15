<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" class="kc-form" action="${url.loginAction}" method="post">
            <div class="kc-form-group">
                <label for="username" class="kc-label"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <input type="text" id="username" name="username" class="kc-input <#if messagesPerField.existsError('username')>kc-input-error</#if>" autofocus value="${(auth.attemptedUsername!'')}" autocomplete="email" aria-invalid="<#if messagesPerField.existsError('username')>true<#else>false</#if>" dir="ltr" />
                <#if messagesPerField.existsError('username')>
                    <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-page-actions">
                <div class="flex justify-between gap-4 text-sm">
                    <a class="kc-link" href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
                <button class="kc-btn kc-btn-primary" type="submit">${msg("doSubmit")}</button>
            </div>
        </form>
    <#elseif section = "info">
        <#if realm.duplicateEmailsAllowed>
            ${msg("emailInstructionUsername")}
        <#else>
            ${msg("emailInstruction")}
        </#if>
    </#if>
</@layout.registrationLayout>
