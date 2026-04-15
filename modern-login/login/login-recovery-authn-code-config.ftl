<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("recovery-code-config-header")}
    <#elseif section = "form">
        <div class="space-y-5">
            <div class="kc-alert kc-alert-warning">
                <p class="font-semibold">${msg("recovery-code-config-warning-title")}</p>
                <p class="mt-2 text-sm">${msg("recovery-code-config-warning-message")}</p>
            </div>

            <ol id="kc-recovery-codes-list" class="kc-code-list">
                <#list recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList as code>
                    <li><span>${code?counter}:</span> <span>${code[0..3]}-${code[4..7]}-${code[8..]}</span></li>
                </#list>
            </ol>

            <div class="kc-inline-actions">
                <button id="printRecoveryCodes" class="kc-btn kc-btn-secondary sm:w-auto" type="button">${msg("recovery-codes-print")}</button>
                <button id="downloadRecoveryCodes" class="kc-btn kc-btn-secondary sm:w-auto" type="button">${msg("recovery-codes-download")}</button>
                <button id="copyRecoveryCodes" class="kc-btn kc-btn-secondary sm:w-auto" type="button">${msg("recovery-codes-copy")}</button>
            </div>

            <div class="kc-form-group">
                <label class="flex items-start gap-3 text-sm text-gray-700" for="kcRecoveryCodesConfirmationCheck">
                    <input class="kc-checkbox mt-1" type="checkbox" id="kcRecoveryCodesConfirmationCheck" name="kcRecoveryCodesConfirmationCheck" onchange="document.getElementById('saveRecoveryAuthnCodesBtn').disabled = !this.checked;" />
                    <span>${msg("recovery-codes-confirmation-message")}</span>
                </label>
            </div>

            <form action="${url.loginAction}" class="kc-form" id="kc-recovery-codes-settings-form" method="post">
                <input type="hidden" name="generatedRecoveryAuthnCodes" value="${recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesAsString}" />
                <input type="hidden" name="generatedAt" value="${recoveryAuthnCodesConfigBean.generatedAt?c}" />
                <input type="hidden" id="userLabel" name="userLabel" value="${msg('recovery-codes-label-default')}" />

                <div class="kc-form-group">
                    <label class="flex items-center gap-3 text-sm text-gray-700" for="logout-sessions">
                        <input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked class="kc-checkbox" />
                        <span>${msg("logoutOtherSessions")}</span>
                    </label>
                </div>

                <#if isAppInitiatedAction??>
                    <div class="kc-inline-actions">
                        <input type="submit" class="kc-btn kc-btn-primary sm:w-auto" id="saveRecoveryAuthnCodesBtn" value="${msg('recovery-codes-action-complete')}" disabled />
                        <button type="submit" class="kc-btn kc-btn-secondary sm:w-auto" id="cancelRecoveryAuthnCodesBtn" name="cancel-aia" value="true">${msg("recovery-codes-action-cancel")}</button>
                    </div>
                <#else>
                    <input type="submit" class="kc-btn kc-btn-primary" id="saveRecoveryAuthnCodesBtn" value="${msg('recovery-codes-action-complete')}" disabled />
                </#if>
            </form>
        </div>

        <script>
            function parseRecoveryCodeList() {
                var recoveryCodes = document.querySelectorAll("#kc-recovery-codes-list li");
                var recoveryCodeList = "";

                for (var i = 0; i < recoveryCodes.length; i++) {
                    recoveryCodeList += recoveryCodes[i].innerText + "\r\n";
                }

                return recoveryCodeList;
            }

            function copyRecoveryCodes() {
                var tmpTextarea = document.createElement("textarea");
                tmpTextarea.value = parseRecoveryCodeList();
                document.body.appendChild(tmpTextarea);
                tmpTextarea.select();
                document.execCommand("copy");
                document.body.removeChild(tmpTextarea);
            }

            function formatCurrentDateTime() {
                var dt = new Date();
                return dt.toLocaleString('en-US', {
                    month: 'long',
                    day: 'numeric',
                    year: 'numeric',
                    hour: 'numeric',
                    minute: 'numeric',
                    timeZoneName: 'short'
                });
            }

            function buildDownloadContent() {
                return "${msg('recovery-codes-download-file-header')}\n\n" +
                    parseRecoveryCodeList() + "\n" +
                    "${msg('recovery-codes-download-file-description')}\n\n" +
                    "${msg('recovery-codes-download-file-date')} " + formatCurrentDateTime();
            }

            function downloadRecoveryCodes() {
                var el = document.createElement('a');
                el.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(buildDownloadContent()));
                el.setAttribute('download', 'kc-download-recovery-codes.txt');
                el.style.display = 'none';
                document.body.appendChild(el);
                el.click();
                document.body.removeChild(el);
            }

            function printRecoveryCodes() {
                var w = window.open();
                var recoveryCodeListHTML = document.getElementById('kc-recovery-codes-list').innerHTML;
                w.document.write("<html><body><pre>" + recoveryCodeListHTML + "</pre></body></html>");
                w.print();
                w.close();
            }

            document.getElementById("copyRecoveryCodes")?.addEventListener("click", copyRecoveryCodes);
            document.getElementById("downloadRecoveryCodes")?.addEventListener("click", downloadRecoveryCodes);
            document.getElementById("printRecoveryCodes")?.addEventListener("click", printRecoveryCodes);
        </script>
    </#if>
</@layout.registrationLayout>
