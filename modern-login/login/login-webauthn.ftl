<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("webauthn-login-title")}
    <#elseif section = "form">
        <div class="kc-card">
            <!-- Header -->
            <div class="kc-header">
                <h1>${msg("webauthn-login-title")}</h1>
                <p>${msg("webauthn-login-instruction")}</p>
            </div>

            <!-- Error messages -->
            <#if message??>
                <div class="kc-alert-<#if message.type = 'error'>error<#elseif message.type = 'warning'>warning<#elseif message.type = 'success'>success<#else>info</#if>" role="alert">
                    ${message.summary}
                </div>
            </#if>

            <!-- WebAuthn Form -->
            <form id="kc-form-webauthn" class="kc-form" action="${url.loginAction}" method="post">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="authenticatorData" name="authenticatorData"/>
                <input type="hidden" id="signature" name="signature"/>
                <input type="hidden" id="credentialId" name="credentialId"/>
                <input type="hidden" id="userHandle" name="userHandle"/>
                <input type="hidden" id="err" name="err"/>

                <!-- Submit Button -->
                <div class="kc-form-group">
                    <button id="authenticate" class="kc-btn kc-btn-primary" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="inline-block mr-2"><path d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2 2 4 2 4 2-2 2-4z"/><path d="M6.5 19h11"/><path d="M22 11c0 4.97-4.03 9-9 9s-9-4.03-9-9 4.03-9 9-9 9 4.03 9 9z"/></svg>
                        ${msg("webauthn-do-authenticate")}
                    </button>
                </div>
            </form>

            <!-- Manual code entry fallback -->
            <#if isAppInitiatedAction?? && isAppInitiatedAction>
                <div class="mt-6 text-center">
                    <form action="${url.loginAction}" method="post">
                        <button class="kc-btn kc-btn-secondary" type="submit" name="try-AnotherWay" value="on">
                            ${msg("doTryAnotherWay")}
                        </button>
                    </form>
                </div>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>

<script type="text/javascript">
    // WebAuthn authentication logic
    function webAuthnAuthenticate() {
        if (!window.PublicKeyCredential) {
            document.getElementById('err').value = 'WebAuthn is not supported in this browser.';
            return;
        }

        var challenge = '${challenge}';
        var userId = '${userid}';
        var createCredential = ${createCredentialJson};

        var publicKey = {
            challenge: base64url.decode(challenge),
            timeout: 60000,
            userVerification: 'preferred'
        };

        if (userId) {
            publicKey.allowCredentials = [{
                id: base64url.decode(createCredential.id),
                type: 'public-key',
                transports: ['internal', 'usb', 'nfc', 'ble']
            }];
        }

        navigator.credentials.get({publicKey: publicKey})
            .then(function(assertion) {
                document.getElementById('clientDataJSON').value = base64url.encode(assertion.response.clientDataJSON);
                document.getElementById('authenticatorData').value = base64url.encode(assertion.response.authenticatorData);
                document.getElementById('signature').value = base64url.encode(assertion.response.signature);
                document.getElementById('credentialId').value = base64url.encode(assertion.id);
                if (assertion.response.userHandle) {
                    document.getElementById('userHandle').value = base64url.encode(assertion.response.userHandle);
                }
                document.getElementById('kc-form-webauthn').submit();
            })
            .catch(function(err) {
                document.getElementById('err').value = err;
                document.getElementById('kc-form-webauthn').submit();
            });
    }

    document.getElementById('authenticate').addEventListener('click', webAuthnAuthenticate);
</script>
