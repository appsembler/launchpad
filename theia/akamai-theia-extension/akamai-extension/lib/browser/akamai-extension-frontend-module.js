"use strict";
/**
 * Generated using theia-extension-generator
 */
Object.defineProperty(exports, "__esModule", { value: true });
var akamai_extension_contribution_1 = require("./akamai-extension-contribution");
var common_1 = require("@theia/core/lib/common");
var browser_1 = require("@theia/core/lib/browser");
var akamai_extension_preferences_1 = require("./akamai-extension-preferences");
var inversify_1 = require("inversify");
exports.default = new inversify_1.ContainerModule(function (bind) {
    // add your contribution bindings here
    akamai_extension_preferences_1.bindAkamaiPreferences(bind);
    bind(browser_1.FrontendApplicationContribution).to(akamai_extension_contribution_1.AkamaiExtensionFrontendApplicationContribution);
    bind(common_1.CommandContribution).to(akamai_extension_contribution_1.AkamaiExtensionCommandContribution);
    bind(common_1.MenuContribution).to(akamai_extension_contribution_1.AkamaiExtensionMenuContribution);
});
//# sourceMappingURL=akamai-extension-frontend-module.js.map