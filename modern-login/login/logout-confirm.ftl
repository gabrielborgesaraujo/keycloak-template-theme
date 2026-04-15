<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("logoutConfirmTitle")}</h1>
                <p>${msg("logoutConfirmTitle")}</p>
            </div>

            <!-- Confirmation message -->
            <div class="kc-alert-info" role="alert">
                ${msg("logoutConfirmDefault")}
            </div>

            <!-- Logout form -->
            <form action="${url.logoutConfirmAction}" method="post">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                <div class="mt-6">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doLogout")}
                    </button>
                </div>
            </form>

            <!-- Cancel link -->
            <div class="mt-4 text-center">
                <a class="kc-link" href="${url.logoutConfirmAction}?session_code=${logoutConfirm.code}&confirm=cancel">
                    ${msg("doCancel")}
                </a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
