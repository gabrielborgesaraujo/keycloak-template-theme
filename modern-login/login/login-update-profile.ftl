<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("loginProfileTitle")}</h1>
                <p>${msg("loginProfileInstruction")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Profile Update Form -->
            <form id="kc-form-update-profile" class="kc-form" action="${url.loginAction}" method="post">
                <!-- Email -->
                <div class="kc-form-group">
                    <label for="email" class="kc-label">${msg("email")}</label>
                    <input type="email" id="email" name="email" class="kc-input <#if messagesPerField.existsError('email')>kc-input-error</#if>" value="${(user.email!'')}" autocomplete="email" aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"/>
                    <#if messagesPerField.existsError('email')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
                    </#if>
                </div>

                <!-- First Name -->
                <div class="kc-form-group">
                    <label for="firstName" class="kc-label">${msg("firstName")}</label>
                    <input type="text" id="firstName" name="firstName" class="kc-input <#if messagesPerField.existsError('firstName')>kc-input-error</#if>" value="${(user.firstName!'')}" autocomplete="given-name" aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"/>
                    <#if messagesPerField.existsError('firstName')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Last Name -->
                <div class="kc-form-group">
                    <label for="lastName" class="kc-label">${msg("lastName")}</label>
                    <input type="text" id="lastName" name="lastName" class="kc-input <#if messagesPerField.existsError('lastName')>kc-input-error</#if>" value="${(user.lastName!'')}" autocomplete="family-name" aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"/>
                    <#if messagesPerField.existsError('lastName')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
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
