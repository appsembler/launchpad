"use strict";
/**
 * Generated using theia-extension-generator
 */
Object.defineProperty(exports, "__esModule", { value: true });
var isc_extension_contribution_1 = require("./isc-extension-contribution");
var common_1 = require("@theia/core/lib/common");
var browser_1 = require("@theia/core/lib/browser");
var inversify_1 = require("inversify");
var isc_extension_preferences_1 = require("./isc-extension-preferences");
exports.default = new inversify_1.ContainerModule(function (bind) {
    // add your contribution bindings here
    isc_extension_preferences_1.bindISCPreferences(bind);
    bind(browser_1.FrontendApplicationContribution).to(isc_extension_contribution_1.ISCExtensionFrontendApplicationContribution);
    bind(common_1.MenuContribution).to(isc_extension_contribution_1.ISCExtensionMenuContribution);
    bind(common_1.CommandContribution).to(isc_extension_contribution_1.ISCExtensionCommandContribution);
});
//# sourceMappingURL=isc-extension-frontend-module.js.map