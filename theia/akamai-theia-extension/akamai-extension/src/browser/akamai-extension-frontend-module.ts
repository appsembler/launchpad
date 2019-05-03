/**
 * Generated using theia-extension-generator
 */

import { AkamaiExtensionFrontendApplicationContribution, AkamaiExtensionCommandContribution, AkamaiExtensionMenuContribution } from './akamai-extension-contribution';
import {
    CommandContribution,
    MenuContribution
} from "@theia/core/lib/common";
import { FrontendApplicationContribution } from "@theia/core/lib/browser";
import { bindAkamaiPreferences } from './akamai-extension-preferences';
import { ContainerModule } from "inversify";

export default new ContainerModule(bind => {
    // add your contribution bindings here
    bindAkamaiPreferences(bind);
    bind(FrontendApplicationContribution).to(AkamaiExtensionFrontendApplicationContribution);
    bind(CommandContribution).to(AkamaiExtensionCommandContribution);
    bind(MenuContribution).to(AkamaiExtensionMenuContribution);
    
});
