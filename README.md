# Akamai Developer World Tour Environment

Environment setup for Akamai Developer World Tour.

## License

[Apache License 2.0](LICENSE) 

## Build the Image

To build the *Launchpad + Theia combo image*, go to the
root folder and run the following:

```
$ docker build -t akamai/launchpad-theia .
```

To build the base Theia image:

```
$ cd theia/ 
$ docker build -t akamai/theia:latest
```

## Local Development 

Do your local development and build the Theia application on your 
host. For the moment, development of this app in Docker is cumbersome.

cd to the extension directory:

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

## Customizations 

### Overview 

All Theia customizations happen in `theia/akamai-extension/akamai-theia-extension/akamai-extension/src/`. 

- Theia calls the onStart function at runtime https://github.com/appsembler/launchpad/blob/bb1d7dd93f5db4182753e8b098274a83cb96a60b/theia/akamai-theia-extension/akamai-extension/src/browser/akamai-extension-contribution.ts#L30

The custom extension handles the following actions:

### Modify default file browser and terminal behavior

The file browser opens when Theia loads. Modify this 
behavior in the [`initializeLayout` method](./theia/akamai-extension/akamai-theia-extension/akamai-extension/src/akamai-extension-contribution.ts#L51-L54).

The terminal browser loads in the [`onStart` method](./theia/akamai-extension/akamai-theia-extension/akamai-extension/src/akamai-extension-contribution.ts#L32-34).

### Modify the Preview Pane

Enable the Preview Pane or change its URL in the [`initializeLayout` method](./theia/akamai-extension/akamai-theia-extension/akamai-extension/src/akamai-extension-contribution.ts#L56-57)

### Modify menu items

Remove menu items in the [`onStart` method](./theia/akamai-extension/akamai-theia-extension/akamai-extension/src/akamai-extension-contribution.ts#L32-44).

## Misc TODO

- [ ] Docs: Write a basic overview of the extension 
- [ ] Docs: Write a basisc overview of Theia extension architechture
- [ ] Expand the docs to highlight further possible customization of the Theia UI
- [ ] Reserve the `/home/theia/` directory for Theia itself 

We don't really seem to be using the /home/project inside the image
as we should. Everything is copies to /home/theia, both Akamai examples and the
actual Theia app which is less than ideal because it shows up in the Theia file
browser. If there's enough time, those two things should be separated into two
different home folders. I suggest we use the theia one for saving the theia app
and maybe /home/akamai for saving example files.
