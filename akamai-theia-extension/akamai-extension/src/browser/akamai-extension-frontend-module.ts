/**
 * Generated using theia-extension-generator
 */

import { AkamaiExtensionCommandContribution, AkamaiExtensionMenuContribution } from './akamai-extension-contribution';
import {
    CommandContribution,
    MenuContribution
} from "@theia/core/lib/common";

import { ContainerModule } from "inversify";

export default new ContainerModule(bind => {
    // add your contribution bindings here
    
    bind(CommandContribution).to(AkamaiExtensionCommandContribution);
    bind(MenuContribution).to(AkamaiExtensionMenuContribution);
    
});