<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <form id="kc-form-login" class="kc-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="kc-form-group border-t border-gray-200 pt-4">
                <label for="password" class="kc-label">${msg("password")}</label>
                <div class="relative">
                    <input tabindex="2" id="password" class="kc-input <#if messagesPerField.existsError('password')>kc-input-error</#if>" name="password" type="password" autocomplete="current-password" autofocus aria-invalid="<#if messagesPerField.existsError('password')>true<#else>false</#if>" dir="ltr" />
                    <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 transition hover:text-gray-700" data-target="password" aria-label="${msg('showPassword')}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                    </button>
                </div>
                <#if messagesPerField.existsError('password')>
                    <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-form-group">
                <div class="flex justify-end">
                    <#if realm.resetPasswordAllowed>
                        <a tabindex="5" class="kc-link text-sm" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </#if>
                </div>
            </div>

            <div class="kc-form-group">
                <button tabindex="4" class="kc-btn kc-btn-primary" name="login" id="kc-login" type="submit">${msg("doLogIn")}</button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
