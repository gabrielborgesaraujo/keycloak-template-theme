<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("updatePasswordTitle")}</h1>
                <p>${msg("updatePasswordTitle")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Update Password Form -->
            <form id="kc-form-update-password" class="kc-form" action="${url.loginAction}" method="post">
                <!-- New Password -->
                <div class="kc-form-group">
                    <label for="password-new" class="kc-label">${msg("passwordNew")}</label>
                    <div class="relative">
                        <input type="password" id="password-new" name="password-new" class="kc-input <#if messagesPerField.existsError('password','password-confirm')>kc-input-error</#if>" autocomplete="new-password" autofocus aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"/>
                        <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700" data-target="password-new" aria-label="${msg("showPassword")}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                        </button>
                    </div>
                    <#if messagesPerField.existsError('password')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Confirm Password -->
                <div class="kc-form-group">
                    <label for="password-confirm" class="kc-label">${msg("passwordConfirm")}</label>
                    <div class="relative">
                        <input type="password" id="password-confirm" name="password-confirm" class="kc-input <#if messagesPerField.existsError('password-confirm')>kc-input-error</#if>" autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"/>
                        <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700" data-target="password-confirm" aria-label="${msg("showPassword")}">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                        </button>
                    </div>
                    <#if messagesPerField.existsError('password-confirm')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
