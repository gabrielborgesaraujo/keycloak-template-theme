<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("loginTotpTitle")}</h1>
                <p>${msg("loginTotpStep2")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- TOTP Form -->
            <form id="kc-form-totp" class="kc-form" action="${url.loginAction}" method="post">
                <!-- OTP Input -->
                <div class="kc-form-group">
                    <label for="totp" class="kc-label">${msg("loginTotp")}</label>
                    <input type="text" id="totp" name="totp" class="kc-input kc-code-input <#if messagesPerField.existsError('totp')>kc-input-error</#if>" autocomplete="one-time-code" autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" placeholder="000000" maxlength="6" pattern="[0-9]{6}"/>
                    <#if messagesPerField.existsError('totp')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('totp'))?no_esc}</span>
                    </#if>
                    <p class="text-xs text-gray-500 mt-2">${msg("loginTotpManual")}</p>
                </div>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </form>

            <!-- Alternative methods -->
            <#if authenticationSession??>
                <div class="mt-6 text-center">
                    <#if authenticationSession.authSessionNotes??>
                        <#if authenticationSession.authSessionNotes['skipTotp']??>
                            <p class="text-sm text-gray-600">
                                ${msg("doTryAgain")}
                            </p>
                        </#if>
                    </#if>
                </div>
            </#if>
        </div>
    <#elseif section = "info">
        <div class="text-center text-sm text-gray-600 mt-4">
            <p>${msg("loginTotpStep1")}</p>
            <#if totpSecret?? && totpSecret.totpSecretEncodedUrl??>
                <div class="mt-4">
                    <img src="data:image/png;base64,${totpSecret.totpSecretQrCode}" alt="QR Code" class="mx-auto max-w-xs border-2 border-gray-200 rounded-lg"/>
                    <p class="text-xs text-gray-500 mt-2">${msg("loginTotpScan")}</p>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
