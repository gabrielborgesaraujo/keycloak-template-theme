<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("registerTitle")}</h1>
                <p>${msg("registerTitle")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- Registration Form -->
            <form id="kc-form-register" class="kc-form" action="${url.registrationAction}" method="post">
                <!-- First Name -->
                <div class="kc-form-group">
                    <label for="firstName" class="kc-label">${msg("firstName")}</label>
                    <input type="text" id="firstName" name="firstName" class="kc-input <#if messagesPerField.existsError('firstName')>kc-input-error</#if>" value="${(register.formData.firstName!'')}" autocomplete="given-name" aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"/>
                    <#if messagesPerField.existsError('firstName')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Last Name -->
                <div class="kc-form-group">
                    <label for="lastName" class="kc-label">${msg("lastName")}</label>
                    <input type="text" id="lastName" name="lastName" class="kc-input <#if messagesPerField.existsError('lastName')>kc-input-error</#if>" value="${(register.formData.lastName!'')}" autocomplete="family-name" aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"/>
                    <#if messagesPerField.existsError('lastName')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
                    </#if>
                </div>

                <!-- Email -->
                <div class="kc-form-group">
                    <label for="email" class="kc-label">${msg("email")}</label>
                    <input type="email" id="email" name="email" class="kc-input <#if messagesPerField.existsError('email')>kc-input-error</#if>" value="${(register.formData.email!'')}" autocomplete="email" aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"/>
                    <#if messagesPerField.existsError('email')>
                        <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
                    </#if>
                </div>

                <#if !realm.registrationEmailAsUsername>
                    <!-- Username -->
                    <div class="kc-form-group">
                        <label for="username" class="kc-label">${msg("username")}</label>
                        <input type="text" id="username" name="username" class="kc-input <#if messagesPerField.existsError('username')>kc-input-error</#if>" value="${(register.formData.username!'')}" autocomplete="username" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                        <#if messagesPerField.existsError('username')>
                            <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
                        </#if>
                    </div>
                </#if>

                <!-- Password -->
                <#if passwordRequired??>
                    <div class="kc-form-group">
                        <label for="password" class="kc-label">${msg("password")}</label>
                        <div class="relative">
                            <input type="password" id="password" name="password" class="kc-input <#if messagesPerField.existsError('password')>kc-input-error</#if>" autocomplete="new-password" aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"/>
                            <button type="button" class="kc-password-toggle absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700" data-target="password" aria-label="${msg("showPassword")}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            </button>
                        </div>
                        <#if messagesPerField.existsError('password')>
                            <span class="text-red-600 text-sm mt-1 block">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                        </#if>
                    </div>
                </#if>

                <!-- Password Confirmation -->
                <#if passwordRequired??>
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
                </#if>

                <!-- reCAPTCHA -->
                <#if recaptchaRequired??>
                    <div class="kc-form-group">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </#if>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button class="kc-btn kc-btn-primary" type="submit">
                        ${msg("doRegister")}
                    </button>
                </div>
            </form>

            <!-- Login Link -->
            <div class="kc-footer">
                <p class="text-gray-600">
                    ${msg("alreadyHaveAccount")}
                    <a class="kc-link" href="${url.loginUrl}">${msg("doLogIn")}</a>
                </p>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
