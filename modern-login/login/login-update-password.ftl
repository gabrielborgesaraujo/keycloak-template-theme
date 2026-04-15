<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <form id="kc-passwd-update-form" class="kc-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="kc-form-group">
                <label for="password-new" class="kc-label">${msg("passwordNew")}</label>
                <div class="relative">
                    <input type="password" id="password-new" name="password-new" class="kc-input <#if messagesPerField.existsError('password','password-confirm')>kc-input-error</#if>" autofocus autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true<#else>false</#if>" dir="ltr" />
                    <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 transition hover:text-gray-700" data-target="password-new" aria-label="${msg('showPassword')}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                    </button>
                </div>
                <#if messagesPerField.existsError('password')>
                    <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-form-group">
                <label for="password-confirm" class="kc-label">${msg("passwordConfirm")}</label>
                <div class="relative">
                    <input type="password" id="password-confirm" name="password-confirm" class="kc-input <#if messagesPerField.existsError('password-confirm')>kc-input-error</#if>" autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password-confirm')>true<#else>false</#if>" dir="ltr" />
                    <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 transition hover:text-gray-700" data-target="password-confirm" aria-label="${msg('showPassword')}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                    </button>
                </div>
                <#if messagesPerField.existsError('password-confirm')>
                    <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                </#if>
            </div>

            <div class="kc-form-group">
                <label class="flex items-center gap-3 text-sm text-gray-700" for="logout-sessions">
                    <input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked class="kc-checkbox" />
                    <span>${msg("logoutOtherSessions")}</span>
                </label>
            </div>

            <div class="kc-page-actions">
                <#if isAppInitiatedAction??>
                    <div class="kc-inline-actions">
                        <input name="login" class="kc-btn kc-btn-primary sm:w-auto" type="submit" value="${msg('doSubmit')}" />
                        <button class="kc-btn kc-btn-secondary sm:w-auto" type="submit" name="cancel-aia" value="true">${msg("doCancel")}</button>
                    </div>
                <#else>
                    <input name="login" class="kc-btn kc-btn-primary" type="submit" value="${msg('doSubmit')}" />
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
