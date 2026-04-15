<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}" dir="${(locale.rtl)?then('rtl', 'ltr')}"</#if>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("loginTitle", (realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script type="importmap">
        {
            "imports": {
                "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
    </script>
    <script type="module">
        import { startSessionPolling } from "${url.resourcesPath}/js/authChecker.js";

        startSessionPolling("${url.ssoLoginInOtherTabsUrl?no_esc}");
    </script>
    <script type="module">
        document.addEventListener("click", (event) => {
            const link = event.target.closest("a[data-once-link]");
            if (!link) {
                return;
            }

            if (link.getAttribute("aria-disabled") === "true") {
                event.preventDefault();
                return;
            }

            const { disabledClass } = link.dataset;
            if (disabledClass) {
                link.classList.add(...disabledClass.trim().split(/\s+/));
            }

            link.setAttribute("role", "link");
            link.setAttribute("aria-disabled", "true");
        });
    </script>
</head>
<body class="${bodyClass}">
    <div class="min-h-screen p-4 sm:p-6">
        <div class="mx-auto flex min-h-[calc(100vh-2rem)] max-w-6xl items-center justify-center lg:justify-between">
            <div class="hidden max-w-xl pr-12 text-white lg:block">
                <p class="mb-4 text-sm font-semibold uppercase tracking-[0.3em] text-white/70">Keycloak 26.6 Theme</p>
                <h1 class="mb-6 text-5xl font-bold leading-tight">${realm.displayName!"Modern Login"}</h1>
                <p class="text-lg text-white/80">A Keycloak 26.6.0 compatible theme with a custom login experience and first-class support for registration, password recovery, MFA, and WebAuthn flows.</p>
            </div>

            <div class="w-full max-w-md">
                <div class="kc-card">
                    <div class="mb-6 flex items-start justify-between gap-4">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-[0.3em] text-primary-600">Secure Access</p>
                            <p class="mt-2 text-sm text-gray-500">${realm.displayName!"Keycloak"}</p>
                        </div>
                        <#if realm.internationalizationEnabled && locale.supported?size gt 1>
                            <div class="group relative">
                                <button type="button" class="kc-locale-trigger" aria-haspopup="true" aria-expanded="false">${locale.current}</button>
                                <ul class="kc-locale-list">
                                    <#list locale.supported as l>
                                        <li>
                                            <a class="kc-locale-link" href="${l.url}">${l.label}</a>
                                        </li>
                                    </#list>
                                </ul>
                            </div>
                        </#if>
                    </div>

                    <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                        <div class="kc-header">
                            <h1><#nested "header"></h1>
                            <#if displayRequiredFields>
                                <p class="kc-required-note">* ${msg("requiredFields")}</p>
                            </#if>
                        </div>
                    <#else>
                        <div class="mb-6">
                            <div class="kc-header mb-4">
                                <h1><#nested "header"></h1>
                                <#if displayRequiredFields>
                                    <p class="kc-required-note">* ${msg("requiredFields")}</p>
                                </#if>
                            </div>
                            <#nested "show-username">
                            <div class="kc-user-chip">
                                <span>${auth.attemptedUsername}</span>
                                <a class="kc-link" href="${url.loginRestartFlowUrl}">${msg("restartLoginTooltip")}</a>
                            </div>
                        </div>
                    </#if>

                    <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                        <div class="kc-alert <#if message.type = 'error'>kc-alert-error<#elseif message.type = 'warning'>kc-alert-warning<#elseif message.type = 'success'>kc-alert-success<#else>kc-alert-info</#if>" aria-live="polite">
                            ${kcSanitize(message.summary)?no_esc}
                        </div>
                    </#if>

                    <#nested "form">

                    <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                        <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" class="mt-4">
                            <input type="hidden" name="tryAnotherWay" value="on"/>
                            <a href="#" class="kc-link text-sm" onclick="document.forms['kc-select-try-another-way-form'].requestSubmit(); return false;">${msg("doTryAnotherWay")}</a>
                        </form>
                    </#if>

                    <#nested "socialProviders">

                    <#if displayInfo>
                        <div id="kc-info" class="kc-footer">
                            <#nested "info">
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
</#macro>
