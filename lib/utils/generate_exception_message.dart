String generateExceptionMessage(exceptionCode) {
  switch (exceptionCode) {
    case "admin-restricted-operation":
      return "Admin only operation";
    case "argument-error":
      return "Argument error";
    case "app-not-authorized":
      return "App not authorized";
    case "app-not-installed":
      return "App not installed";
    case "captcha-check-failed":
      return "Captcha check failed";
    case "code-expired":
      return "Code expired";
    case "cordova-not-ready":
      return "Cordova not ready";
    case "cors-unsupported":
      return "CORS unsupported";
    case "credential-already-in-use":
      return "Credential already in use";
    case "custom-token-mismatch":
      return "Credential mismatch";
    case "requires-recent-login":
      return "Credential too old, login again";
    case "dependent-sdk-initialized-before-auth":
      return "Dependent SDK initialized before Auth";
    case "dynamic-link-not-activated":
      return "Dynamic link not activated";
    case "email-change-needs-verification":
      return "Email change needs verification";
    case "email-already-in-use":
      return "Email already in use";
    case "emulator-config-failed":
      return "Emulator config failed";
    case "expired-action-code":
      return "Expired action code";
    case "cancelled-popup-request":
      return "Expired popup request";
    case "internal-error":
      return "Internal error";
    case "invalid-api-key":
      return "Invalid API key";
    case "invalid-app-credential":
      return "Invalid app credential";
    case "invalid-app-id":
      return "Invalid app ID";
    case "invalid-user-token":
      return "Invalid Auth";
    case "invalid-auth-event":
      return "Invalid auth event";
    case "invalid-cert-hash":
      return "Invalid cert hash";
    case "invalid-verification-code":
      return "Invalid code";
    case "invalid-continue-uri":
      return "Invalid continue URI";
    case "invalid-cordova-configuration":
      return "Invalid Cordova configuration";
    case "invalid-custom-token":
      return "Invalid custom token";
    case "invalid-dynamic-link-domain":
      return "Invalid dynamic link domain";
    case "invalid-email":
      return "Invalid email";
    case "invalid-emulator-scheme":
      return "Invalid emulator scheme";
    case "invalid-credential":
      return "Invalid IDP response"; //The supplied auth credential is incorrect, malformed or has expired.
    case "invalid-message-payload":
      return "Invalid message payload";
    case "invalid-multi-factor-session":
      return "Invalid MFA session";
    case "invalid-oauth-client-id":
      return "Invalid OAuth client ID";
    case "invalid-oauth-provider":
      return "Invalid OAuth provider";
    case "invalid-action-code":
      return "Invalid OOB code";
    case "unauthorized-domain":
      return "Invalid origin";
    case "wrong-password":
      return "Invalid password";
    case "invalid-persistence-type":
      return "Invalid persistence";
    case "invalid-phone-number":
      return "Invalid phone number";
    case "invalid-provider-id":
      return "Invalid provider ID";
    case "invalid-recipient-email":
      return "Invalid recipient email";
    case "invalid-sender":
      return "Invalid sender";
    case "invalid-verification-id":
      return "Invalid session info";
    case "invalid-tenant-id":
      return "Invalid tenant ID";
    case "multi-factor-info-not-found":
      return "MFA info not found";
    case "multi-factor-auth-required":
      return "MFA required";
    case "missing-android-pkg-name":
      return "Missing Android package name";
    case "missing-app-credential":
      return "Missing app credential";
    case "auth-domain-config-required":
      return "Missing Auth domain";
    case "missing-verification-code":
      return "Missing code";
    case "missing-continue-uri":
      return "Missing continue URI";
    case "missing-iframe-start":
      return "Missing iframe start";
    case "missing-ios-bundle-id":
      return "Missing iOS bundle ID";
    case "missing-or-invalid-nonce":
      return "Missing or invalid nonce";
    case "missing-multi-factor-info":
      return "Missing MFA info";
    case "missing-multi-factor-session":
      return "Missing MFA session";
    case "missing-phone-number":
      return "Missing phone number";
    case "missing-verification-id":
      return "Missing session info";
    case "app-deleted":
      return "Module destroyed";
    case "account-exists-with-different-credential":
      return "Need confirmation";
    case "network-request-failed":
      return "Network request failed";
    case "null-user":
      return "Null user";
    case "no-auth-event":
      return "No auth event";
    case "no-such-provider":
      return "No such provider";
    case "operation-not-allowed":
      return "Operation not allowed";
    case "operation-not-supported-in-this-environment":
      return "Operation not supported";
    case "popup-blocked":
      return "Popup blocked";
    case "popup-closed-by-user":
      return "Popup closed by user";
    case "provider-already-linked":
      return "Provider already linked";
    case "quota-exceeded":
      return "Quota exceeded";
    case "redirect-cancelled-by-user":
      return "Redirect cancelled by user";
    case "redirect-operation-pending":
      return "Redirect operation pending";
    case "rejected-credential":
      return "Rejected credential";
    case "second-factor-already-in-use":
      return "Second factor already enrolled";
    case "maximum-second-factor-count-exceeded":
      return "Second factor limit exceeded";
    case "tenant-id-mismatch":
      return "Tenant ID mismatch";
    case "timeout":
      return "Timeout";
    case "user-token-expired":
      return "Token expired";
    case "too-many-requests":
      return "Too many attempts, try later";
    case "unauthorized-continue-uri":
      return "Unauthorized domain";
    case "unsupported-first-factor":
      return "Unsupported first factor";
    case "unsupported-persistence-type":
      return "Unsupported persistence";
    case "unsupported-tenant-operation":
      return "Unsupported tenant operation";
    case "unverified-email":
      return "Unverified email";
    case "user-cancelled":
      return "User cancelled";
    case "user-not-found":
      return "User not found";
    case "user-disabled":
      return "User disabled";
    case "user-mismatch":
      return "User mismatch";
    case "user-signed-out":
      return "User signed out";
    case "weak-password":
      return "Weak password";
    case "web-storage-unsupported":
      return "Web storage unsupported";
    case "already-initialized":
      return "Already initialized";
    case "recaptcha-not-enabled":
      return "Recaptcha not enabled";
    case "missing-recaptcha-token":
      return "Missing Recaptcha token";
    case "invalid-recaptcha-token":
      return "Invalid Recaptcha token";
    case "invalid-recaptcha-action":
      return "Invalid Recaptcha action";
    case "missing-client-type":
      return "Missing client type";
    case "missing-recaptcha-version":
      return "Missing Recaptcha version";
    case "invalid-recaptcha-version":
      return "Invalid Recaptcha version";
    case "invalid-req-type":
      return "Invalid request type";
    default:
      "Undefined Error occurred";
      break;
  }
  return "Undefined Error occurred";
}
