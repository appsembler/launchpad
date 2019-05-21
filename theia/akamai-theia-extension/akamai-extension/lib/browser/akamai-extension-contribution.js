"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var inversify_1 = require("inversify");
var common_1 = require("@theia/core/lib/common");
var uri_1 = require("@theia/core/lib/common/uri");
var browser_1 = require("@theia/core/lib/browser");
var navigator_contribution_1 = require("@theia/navigator/lib/browser/navigator-contribution");
var terminal_service_1 = require("@theia/terminal/lib/browser/base/terminal-service");
var browser_2 = require("@theia/core/lib/browser");
var browser_3 = require("@theia/workspace/lib/browser");
var preview_contribution_1 = require("@theia/preview/lib/browser/preview-contribution");
var mini_browser_open_handler_1 = require("@theia/mini-browser/lib/browser/mini-browser-open-handler");
var akamai_extension_preferences_1 = require("./akamai-extension-preferences");
var common_frontend_contribution_1 = require("@theia/core/lib/browser/common-frontend-contribution");
var frontend_application_state_1 = require("@theia/core/lib/browser/frontend-application-state");
// import { EditorMainMenu } from '@theia/editor/lib/browser/editor-menu';
var AkamaiExtensionFrontendApplicationContribution = /** @class */ (function () {
    function AkamaiExtensionFrontendApplicationContribution(logger, navigator, terminal, openerService, workspaceService, preview, commands, menus) {
        this.logger = logger;
        this.navigator = navigator;
        this.terminal = terminal;
        this.openerService = openerService;
        this.workspaceService = workspaceService;
        this.preview = preview;
        this.commands = commands;
        this.menus = menus;
    }
    AkamaiExtensionFrontendApplicationContribution.prototype.onStart = function (app) {
        return __awaiter(this, void 0, void 0, function () {
            var terminalWidget;
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.terminal.newTerminal({})];
                    case 1:
                        terminalWidget = _a.sent();
                        terminalWidget.start().then(function (a) { return _this.terminal.open(terminalWidget); });
                        this.menus.unregisterMenuAction("git-history:open-branch-history", common_frontend_contribution_1.CommonMenus.VIEW_VIEWS);
                        this.menus.unregisterMenuAction("problemsView:toggle", common_frontend_contribution_1.CommonMenus.VIEW_VIEWS);
                        this.menus.unregisterMenuAction("callhierachy:toggle", common_frontend_contribution_1.CommonMenus.VIEW_VIEWS);
                        this.menus.unregisterMenuAction("outlineView:toggle", common_frontend_contribution_1.CommonMenus.VIEW_VIEWS);
                        this.menus.unregisterMenuAction("gitView:toggle", common_frontend_contribution_1.CommonMenus.VIEW_VIEWS);
                        this.menus.unregisterMenuAction("preferences:open");
                        this.menus.unregisterMenuAction("workspace:openWorkspace", common_frontend_contribution_1.CommonMenus.FILE_OPEN);
                        this.menus.unregisterMenuAction("workspace:openRecent", common_frontend_contribution_1.CommonMenus.FILE_OPEN);
                        this.menus.unregisterMenuAction("workspace:close", common_frontend_contribution_1.CommonMenus.FILE_CLOSE);
                        this.menus.unregisterMenuAction("workspace:saveAs", common_frontend_contribution_1.CommonMenus.FILE_OPEN);
                        this.menus.unregisterMenuAction(browser_1.CommonCommands.ABOUT_COMMAND);
                        if (!this.workspaceService.opened) {
                            this.stateService.reachedState('ready').then(function (a) {
                                // opens a website in preview
                                var url = _this.getQueryparam("page");
                                if (url !== "" && url !== null) {
                                    _this.commands.executeCommand(mini_browser_open_handler_1.MiniBrowserCommands.OPEN_URL.id, url);
                                }
                            });
                        }
                        return [2 /*return*/];
                }
            });
        });
    };
    AkamaiExtensionFrontendApplicationContribution.prototype.initializeLayout = function (app) {
        this.menus.unregisterMenuAction("5_go", common_1.MAIN_MENU_BAR);
        this.menus.unregisterMenuAction("9_help", common_1.MAIN_MENU_BAR);
        // We open a new file view in the navigator
        this.navigator.openView({
            activate: true
        });
        // We get the path of the currently open folder in the workspace (passed when starting the IDE)
        // and open the README.md file in that folder
        var workspace = this.workspaceService.workspace;
        if (workspace) {
            // const workspaceURI = new URI(workspace.uri);
            // const readmeURI = workspaceURI.resolve('README.md');
            // open(this.openerService, readmeURI).then(
            //     () => this.preview.open(readmeURI)
            // );
        }
    };
    AkamaiExtensionFrontendApplicationContribution.prototype.getQueryparam = function (name, url) {
        if (!url)
            url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'), results = regex.exec(url);
        if (!results)
            return null;
        if (!results[2])
            return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    };
    __decorate([
        inversify_1.inject(frontend_application_state_1.FrontendApplicationStateService),
        __metadata("design:type", frontend_application_state_1.FrontendApplicationStateService)
    ], AkamaiExtensionFrontendApplicationContribution.prototype, "stateService", void 0);
    AkamaiExtensionFrontendApplicationContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(common_1.ILogger)),
        __param(1, inversify_1.inject(navigator_contribution_1.FileNavigatorContribution)),
        __param(2, inversify_1.inject(terminal_service_1.TerminalService)),
        __param(3, inversify_1.inject(browser_2.OpenerService)),
        __param(4, inversify_1.inject(browser_3.WorkspaceService)),
        __param(5, inversify_1.inject(preview_contribution_1.PreviewContribution)),
        __param(6, inversify_1.inject(common_1.CommandRegistry)),
        __param(7, inversify_1.inject(common_1.MenuModelRegistry)),
        __metadata("design:paramtypes", [Object, navigator_contribution_1.FileNavigatorContribution, Object, Object, browser_3.WorkspaceService,
            preview_contribution_1.PreviewContribution,
            common_1.CommandRegistry,
            common_1.MenuModelRegistry])
    ], AkamaiExtensionFrontendApplicationContribution);
    return AkamaiExtensionFrontendApplicationContribution;
}());
exports.AkamaiExtensionFrontendApplicationContribution = AkamaiExtensionFrontendApplicationContribution;
exports.AkamaiHomepage = {
    id: 'Akamai.AkamaiHomepage',
    label: "Akamai Homepage"
};
var AkamaiExtensionMenuContribution = /** @class */ (function () {
    function AkamaiExtensionMenuContribution(openerService) {
        this.openerService = openerService;
    }
    AkamaiExtensionMenuContribution.prototype.registerMenus = function (menus) {
        menus.registerMenuAction(common_frontend_contribution_1.CommonMenus.HELP, {
            commandId: exports.AkamaiHomepage.id,
            order: '0',
            label: 'Contact Us'
        });
    };
    AkamaiExtensionMenuContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(browser_2.OpenerService)),
        __metadata("design:paramtypes", [Object])
    ], AkamaiExtensionMenuContribution);
    return AkamaiExtensionMenuContribution;
}());
exports.AkamaiExtensionMenuContribution = AkamaiExtensionMenuContribution;
var AkamaiExtensionCommandContribution = /** @class */ (function () {
    function AkamaiExtensionCommandContribution(openerService, preferences) {
        this.openerService = openerService;
        this.preferences = preferences;
    }
    AkamaiExtensionCommandContribution.prototype.registerCommands = function (registry) {
        var _this = this;
        registry.registerCommand(exports.AkamaiHomepage, {
            execute: function () { return browser_2.open(_this.openerService, new uri_1.default(_this.preferences['akamai.url.homepage'])); }
        });
    };
    AkamaiExtensionCommandContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(browser_2.OpenerService)),
        __param(1, inversify_1.inject(akamai_extension_preferences_1.AkamaiPreferences)),
        __metadata("design:paramtypes", [Object, Object])
    ], AkamaiExtensionCommandContribution);
    return AkamaiExtensionCommandContribution;
}());
exports.AkamaiExtensionCommandContribution = AkamaiExtensionCommandContribution;
//# sourceMappingURL=akamai-extension-contribution.js.map