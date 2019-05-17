# Akamai Developer World Tour Environment

Environment setup for Akamai Developer World Tour.

This README includes all the extant docs.

Table of Contents
=================

* [License](#license)
* [Build the Image](#build-the-image)
* [Local Development](#local-development)
* [Customizations](#customizations)
        * [Overview](#overview)
        * [Modify default file browser and terminal behavior](#modify-default-file-browser-and-terminal-behavior)
        * [Modify the Preview Pane](#modify-the-preview-pane)
        * [Modify menu items](#modify-menu-items)
* [Misc TODO](#misc-todo)

## License

[Apache License 2.0](LICENSE) 

## Build the Image

To build the *Launchpad + Theia combo image*, go to the
root folder and run the following:

```
$ docker build -t akamai/launchpad-theia .
```

The above command will build the Akamai (i.e., "launchpad-theia") image FROM the customized Theia image ("akamai-theia").

*Note: This command assumes that you are authenticated with our private
registry. If you are not, follow these [instructions][gce-auth].*

To build the base Theia image:

```
$ cd theia/ 
$ docker build -t akamai/theia:latest
```

*It's best always to build from a tagged version of the base Theia image. You can of course build the Theia image from different Git commits within the repo and build the launchpad-theia image on top of that modified base image.*

## Push the image to AVL 

Tag your image with the prefix `gcr.io/akamai-virtual-labs/` and then push it. From there, follow [our help docs][avl-help-pull] on pulling the image into your AVL cluster.

## Local Development 

Do your local development and build the Theia application on your 
host. For the moment, development of this app in Docker is cumbersome.

Navigate to the extension directory:

```
$ cd theia/akamai-theia-extension 
```

Watch the extension files: 

```
$ cd akamai-extension && yarn watch 
```

Start a new shell, then watch the browser files:

```
$ cd browser-app && yarn watch 
```

Start another shell, then run the Theia app: 

```
$ cd browser-app && yarn start 
```

Navigate to localhost:3000 in an incognito window (NOT a regular window!). 

Make your changes and then build the Docker image per the instructions (far) above.

## Customizations 

### Overview 

Understanding a few basic aspects of the (complex!) Theia extension architecture should get you started. 

To create an extension object, export a class object which itself implements a Theia base classes (e.g., we do this [here][extension-base-class]) and then register your class (e.g., [here][extension-base-class-register]). 

All Theia customizations happen in [`theia/akamai-extension/akamai-theia-extension/akamai-extension/src/browser/akamai-theia-extension-contribution.ts`][extension-contribution]. 

See more at the (marginally helpful) [Theia extension docs][theia-extension-docs].

### Modify default file browser and terminal behavior

The file browser opens when Theia loads; modify this 
behavior in the [`initializeLayout` method][filebrowser-open].

The in-browser terminal loads in the [`onStart` method][terminal-open].

### Modify the Preview Pane

Enable the Preview Pane or change its URL in the [`initializeLayout` method][preview-pane].

### Remove menu items

Remove menu items in the [`onStart` method][menu-items].

### Add menu items 

The [`AkamaiExtensionMenuContribution`][akamai-menu] adds the Akamai menu item.

## Misc TODO

- [ ] Docs: Write a basic overview of the extension 
- [ ] Docs: Write a basic overview of Theia extension architecture
- [ ] Expand the docs to highlight further possible customization of the Theia UI
- [ ] Reserve the `/home/theia/` directory for Theia itself 

We don't really seem to be using the /home/project inside the image
as we should. Everything is copies to /home/theia, both Akamai examples and the
actual Theia app which is less than ideal because it shows up in the Theia file
browser. If there's enough time, those two things should be separated into two
different home folders. I suggest we use the theia one for saving the theia app
and maybe /home/akamai for saving example files.

[akamai-menu]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L85
[avl-help-pull]: https://help.appsembler.com/article/160-importing-container-registry
[extension-base-class]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L17
[extension-base-class-register]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-frontend-module.ts#L17
[extension-contribution]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts
[filebrowser-open]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L51-L54
[gce-auth]: https://help.appsembler.com/article/374-gcr
[menu-items]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L32-44
[terminal-open]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L32-34
[theia-extension-docs]: https://www.theia-ide.org/doc/Authoring_Extensions.html
[preview-pane]: ./theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L56-57
