import { injectable, inject } from "inversify";
import { CommandContribution, CommandRegistry, MenuContribution, MenuModelRegistry, MessageService } from "@theia/core/lib/common";
import { CommonMenus } from "@theia/core/lib/browser";

export const AkamaiExtensionCommand = {
    id: 'AkamaiExtension.command',
    label: "Shows a message"
};

@injectable()
export class AkamaiExtensionCommandContribution implements CommandContribution {

    constructor(
        @inject(MessageService) private readonly messageService: MessageService,
    ) { }

    registerCommands(registry: CommandRegistry): void {
        registry.registerCommand(AkamaiExtensionCommand, {
            execute: () => this.messageService.info('Hello Brian!')
        });
    }
}

@injectable()
export class AkamaiExtensionMenuContribution implements MenuContribution {

    registerMenus(menus: MenuModelRegistry): void {
        menus.registerMenuAction(CommonMenus.EDIT_FIND, {
            commandId: AkamaiExtensionCommand.id,
            label: 'Say Brian'
        });
    }
}
