import { injectable, inject } from "inversify";
import { ILogger, MaybePromise, CommandRegistry, CommandContribution, MenuContribution, MenuModelRegistry, MAIN_MENU_BAR } from "@theia/core/lib/common";
import URI from "@theia/core/lib/common/uri";
import { FrontendApplication, FrontendApplicationContribution } from "@theia/core/lib/browser";
import { FileNavigatorContribution } from "@theia/navigator/lib/browser/navigator-contribution";
import { TerminalService } from "@theia/terminal/lib/browser/base/terminal-service";
import { open, OpenerService} from '@theia/core/lib/browser';
import { WorkspaceService } from '@theia/workspace/lib/browser';
import { PreviewContribution } from '@theia/preview/lib/browser/preview-contribution';
import { ISCPreferences } from './isc-extension-preferences';
@injectable()
export class ISCExtensionFrontendApplicationContribution implements FrontendApplicationContribution {
    constructor(
        @inject(ILogger) protected readonly logger: ILogger,
        @inject(FileNavigatorContribution) protected readonly navigator: FileNavigatorContribution,
        @inject(TerminalService) protected readonly terminal: TerminalService,
        @inject(OpenerService) protected readonly openerService: OpenerService,
        @inject(WorkspaceService) protected readonly workspaceService: WorkspaceService,
        @inject(PreviewContribution) protected readonly preview: PreviewContribution
    ) { }
    

    async onStart(app: FrontendApplication) {
        // Layout doesn't need to be initialized before we can start a terminal
        let terminalWidget = await this.terminal.newTerminal({});
        terminalWidget.start();
        this.terminal.activateTerminal(terminalWidget);
    }

    initializeLayout(app: FrontendApplication): MaybePromise<void> {
        // We open a new file view in the navigator
        this.navigator.openView({
            activate: true
        })

        // We get the path of the currently open folder in the workspace (passed when starting the IDE)
        // and open the README.md file in that folder
        const workspace = this.workspaceService.workspace;
        if (workspace) {
            const workspaceURI = new URI(workspace.uri);
            const readmeURI = workspaceURI.resolve('README.md');
            open(this.openerService, readmeURI).then(
                () => this.preview.open(readmeURI)
            );    
        }
    }
}

export const ISCWhatisIrisCommand = {
    id: 'ISC.WhatisIrisCommand',
    label: "What is InterSystems IRIS"
};
export const ISCTerminalCommand = {
    id: 'ISC.TerminalCommand',
    label: "InterSystems IRIS Terminal"
};
export const ISCDocsCommand = {
    id: 'ISC.DocsCommand',
    label: "InterSystems IRIS Documentation"
};
export const ISCPortalCommand = {
    id: 'ISC.PortalCommand',
    label: "InterSystems IRIS Management Portal"
};
export const ISCLabsCommand = {
    id: 'ISC.LabsCommand',
    label: "InterSystems Learning Labs"
};
export const ISCQuickStartsCommand = {
    id: 'ISC.QuickStartsCommand',
    label: "InterSystems QuickStarts"
};
export const ISCFirstLooksCommand = {
    id: 'ISC.FirstLooksCommand',
    label: "InterSystems First Looks"
};
export const ISCGettingStartedCommand = {
    id: 'ISC.GettingStartedCommand',
    label: "Getting Started"
};
export const ISCConnectingCommand = {
    id: 'ISC.ConnectingCommand',
    label: "Connecting Your IDE to InterSystems IRIS"
};
export const ISCContainersCommand = {
    id: 'ISC.ContainersCommand',
    label: "Running InterSystems Products in Containers"
};
export const ISCLearningCommand = {
    id: 'ISC.LearningCommand',
    label: "InterSystems Online Learning"
};
export const ISCSupportCommand = {
    id: 'ISC.SupportCommand',
    label: "InterSystems Support"
};

export namespace ISCMenus {
    export const INTERSYSTEMS = [...MAIN_MENU_BAR, '8_intersystems'];
    export const ISCHELP = [...MAIN_MENU_BAR, '9_help'];
    export const INTERSYSTEMS_SECTION1 = [...INTERSYSTEMS, '1_section'];
    export const INTERSYSTEMS_SECTION2 = [...INTERSYSTEMS, '2_section'];
    export const INTERSYSTEMS_SECTION3 = [...INTERSYSTEMS, '3_section'];
    export const INTERSYSTEMS_SECTION4 = [...ISCHELP, '4_section'];
    export const INTERSYSTEMS_SECTION5 = [...ISCHELP, '5_section'];
    export const INTERSYSTEMS_SECTION6 = [...ISCHELP, '6_section'];
}

@injectable()
export class ISCExtensionMenuContribution implements MenuContribution {
    constructor(
        @inject(OpenerService) protected readonly openerService: OpenerService,
    ) { }

    registerMenus(menus: MenuModelRegistry): void {
        menus.registerSubmenu(ISCMenus.INTERSYSTEMS, 'InterSystems');
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION1, {
                commandId: ISCWhatisIrisCommand.id,
                order: '0',
                label: 'What is InterSystems IRIS'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION2, {
                commandId: ISCTerminalCommand.id,
                order: '0',
                label: 'InterSystems IRIS Terminal'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION2, {
                commandId: ISCPortalCommand.id,
                order: '1',
                label: 'InterSystems IRIS Management Portal'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
                commandId: ISCLabsCommand.id,
                order: '0',
                label: 'InterSystems Learning Labs'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
            commandId: ISCQuickStartsCommand.id,
                order: '1',
            label: 'InterSystems QuickStarts'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
                commandId: ISCFirstLooksCommand.id,
                order: '2',
                label: 'InterSystems First Looks'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION4, {
                commandId: ISCGettingStartedCommand.id,
                order: '0',
                label: 'Getting Started'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION5, {
                commandId: ISCConnectingCommand.id,
                order: '0',
                label: 'Connecting Your IDE to InterSystems IRIS'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION5, {
            commandId: ISCContainersCommand.id,
                order: '1',
            label: 'Running InterSystems Products in Containers'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
               commandId: ISCDocsCommand.id,
                order: '0',
                label: 'InterSystems IRIS Documentation'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
                commandId: ISCLearningCommand.id,
                order: '1',
                label: 'InterSystems Online Learning'
            });
         menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
                commandId: ISCSupportCommand.id,
                order: '2',
                label: 'InterSystems Support'
            });
    }
}

@injectable()
export class ISCExtensionCommandContribution implements CommandContribution {

    constructor(
        @inject(ILogger) protected readonly logger: ILogger,
        @inject(OpenerService) protected readonly openerService: OpenerService,
        @inject(ISCPreferences) protected preferences: ISCPreferences,
    ) { }

    registerCommands(registry: CommandRegistry): void {
        registry.registerCommand(ISCPortalCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.portal']))
        });
        registry.registerCommand(ISCTerminalCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.terminal']))
        })
        registry.registerCommand(ISCDocsCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.documentation']))
        })
        registry.registerCommand(ISCWhatisIrisCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.whatisiris']))
        });
        registry.registerCommand(ISCLabsCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.labs']))
        });
        registry.registerCommand(ISCQuickStartsCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.quickstarts']))
        })
        registry.registerCommand(ISCFirstLooksCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.firstlooks']))
        })
        registry.registerCommand(ISCConnectingCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.connecting']))
        });
        registry.registerCommand(ISCContainersCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.containers']))
        });
        registry.registerCommand(ISCSupportCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.support']))
        })
        registry.registerCommand(ISCLearningCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.learning']))
        })
        registry.registerCommand(ISCGettingStartedCommand, {
            execute: () => open(this.openerService, new URI(this.preferences['isc.url.gettingstarted']))
        });
    }
}
