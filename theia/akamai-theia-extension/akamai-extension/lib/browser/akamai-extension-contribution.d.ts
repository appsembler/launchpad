import { ILogger, MaybePromise, CommandRegistry, CommandContribution, MenuContribution, MenuModelRegistry } from "@theia/core/lib/common";
import { FrontendApplication, FrontendApplicationContribution } from "@theia/core/lib/browser";
import { FileNavigatorContribution } from "@theia/navigator/lib/browser/navigator-contribution";
import { TerminalService } from "@theia/terminal/lib/browser/base/terminal-service";
import { OpenerService } from '@theia/core/lib/browser';
import { WorkspaceService } from '@theia/workspace/lib/browser';
import { PreviewContribution } from '@theia/preview/lib/browser/preview-contribution';
import { AkamaiPreferences } from './akamai-extension-preferences';
import { FrontendApplicationStateService } from "@theia/core/lib/browser/frontend-application-state";
export declare class AkamaiExtensionFrontendApplicationContribution implements FrontendApplicationContribution {
    protected readonly logger: ILogger;
    protected readonly navigator: FileNavigatorContribution;
    protected readonly terminal: TerminalService;
    protected readonly openerService: OpenerService;
    protected readonly workspaceService: WorkspaceService;
    protected readonly preview: PreviewContribution;
    protected readonly commands: CommandRegistry;
    protected readonly menus: MenuModelRegistry;
    protected readonly stateService: FrontendApplicationStateService;
    constructor(logger: ILogger, navigator: FileNavigatorContribution, terminal: TerminalService, openerService: OpenerService, workspaceService: WorkspaceService, preview: PreviewContribution, commands: CommandRegistry, menus: MenuModelRegistry);
    onStart(app: FrontendApplication): Promise<void>;
    initializeLayout(app: FrontendApplication): MaybePromise<void>;
    protected getQueryparam(name: string, url?: string): string | null;
}
export declare const AkamaiHomepage: {
    id: string;
    label: string;
};
export declare class AkamaiExtensionMenuContribution implements MenuContribution {
    protected readonly openerService: OpenerService;
    constructor(openerService: OpenerService);
    registerMenus(menus: MenuModelRegistry): void;
}
export declare class AkamaiExtensionCommandContribution implements CommandContribution {
    protected readonly openerService: OpenerService;
    protected preferences: AkamaiPreferences;
    constructor(openerService: OpenerService, preferences: AkamaiPreferences);
    registerCommands(registry: CommandRegistry): void;
}
//# sourceMappingURL=akamai-extension-contribution.d.ts.map