<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${msg("registerTitle")}
        </#if>
    <#elseif section = "form">
        <form id="kc-register-form" class="kc-form" action="${url.registrationAction}" method="post">
            <@userProfileCommons.userProfileFormFields; callback, attribute>
                <#if callback = "afterField">
                    <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                        <div class="kc-form-group">
                            <label for="password" class="kc-label">${msg("password")} *</label>
                            <div class="relative">
                                <input type="password" id="password" class="kc-input <#if messagesPerField.existsError('password','password-confirm')>kc-input-error</#if>" name="password" autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true<#else>false</#if>" dir="ltr" />
                                <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 transition hover:text-gray-700" data-target="password" aria-label="${msg('showPassword')}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                </button>
                            </div>
                            <#if messagesPerField.existsError('password')>
                                <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                            </#if>
                        </div>

                        <div class="kc-form-group">
                            <label for="password-confirm" class="kc-label">${msg("passwordConfirm")} *</label>
                            <div class="relative">
                                <input type="password" id="password-confirm" class="kc-input <#if messagesPerField.existsError('password-confirm')>kc-input-error</#if>" name="password-confirm" autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password-confirm')>true<#else>false</#if>" dir="ltr" />
                                <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 transition hover:text-gray-700" data-target="password-confirm" aria-label="${msg('showPassword')}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                </button>
                            </div>
                            <#if messagesPerField.existsError('password-confirm')>
                                <span class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                            </#if>
                        </div>
                    </#if>
                </#if>
            </@userProfileCommons.userProfileFormFields>

            <#if termsAcceptanceRequired??>
                <div class="kc-form-group rounded-xl border border-gray-200 bg-gray-50 p-4">
                    <p class="mb-3 text-sm font-semibold text-gray-800">${msg("termsTitle")}</p>
                    <div class="text-sm text-gray-600">${kcSanitize(msg("termsText"))?no_esc}</div>
                </div>
                <div class="kc-form-group">
                    <label class="flex items-start gap-3 text-sm text-gray-700" for="termsAccepted">
                        <input type="checkbox" id="termsAccepted" name="termsAccepted" class="kc-checkbox mt-1" aria-invalid="<#if messagesPerField.existsError('termsAccepted')>true<#else>false</#if>" />
                        <span>${msg("acceptTerms")}</span>
                    </label>
                    <#if messagesPerField.existsError('termsAccepted')>
                        <span class="mt-2 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('termsAccepted'))?no_esc}</span>
                    </#if>
                </div>
            </#if>

            <#if recaptchaRequired?? && (recaptchaVisible!false)>
                <div class="kc-form-group">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}" data-action="${recaptchaAction}"></div>
                </div>
            </#if>

            <div class="kc-page-actions">
                <div class="flex justify-between gap-4 text-sm">
                    <a class="kc-link" href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>

                <#if recaptchaRequired?? && !(recaptchaVisible!false)>
                    <script>
                        function onSubmitRecaptcha(token) {
                            document.getElementById("kc-register-form").requestSubmit();
                        }
                    </script>
                    <button class="kc-btn kc-btn-primary g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-callback="onSubmitRecaptcha" data-action="${recaptchaAction}" type="submit">${msg("doRegister")}</button>
                <#else>
                    <button class="kc-btn kc-btn-primary" type="submit">${msg("doRegister")}</button>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
