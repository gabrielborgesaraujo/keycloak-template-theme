<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <form id="kc-update-profile-form" class="kc-form" action="${url.loginAction}" method="post">
            <@userProfileCommons.userProfileFormFields/>

            <div class="kc-page-actions">
                <#if isAppInitiatedAction??>
                    <div class="kc-inline-actions">
                        <button class="kc-btn kc-btn-primary sm:w-auto" type="submit">${msg("doSubmit")}</button>
                        <button class="kc-btn kc-btn-secondary sm:w-auto" type="submit" name="cancel-aia" value="true" formnovalidate>${msg("doCancel")}</button>
                    </div>
                <#else>
                    <button class="kc-btn kc-btn-primary" type="submit">${msg("doSubmit")}</button>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
