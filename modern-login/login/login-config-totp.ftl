<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol class="mb-6 space-y-5 text-sm text-gray-700">
            <li>
                <p class="font-medium text-gray-900">${msg("loginTotpStep1")}</p>
                <ul class="kc-help-list mt-3">
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p class="font-medium text-gray-900">${msg("loginTotpManualStep2")}</p>
                    <p class="mt-3 rounded-lg border border-gray-200 bg-gray-50 px-4 py-3 font-mono text-sm text-gray-800" id="kc-totp-secret-key">${totp.totpSecretEncoded}</p>
                    <p class="mt-3"><a class="kc-link" href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p class="font-medium text-gray-900">${msg("loginTotpManualStep3")}</p>
                    <ul class="kc-help-list mt-3">
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                </li>
            <#else>
                <li>
                    <p class="font-medium text-gray-900">${msg("loginTotpStep2")}</p>
                    <div class="mt-3 rounded-xl border border-gray-200 bg-gray-50 p-4 text-center">
                        <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Barcode" class="mx-auto max-w-xs" />
                    </div>
                    <p class="mt-3"><a class="kc-link" href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>

            <li>
                <p class="font-medium text-gray-900">${msg("loginTotpStep3")}</p>
                <p class="kc-secondary-text mt-2">${msg("loginTotpStep3DeviceName")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" class="kc-form" id="kc-totp-settings-form" method="post">
            <div class="kc-form-group">
                <label for="totp" class="kc-label">${msg("authenticatorCode")} *</label>
                <input type="text" id="totp" name="totp" autocomplete="off" class="kc-input kc-code-input <#if messagesPerField.existsError('totp')>kc-input-error</#if>" aria-invalid="<#if messagesPerField.existsError('totp')>true<#else>false</#if>" dir="ltr" />
                <#if messagesPerField.existsError('totp')>
                    <span id="input-error-otp-code" class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('totp'))?no_esc}</span>
                </#if>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>

            <div class="kc-form-group">
                <label for="userLabel" class="kc-label">${msg("loginTotpDeviceName")} <#if totp.otpCredentials?size gte 1>*</#if></label>
                <input type="text" class="kc-input <#if messagesPerField.existsError('userLabel')>kc-input-error</#if>" id="userLabel" name="userLabel" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('userLabel')>true<#else>false</#if>" dir="ltr" />
                <#if messagesPerField.existsError('userLabel')>
                    <span id="input-error-otp-label" class="mt-1 block text-sm text-red-600" aria-live="polite">${kcSanitize(messagesPerField.get('userLabel'))?no_esc}</span>
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
                        <input type="submit" class="kc-btn kc-btn-primary sm:w-auto" id="saveTOTPBtn" value="${msg('doSubmit')}" />
                        <button type="submit" class="kc-btn kc-btn-secondary sm:w-auto" id="cancelTOTPBtn" name="cancel-aia" value="true">${msg("doCancel")}</button>
                    </div>
                <#else>
                    <input type="submit" class="kc-btn kc-btn-primary" id="saveTOTPBtn" value="${msg('doSubmit')}" />
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
