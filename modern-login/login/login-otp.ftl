<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <form id="kc-otp-login-form" class="kc-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="kc-form-group">
                    <p class="kc-label">${msg("loginChooseAuthenticator")}</p>
                    <div class="space-y-3">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <label class="flex items-center gap-3 rounded-lg border border-gray-200 px-4 py-3 text-sm text-gray-700" for="kc-otp-credential-${otpCredential?index}">
                                <input id="kc-otp-credential-${otpCredential?index}" class="kc-checkbox" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                                <span>${otpCredential.userLabel}</span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <div class="kc-form-group">
                <label for="otp" class="kc-label">${msg("loginOtpOneTime")}</label>
                <input id="otp" name="otp" autocomplete="one-time-code" type="text" class="kc-input kc-code-input <#if messagesPerField.existsError('totp')>kc-input-error</#if>" autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true<#else>false</#if>" dir="ltr" />
                <#if messagesPerField.existsError('totp')>
                    <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('totp'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-form-group">
                <input class="kc-btn kc-btn-primary" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
