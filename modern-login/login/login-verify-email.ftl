<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("emailVerifyTitle")}</h1>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Email verification instruction -->
            <div class="text-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="mx-auto text-primary-600 mb-4">
                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                    <polyline points="22,6 12,13 2,6"></polyline>
                </svg>
                <p class="text-gray-700 mb-4">${msg("emailVerifyInstruction1")}</p>
                <#if user??>
                    <p class="text-sm text-gray-600 mb-4">
                        ${msg("emailVerifyInstruction2", user.email)}
                    </p>
                </#if>
            </div>

            <!-- Resend email form -->
            <form action="${url.loginAction}" method="post" class="mt-6">
                <button class="kc-btn kc-btn-primary" type="submit">
                    ${msg("doResendEmail")}
                </button>
            </form>

            <!-- Back to login -->
            <div class="mt-4 text-center">
                <a class="kc-link text-sm" href="${url.loginUrl}">${msg("backToLogin")}</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
