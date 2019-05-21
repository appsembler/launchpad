"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var browser_1 = require("@theia/core/lib/browser");
exports.AkamaiConfigSchema = {
    'type': 'object',
    'properties': {
        'akamai.url.homepage': {
            'type': 'string',
            'description': 'Akamai Homepage',
            'default': 'https://developer.akamai.com'
        }
    }
};
exports.AkamaiPreferences = Symbol('AkamaiPreferences');
function createAkamaiPreferences(preferences) {
    return browser_1.createPreferenceProxy(preferences, exports.AkamaiConfigSchema);
}
exports.createAkamaiPreferences = createAkamaiPreferences;
function bindAkamaiPreferences(bind) {
    bind(exports.AkamaiPreferences).toDynamicValue(function (ctx) {
        var preferences = ctx.container.get(browser_1.PreferenceService);
        return createAkamaiPreferences(preferences);
    });
    bind(browser_1.PreferenceContribution).toConstantValue({ schema: exports.AkamaiConfigSchema });
}
exports.bindAkamaiPreferences = bindAkamaiPreferences;
//# sourceMappingURL=akamai-extension-preferences.js.map