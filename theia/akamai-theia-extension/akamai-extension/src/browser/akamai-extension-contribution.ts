import { injectable, inject } from "inversify";
import { ILogger, MaybePromise, CommandRegistry, CommandContribution, MenuContribution, MenuModelRegistry, MAIN_MENU_BAR } from "@theia/core/lib/common";
import URI from "@theia/core/lib/common/uri";
import { FrontendApplication, FrontendApplicationContribution } from "@theia/core/lib/browser";
import { FileNavigatorContribution } from "@theia/navigator/lib/browser/navigator-contribution";
import { TerminalService } from "@theia/terminal/lib/browser/base/terminal-service";
import { open, OpenerService} from '@theia/core/lib/browser';
import { WorkspaceService } from '@theia/workspace/lib/browser';
import { PreviewContribution } from '@theia/preview/lib/browser/preview-contribution';
// import { MiniBrowserCommands } from '@theia/mini-browser/lib/browser/mini-browser-open-handler';
import { AkamaiPreferences } from './akamai-extension-preferences';
import { CommonMenus } from '@theia/core/lib/browser/common-frontend-contribution';
// import { EditorMainMenu } from '@theia/editor/lib/browser/editor-menu';


@injectable()
export class AkamaiExtensionFrontendApplicationContribution implements FrontendApplicationContribution {
    constructor(
        @inject(ILogger) protected readonly logger: ILogger,
        @inject(FileNavigatorContribution) protected readonly navigator: FileNavigatorContribution,
        @inject(TerminalService) protected readonly terminal: TerminalService,
        @inject(OpenerService) protected readonly openerService: OpenerService,
        @inject(WorkspaceService) protected readonly workspaceService: WorkspaceService,
        @inject(PreviewContribution) protected readonly preview: PreviewContribution,
        @inject(CommandRegistry) protected readonly commands: CommandRegistry,
        @inject(MenuModelRegistry) protected readonly menus: MenuModelRegistry,
    ) { }
    

    async onStart(app: FrontendApplication) {
        // Layout doesn't need to be initialized before we can start a terminal
        let terminalWidget = await this.terminal.newTerminal({});
        terminalWidget.start();
        this.terminal.activateTerminal(terminalWidget);
        this.menus.unregisterMenuAction("git-history:open-branch-history", CommonMenus.VIEW_VIEWS);
        this.menus.unregisterMenuAction("problemsView:toggle", CommonMenus.VIEW_VIEWS);
        this.menus.unregisterMenuAction("callhierachy:toggle", CommonMenus.VIEW_VIEWS);
        this.menus.unregisterMenuAction("outlineView:toggle", CommonMenus.VIEW_VIEWS);
        this.menus.unregisterMenuAction("gitView:toggle", CommonMenus.VIEW_VIEWS);
        this.menus.unregisterMenuAction("preferences:open");
        this.menus.unregisterMenuAction("workspace:openWorkspace", CommonMenus.FILE_OPEN);
        this.menus.unregisterMenuAction("workspace:openRecent", CommonMenus.FILE_OPEN);
        this.menus.unregisterMenuAction("workspace:close", CommonMenus.FILE_CLOSE);
        this.menus.unregisterMenuAction("workspace:saveAs", CommonMenus.FILE_OPEN);
        
        
        console.log(this.menus);
    }

    initializeLayout(app: FrontendApplication): MaybePromise<void> {
        this.menus.unregisterMenuAction("5_go", MAIN_MENU_BAR);
        this.menus.unregisterMenuAction("9_help", MAIN_MENU_BAR);

        // We open a new file view in the navigator
        this.navigator.openView({
            activate: true
        })
        
        // opens a website in preview
        // this.commands.executeCommand(MiniBrowserCommands.OPEN_URL.id, "https://www.bostonglobe.com/")

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

export const AkamaiHomepage = {
    id: 'Akamai.AkamaiHomepage',
    label: "Akamai Homepage"
};

export namespace AkamaiMenus {
    export const AKAMAI = [...MAIN_MENU_BAR, '8_akamai'];
    export const AKAMAI_SECTION1 = [...AKAMAI, '1_section'];
}

@injectable()
export class AkamaiExtensionMenuContribution implements MenuContribution {
    constructor(
        @inject(OpenerService) protected readonly openerService: OpenerService,
    ) { }

    registerMenus(menus: MenuModelRegistry): void {
        menus.registerSubmenu(AkamaiMenus.AKAMAI, "Akamai");
        menus.registerMenuAction(AkamaiMenus.AKAMAI_SECTION1, {
                commandId: AkamaiHomepage.id,
                order: '0',
                label: 'Homepage'
            });
    }
}

@injectable()
export class AkamaiExtensionCommandContribution implements CommandContribution {

    constructor(
        @inject(OpenerService) protected readonly openerService: OpenerService,
        @inject(AkamaiPreferences) protected preferences: AkamaiPreferences,
    ) { }

    registerCommands(registry: CommandRegistry): void {
        registry.registerCommand(AkamaiHomepage, {
            execute: () => open(this.openerService, new URI(this.preferences['akamai.url.homepage']))
        });
    }
}
