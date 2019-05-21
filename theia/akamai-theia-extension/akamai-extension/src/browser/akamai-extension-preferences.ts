import { interfaces } from 'inversify';
import { createPreferenceProxy, PreferenceProxy, PreferenceService, PreferenceContribution, PreferenceSchema } from '@theia/core/lib/browser';

export const AkamaiConfigSchema: PreferenceSchema = {
    'type': 'object',
    'properties': {
        'akamai.url.homepage': {
            'type': 'string',
            'description': 'Akamai Homepage',
            'default': 'https://developer.akamai.com'
        }
    }
};

export interface AkamaiConfiguration {
    'akamai.url.homepage': string,
}

export const AkamaiPreferences = Symbol('AkamaiPreferences');
export type AkamaiPreferences = PreferenceProxy<AkamaiConfiguration>;

export function createAkamaiPreferences(preferences: PreferenceService): AkamaiPreferences {
    return createPreferenceProxy(preferences, AkamaiConfigSchema);
}

export function bindAkamaiPreferences(bind: interfaces.Bind): void {
    bind(AkamaiPreferences).toDynamicValue(ctx => {
        const preferences = ctx.container.get<PreferenceService>(PreferenceService);
        return createAkamaiPreferences(preferences);
    });
    bind(PreferenceContribution).toConstantValue({ schema: AkamaiConfigSchema });
}
