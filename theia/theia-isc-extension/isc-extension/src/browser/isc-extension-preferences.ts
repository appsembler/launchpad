import { interfaces } from 'inversify';
import { createPreferenceProxy, PreferenceProxy, PreferenceService, PreferenceContribution, PreferenceSchema } from '@theia/core/lib/browser';

export const ISCConfigSchema: PreferenceSchema = {
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

export interface ISCConfiguration {
    'isc.url.terminal': string,
    'isc.url.portal': string,
    'isc.url.whatisiris': string,
    'isc.url.quickstarts': string,
    'isc.url.firstlooks': string,
    'isc.url.connecting': string,
    'isc.url.containers': string,
    'isc.url.learning': string,
    'isc.url.support': string,
    'isc.url.documentation': string,
    'isc.url.gettingstarted': string,
    'isc.url.labs': string
}

export const ISCPreferences = Symbol('ISCPreferences');
export type ISCPreferences = PreferenceProxy<ISCConfiguration>;

export function createISCPreferences(preferences: PreferenceService): ISCPreferences {
    return createPreferenceProxy(preferences, ISCConfigSchema);
}

export function bindISCPreferences(bind: interfaces.Bind): void {
    bind(ISCPreferences).toDynamicValue(ctx => {
        const preferences = ctx.container.get<PreferenceService>(PreferenceService);
        return createISCPreferences(preferences);
    });
    bind(PreferenceContribution).toConstantValue({ schema: ISCConfigSchema });
}
