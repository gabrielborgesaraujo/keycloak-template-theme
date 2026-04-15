<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginOtpSelectionTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("loginOtpSelectionTitle")}</h1>
                <p>${msg("loginOtpSelectionInstruction")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- OTP Selection Form -->
            <form id="kc-form-otp-selection" class="kc-form" action="${url.loginAction}" method="post">
                <!-- OTP Input -->
                <div class="kc-form-group">
                    <label for="otp" class="kc-label">${msg("loginOtpInput")}</label>
                    <input type="text" id="otp" name="otp" class="kc-input kc-code-input <#if messagesPerField.existsError('otp')>kc-input-error</#if>" autocomplete="one-time-code" autofocus aria-invalid="<#if messagesPerField.existsError('otp')>true</#if>" placeholder="000000" maxlength="6" pattern="[0-9]{6}"/>
                    <#if messagesPerField.existsError('otp')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('otp'))?no_esc}</span>
                    </#if>
                    <p class="text-xs text-gray-500 mt-2">${msg("loginOtpManual")}</p>
                </div>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </form>

            <!-- Alternative methods -->
            <div class="mt-6 text-center">
                <#if otpCredentials??>
                    <#list otpCredentials as credential>
                        <form action="${url.loginAction}" method="post" class="mb-3">
                            <input type="hidden" name="credentialId" value="${credential.credentialId}"/>
                            <button class="kc-btn kc-btn-secondary" type="submit" name="try-AnotherWay" value="on">
                                ${msg("doTryAnotherWay")}
                            </button>
                        </form>
                    </#list>
                </#if>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
