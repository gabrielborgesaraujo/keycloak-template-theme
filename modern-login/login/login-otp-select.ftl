<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginChooseAuthenticatorTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("loginChooseAuthenticatorTitle")}</h1>
                <p>${msg("loginChooseAuthenticatorInstruction")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Authenticator Selection -->
            <div class="space-y-3">
                <#if otpPossible??>
                    <form action="${url.loginAction}" method="post">
                        <button class="kc-btn kc-btn-secondary w-full" type="submit" name="try-AnotherWay" value="on">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline-block mr-2"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"/><line x1="12" y1="18" x2="12.01" y2="18"/></svg>
                            ${msg("loginOtpSelectionTitle")}
                        </button>
                    </form>
                </#if>

                <#if webAuthnPossible??>
                    <form action="${url.loginAction}" method="post">
                        <button class="kc-btn kc-btn-secondary w-full" type="submit" name="try-AnotherWay" value="on">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline-block mr-2"><path d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2 2 4 2 4 2-2 2-4z"/><path d="M6.5 19h11"/><path d="M22 11c0 4.97-4.03 9-9 9s-9-4.03-9-9 4.03-9 9-9 9 4.03 9 9z"/></svg>
                            ${msg("webauthn-login-title")}
                        </button>
                    </form>
                </#if>

                <#if recoveryAuthnCodesPossible??>
                    <form action="${url.loginAction}" method="post">
                        <button class="kc-btn kc-btn-secondary w-full" type="submit" name="try-AnotherWay" value="on">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline-block mr-2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
                            ${msg("recoveryCodesAuthenticatorTitle")}
                        </button>
                    </form>
                </#if>
            </div>

            <!-- Back to login -->
            <div class="mt-6 text-center">
                <a class="kc-link text-sm" href="${url.loginUrl}">${msg("backToLogin")}</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
