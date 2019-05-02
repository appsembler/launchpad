"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var browser_1 = require("@theia/core/lib/browser");
exports.ISCConfigSchema = {
    'type': 'object',
    'properties': {
        'isc.url.terminal': {
            'type': 'string',
            'description': 'InterSystems Web Terminal',
            'default': 'http://localhost:52773/terminal/?clean=1'
        },
        'isc.url.portal': {
            'type': 'string',
            'description': 'InterSystems Management Portal',
            'default': 'http://localhost:52773/csp/sys/UtilHome.csp'
        },
        'isc.url.documentation': {
            'type': 'string',
            'description': 'InterSystems IRIS Documentation',
            'default': 'https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?NAMESPACE=USER'
        },
        'isc.url.whatisiris': {
            'type': 'string',
            'description': 'What is InterSystems IRIS',
            'default': 'https://www.intersystems.com/products/intersystems-iris'
        },
        'isc.url.quickstarts': {
            'type': 'string',
            'description': 'InterSystems QuickStarts',
            'default': 'https://learning.intersystems.com/course/view.php?name=QS'
        },
        'isc.url.firstlooks': {
            'type': 'string',
            'description': 'InterSystems First Looks',
            'default': 'https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=AFINDEX'
        },
        'isc.url.gettingstarted': {
            'type': 'string',
            'description': 'Getting Started',
            'default': 'file://home/project/README.md'
        },
        'isc.url.connecting': {
            'type': 'string',
            'description': 'Connecting Your IDE to InterSystems IRIS',
            'default': 'https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=AB_idesetup'
        },
        'isc.url.containers': {
            'type': 'string',
            'description': 'Running InterSystems Products In Containers',
            'default': 'https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=ADOCK'
        },
        'isc.url.learning': {
            'type': 'string',
            'description': 'InterSystems Online Learning',
            'default': 'https://learning.intersystems.com'
        },
        'isc.url.support': {
            'type': 'string',
            'description': 'InterSystems Support',
            'default': 'https://www.intersystems.com/support-learning/support/'
        },
        'isc.url.labs': {
            'type': 'string',
            'description': 'InterSystems Learning Labs.',
            'default': 'https://learning.intersystems.com/course/view.php?name=Java Build'
        }
    }
};
exports.ISCPreferences = Symbol('ISCPreferences');
function createISCPreferences(preferences) {
    return browser_1.createPreferenceProxy(preferences, exports.ISCConfigSchema);
}
exports.createISCPreferences = createISCPreferences;
function bindISCPreferences(bind) {
    bind(exports.ISCPreferences).toDynamicValue(function (ctx) {
        var preferences = ctx.container.get(browser_1.PreferenceService);
        return createISCPreferences(preferences);
    });
    bind(browser_1.PreferenceContribution).toConstantValue({ schema: exports.ISCConfigSchema });
}
exports.bindISCPreferences = bindISCPreferences;
//# sourceMappingURL=isc-extension-preferences.js.map