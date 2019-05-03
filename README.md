# Akamai Developer World Tour Environment

Environment setup for Akamai Developer World Tour.

## License

[Apache License 2.0](LICENSE) 

## Build the Image

To build the *Launchpad + Theia combo image*, go to the
root folder and run the following:

```
$ docker build -t akamai/launchpad_theia .
```

To build the base Theia image:

```
$ cd theia/ 
$ docker build -t akamai/theia:latest
```

# Local Development 

Do your local development and build the Theia application on your 
host. Development of this app in Docker is cumbersome.

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

## Note 

Note that we don't really seem to be using the /home/project inside the image
as we should. Everything is copies to /home/theia, both Akamai examples and the
actual Theia app which is less than ideal because it shows up in the Theia file
browser. If there's enough time, those two things should be separated into two
different home folders. I suggest we use the theia one for saving the theia app
and maybe /home/akamai for saving example files.
