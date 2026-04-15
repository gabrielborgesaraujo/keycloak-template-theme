<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('recoveryCodeInput'); section>
    <#if section = "header">
        ${msg("auth-recovery-code-header")}
    <#elseif section = "form">
        <form id="kc-recovery-code-login-form" class="kc-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="kc-form-group">
                <label for="recoveryCodeInput" class="kc-label">${msg("auth-recovery-code-prompt", recoveryAuthnCodesInputBean.codeNumber?c)}</label>
                <input tabindex="1" id="recoveryCodeInput" name="recoveryCodeInput" autocomplete="off" type="text" class="kc-input <#if messagesPerField.existsError('recoveryCodeInput')>kc-input-error</#if>" autofocus aria-invalid="<#if messagesPerField.existsError('recoveryCodeInput')>true<#else>false</#if>" dir="ltr" />
                <#if messagesPerField.existsError('recoveryCodeInput')>
                    <span id="input-error" class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('recoveryCodeInput'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-form-group">
                <input class="kc-btn kc-btn-primary" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
