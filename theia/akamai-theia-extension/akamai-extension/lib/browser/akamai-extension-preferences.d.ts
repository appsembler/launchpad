import { interfaces } from 'inversify';
import { PreferenceProxy, PreferenceService, PreferenceSchema } from '@theia/core/lib/browser';
export declare const AkamaiConfigSchema: PreferenceSchema;
export interface AkamaiConfiguration {
    'akamai.url.homepage': string;
}
export declare const AkamaiPreferences: unique symbol;
export declare type AkamaiPreferences = PreferenceProxy<AkamaiConfiguration>;
export declare function createAkamaiPreferences(preferences: PreferenceService): AkamaiPreferences;
export declare function bindAkamaiPreferences(bind: interfaces.Bind): void;
//# sourceMappingURL=akamai-extension-preferences.d.ts.map