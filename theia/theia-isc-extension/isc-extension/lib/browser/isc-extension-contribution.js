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
var __read = (this && this.__read) || function (o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
};
var __spread = (this && this.__spread) || function () {
    for (var ar = [], i = 0; i < arguments.length; i++) ar = ar.concat(__read(arguments[i]));
    return ar;
};
Object.defineProperty(exports, "__esModule", { value: true });
var inversify_1 = require("inversify");
var common_1 = require("@theia/core/lib/common");
var uri_1 = require("@theia/core/lib/common/uri");
var navigator_contribution_1 = require("@theia/navigator/lib/browser/navigator-contribution");
var terminal_service_1 = require("@theia/terminal/lib/browser/base/terminal-service");
var browser_1 = require("@theia/core/lib/browser");
var browser_2 = require("@theia/workspace/lib/browser");
var preview_contribution_1 = require("@theia/preview/lib/browser/preview-contribution");
var isc_extension_preferences_1 = require("./isc-extension-preferences");
var ISCExtensionFrontendApplicationContribution = /** @class */ (function () {
    function ISCExtensionFrontendApplicationContribution(logger, navigator, terminal, openerService, workspaceService, preview) {
        this.logger = logger;
        this.navigator = navigator;
        this.terminal = terminal;
        this.openerService = openerService;
        this.workspaceService = workspaceService;
        this.preview = preview;
    }
    ISCExtensionFrontendApplicationContribution.prototype.onStart = function (app) {
        return __awaiter(this, void 0, void 0, function () {
            var terminalWidget;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.terminal.newTerminal({})];
                    case 1:
                        terminalWidget = _a.sent();
                        terminalWidget.start();
                        this.terminal.activateTerminal(terminalWidget);
                        return [2 /*return*/];
                }
            });
        });
    };
    ISCExtensionFrontendApplicationContribution.prototype.initializeLayout = function (app) {
        var _this = this;
        // We open a new file view in the navigator
        this.navigator.openView({
            activate: true
        });
        // We get the path of the currently open folder in the workspace (passed when starting the IDE)
        // and open the README.md file in that folder
        var workspace = this.workspaceService.workspace;
        if (workspace) {
            var workspaceURI = new uri_1.default(workspace.uri);
            var readmeURI_1 = workspaceURI.resolve('README.md');
            browser_1.open(this.openerService, readmeURI_1).then(function () { return _this.preview.open(readmeURI_1); });
        }
    };
    ISCExtensionFrontendApplicationContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(common_1.ILogger)),
        __param(1, inversify_1.inject(navigator_contribution_1.FileNavigatorContribution)),
        __param(2, inversify_1.inject(terminal_service_1.TerminalService)),
        __param(3, inversify_1.inject(browser_1.OpenerService)),
        __param(4, inversify_1.inject(browser_2.WorkspaceService)),
        __param(5, inversify_1.inject(preview_contribution_1.PreviewContribution)),
        __metadata("design:paramtypes", [Object, navigator_contribution_1.FileNavigatorContribution, Object, Object, browser_2.WorkspaceService,
            preview_contribution_1.PreviewContribution])
    ], ISCExtensionFrontendApplicationContribution);
    return ISCExtensionFrontendApplicationContribution;
}());
exports.ISCExtensionFrontendApplicationContribution = ISCExtensionFrontendApplicationContribution;
exports.ISCWhatisIrisCommand = {
    id: 'ISC.WhatisIrisCommand',
    label: "What is InterSystems IRIS"
};
exports.ISCTerminalCommand = {
    id: 'ISC.TerminalCommand',
    label: "InterSystems IRIS Terminal"
};
exports.ISCDocsCommand = {
    id: 'ISC.DocsCommand',
    label: "InterSystems IRIS Documentation"
};
exports.ISCPortalCommand = {
    id: 'ISC.PortalCommand',
    label: "InterSystems IRIS Management Portal"
};
exports.ISCLabsCommand = {
    id: 'ISC.LabsCommand',
    label: "InterSystems Learning Labs"
};
exports.ISCQuickStartsCommand = {
    id: 'ISC.QuickStartsCommand',
    label: "InterSystems QuickStarts"
};
exports.ISCFirstLooksCommand = {
    id: 'ISC.FirstLooksCommand',
    label: "InterSystems First Looks"
};
exports.ISCGettingStartedCommand = {
    id: 'ISC.GettingStartedCommand',
    label: "Getting Started"
};
exports.ISCConnectingCommand = {
    id: 'ISC.ConnectingCommand',
    label: "Connecting Your IDE to InterSystems IRIS"
};
exports.ISCContainersCommand = {
    id: 'ISC.ContainersCommand',
    label: "Running InterSystems Products in Containers"
};
exports.ISCLearningCommand = {
    id: 'ISC.LearningCommand',
    label: "InterSystems Online Learning"
};
exports.ISCSupportCommand = {
    id: 'ISC.SupportCommand',
    label: "InterSystems Support"
};
var ISCMenus;
(function (ISCMenus) {
    ISCMenus.INTERSYSTEMS = __spread(common_1.MAIN_MENU_BAR, ['8_intersystems']);
    ISCMenus.ISCHELP = __spread(common_1.MAIN_MENU_BAR, ['9_help']);
    ISCMenus.INTERSYSTEMS_SECTION1 = __spread(ISCMenus.INTERSYSTEMS, ['1_section']);
    ISCMenus.INTERSYSTEMS_SECTION2 = __spread(ISCMenus.INTERSYSTEMS, ['2_section']);
    ISCMenus.INTERSYSTEMS_SECTION3 = __spread(ISCMenus.INTERSYSTEMS, ['3_section']);
    ISCMenus.INTERSYSTEMS_SECTION4 = __spread(ISCMenus.ISCHELP, ['4_section']);
    ISCMenus.INTERSYSTEMS_SECTION5 = __spread(ISCMenus.ISCHELP, ['5_section']);
    ISCMenus.INTERSYSTEMS_SECTION6 = __spread(ISCMenus.ISCHELP, ['6_section']);
})(ISCMenus = exports.ISCMenus || (exports.ISCMenus = {}));
var ISCExtensionMenuContribution = /** @class */ (function () {
    function ISCExtensionMenuContribution(openerService) {
        this.openerService = openerService;
    }
    ISCExtensionMenuContribution.prototype.registerMenus = function (menus) {
        menus.registerSubmenu(ISCMenus.INTERSYSTEMS, 'InterSystems');
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION1, {
            commandId: exports.ISCWhatisIrisCommand.id,
            order: '0',
            label: 'What is InterSystems IRIS'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION2, {
            commandId: exports.ISCTerminalCommand.id,
            order: '0',
            label: 'InterSystems IRIS Terminal'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION2, {
            commandId: exports.ISCPortalCommand.id,
            order: '1',
            label: 'InterSystems IRIS Management Portal'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
            commandId: exports.ISCLabsCommand.id,
            order: '0',
            label: 'InterSystems Learning Labs'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
            commandId: exports.ISCQuickStartsCommand.id,
            order: '1',
            label: 'InterSystems QuickStarts'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION3, {
            commandId: exports.ISCFirstLooksCommand.id,
            order: '2',
            label: 'InterSystems First Looks'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION4, {
            commandId: exports.ISCGettingStartedCommand.id,
            order: '0',
            label: 'Getting Started'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION5, {
            commandId: exports.ISCConnectingCommand.id,
            order: '0',
            label: 'Connecting Your IDE to InterSystems IRIS'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION5, {
            commandId: exports.ISCContainersCommand.id,
            order: '1',
            label: 'Running InterSystems Products in Containers'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
            commandId: exports.ISCDocsCommand.id,
            order: '0',
            label: 'InterSystems IRIS Documentation'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
            commandId: exports.ISCLearningCommand.id,
            order: '1',
            label: 'InterSystems Online Learning'
        });
        menus.registerMenuAction(ISCMenus.INTERSYSTEMS_SECTION6, {
            commandId: exports.ISCSupportCommand.id,
            order: '2',
            label: 'InterSystems Support'
        });
    };
    ISCExtensionMenuContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(browser_1.OpenerService)),
        __metadata("design:paramtypes", [Object])
    ], ISCExtensionMenuContribution);
    return ISCExtensionMenuContribution;
}());
exports.ISCExtensionMenuContribution = ISCExtensionMenuContribution;
var ISCExtensionCommandContribution = /** @class */ (function () {
    function ISCExtensionCommandContribution(logger, openerService, preferences) {
        this.logger = logger;
        this.openerService = openerService;
        this.preferences = preferences;
    }
    ISCExtensionCommandContribution.prototype.registerCommands = function (registry) {
        var _this = this;
        registry.registerCommand(exports.ISCPortalCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.portal'])); }
        });
        registry.registerCommand(exports.ISCTerminalCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.terminal'])); }
        });
        registry.registerCommand(exports.ISCDocsCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.documentation'])); }
        });
        registry.registerCommand(exports.ISCWhatisIrisCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.whatisiris'])); }
        });
        registry.registerCommand(exports.ISCLabsCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.labs'])); }
        });
        registry.registerCommand(exports.ISCQuickStartsCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.quickstarts'])); }
        });
        registry.registerCommand(exports.ISCFirstLooksCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.firstlooks'])); }
        });
        registry.registerCommand(exports.ISCConnectingCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.connecting'])); }
        });
        registry.registerCommand(exports.ISCContainersCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.containers'])); }
        });
        registry.registerCommand(exports.ISCSupportCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.support'])); }
        });
        registry.registerCommand(exports.ISCLearningCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.learning'])); }
        });
        registry.registerCommand(exports.ISCGettingStartedCommand, {
            execute: function () { return browser_1.open(_this.openerService, new uri_1.default(_this.preferences['isc.url.gettingstarted'])); }
        });
    };
    ISCExtensionCommandContribution = __decorate([
        inversify_1.injectable(),
        __param(0, inversify_1.inject(common_1.ILogger)),
        __param(1, inversify_1.inject(browser_1.OpenerService)),
        __param(2, inversify_1.inject(isc_extension_preferences_1.ISCPreferences)),
        __metadata("design:paramtypes", [Object, Object, Object])
    ], ISCExtensionCommandContribution);
    return ISCExtensionCommandContribution;
}());
exports.ISCExtensionCommandContribution = ISCExtensionCommandContribution;
//# sourceMappingURL=isc-extension-contribution.js.map