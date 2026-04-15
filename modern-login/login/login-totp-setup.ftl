<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginTotpConfigure")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("loginTotpConfigure")}</h1>
                <p>${msg("loginTotpStep1")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- QR Code -->
            <#if totpSecret?? && totpSecret.totpSecretEncodedUrl??>
                <div class="text-center mb-6">
                    <img src="data:image/png;base64,${totpSecret.totpSecretQrCode}" alt="QR Code" class="mx-auto max-w-xs border-2 border-gray-200 rounded-lg"/>
                    <p class="text-sm text-gray-600 mt-3">${msg("loginTotpScan")}</p>
                </div>
            </#if>

            <!-- Manual secret key -->
            <div class="mb-6 p-4 bg-gray-50 rounded-lg">
                <p class="text-sm text-gray-700 mb-2">${msg("loginTotpManual")}</p>
                <code class="block p-3 bg-white border border-gray-300 rounded text-sm font-mono break-all">${totpSecret.totpSecret}</code>
            </div>

            <!-- TOTP Setup Form -->
            <form id="kc-form-totp-setup" class="kc-form" action="${url.loginAction}" method="post">
                <!-- OTP Input -->
                <div class="kc-form-group">
                    <label for="totp" class="kc-label">${msg("loginTotp")}</label>
                    <input type="text" id="totp" name="totp" class="kc-input kc-code-input <#if messagesPerField.existsError('totp')>kc-input-error</#if>" autocomplete="one-time-code" autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" placeholder="000000" maxlength="6" pattern="[0-9]{6}"/>
                    <#if messagesPerField.existsError('totp')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('totp'))?no_esc}</span>
                    </#if>
                </div>

                <!-- User Label -->
                <div class="kc-form-group">
                    <label for="totp-label" class="kc-label">${msg("loginTotpDeviceName")}</label>
                    <input type="text" id="totp-label" name="userLabel" class="kc-input" placeholder="${msg('loginTotpDeviceNamePlaceholder')}" autocomplete="off"/>
                    <p class="text-xs text-gray-500 mt-1">${msg("loginTotpDeviceNameInstruction")}</p>
                </div>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </form>

            <!-- Skip for now (if allowed) -->
            <#if isAppInitiatedAction?? && isAppInitiatedAction>
                <div class="mt-6 text-center">
                    <form action="${url.loginAction}" method="post">
                        <button class="kc-btn kc-btn-secondary" type="submit" name="cancel-aia" value="true">
                            ${msg("doCancel")}
                        </button>
                    </form>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
