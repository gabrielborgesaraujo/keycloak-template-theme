<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("emailForgotTitle")}</h1>
                <p>${msg("emailInstruction")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Reset Password Form -->
            <form id="kc-form-reset-password" class="kc-form" action="${url.loginAction}" method="post">
                <!-- Email/Username -->
                <div class="kc-form-group">
                    <label for="username" class="kc-label">
                        <#if !realm.loginWithEmailAllowed>${msg("username")}
                        <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                        <#else>${msg("email")}</#if>
                    </label>
                    <input type="text" id="username" name="username" class="kc-input <#if messagesPerField.existsError('username')>kc-input-error</#if>" value="${(auth.attemptedUsername!'')}" autofocus autocomplete="email" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                    <#if messagesPerField.existsError('username')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </form>

            <!-- Back to Login -->
            <div class="kc-footer">
                <p class="text-gray-600">
                    <a class="kc-link" href="${url.loginUrl}">← ${msg("backToLogin")}</a>
                </p>
            </div>
        </div>
    <#elseif section = "info">
        <div class="text-center text-sm text-gray-600 mt-4">
            ${msg("emailInstruction")}
        </div>
    </#if>
</@layout.registrationLayout>
