<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=(realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${kcSanitize(msg("webauthn-login-title"))?no_esc}
    <#elseif section = "form">
        <div class="space-y-5">
            <form id="webauth" action="${url.loginAction}" method="post">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON" />
                <input type="hidden" id="authenticatorData" name="authenticatorData" />
                <input type="hidden" id="signature" name="signature" />
                <input type="hidden" id="credentialId" name="credentialId" />
                <input type="hidden" id="userHandle" name="userHandle" />
                <input type="hidden" id="error" name="error" />
            </form>

            <#if authenticators?? && shouldDisplayAuthenticators?? && shouldDisplayAuthenticators>
                <div>
                    <#if authenticators.authenticators?size gt 1>
                        <p class="mb-3 text-sm font-medium text-gray-700">${kcSanitize(msg("webauthn-available-authenticators"))?no_esc}</p>
                    </#if>
                    <div class="kc-selection-list">
                        <#list authenticators.authenticators as authenticator>
                            <div id="kc-webauthn-authenticator-item-${authenticator?index}" class="kc-selection-item">
                                <div class="kc-selection-icon">
                                    <i class="${authenticator.transports.iconClass!''}" aria-hidden="true"></i>
                                </div>
                                <div class="min-w-0 flex-1">
                                    <div class="font-semibold text-gray-900">${kcSanitize(msg('${authenticator.label}'))?no_esc}</div>
                                    <#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
                                        <div class="mt-1 text-sm text-gray-600">
                                            <#list authenticator.transports.displayNameProperties as nameProperty>
                                                <span>${kcSanitize(msg('${nameProperty!}'))?no_esc}</span><#if nameProperty?has_next><span>, </span></#if>
                                            </#list>
                                        </div>
                                    </#if>
                                    <div class="mt-1 text-sm text-gray-500">${kcSanitize(msg('webauthn-createdAt-label'))?no_esc}: ${kcSanitize(authenticator.createdAt)?no_esc}</div>
                                </div>
                            </div>
                        </#list>
                    </div>
                </div>
            </#if>

            <input id="authenticateWebAuthnButton" type="button" autofocus="autofocus" value="${kcSanitize(msg('webauthn-doAuthenticate'))}" class="kc-btn kc-btn-primary" />
        </div>

        <script type="module">
            import { authenticateByWebAuthn } from "${url.resourcesPath}/js/webauthnAuthenticate.js";
            const authButton = document.getElementById('authenticateWebAuthnButton');
            authButton.addEventListener("click", function() {
                const input = {
                    isUserIdentified: ${isUserIdentified},
                    challenge: '${challenge}',
                    userVerification: '${userVerification}',
                    rpId: '${rpId}',
                    createTimeout: ${createTimeout},
                    errmsg: "${msg('webauthn-unsupported-browser-text')?no_esc}"
                };
                authenticateByWebAuthn(input);
            });
        </script>
    <#elseif section = "info">
        <#if realm.registrationAllowed && !registrationDisabled??>
            <span>${msg("noAccount")} <a tabindex="6" class="kc-link" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
        </#if>
    </#if>
</@layout.registrationLayout>
