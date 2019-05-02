/**
 * Generated using theia-extension-generator
 */

import { ISCExtensionFrontendApplicationContribution, ISCExtensionMenuContribution, ISCExtensionCommandContribution } from './isc-extension-contribution';
import { CommandContribution, MenuContribution } from "@theia/core/lib/common";
import { FrontendApplicationContribution } from "@theia/core/lib/browser";
import { ContainerModule } from "inversify";
import { bindISCPreferences } from './isc-extension-preferences';


export default new ContainerModule(bind => {
    // add your contribution bindings here
    bindISCPreferences(bind);
    bind(FrontendApplicationContribution).to(ISCExtensionFrontendApplicationContribution);
    bind(MenuContribution).to(ISCExtensionMenuContribution);
    bind(CommandContribution).to(ISCExtensionCommandContribution);
    
});
