# Lool builder

A simple tool to build all you need to create a libreoffice online docker image !

## Prerequisites

You only need docker, git and make to use this tool !

## Installation

```
git clone https://github.com/johnrazeur/lool-builder.git
```

## Usage

First download source

```
make get-source
```

Optionally, you can change the version of libreoffice (default version is master)

```
make change-version LIBREOFFICE_BRANCH="libreoffice-6-4" LIBREOFFICE_ONLINE_BRANCH="cp-4.2.3-3"
```

And now you can run the build, this command will compile poco, libreoffice core and libreoffice online:
```
sudo make
```

Create the docker image:
```
sudo make release
```

You can also specify your image name and tag
```
sudo make release IMAGE_NAME=myimagename IMAGE_TAG=myimagetag
```

## Archive

You can archive the build of libreoffice core (which is really long) to reuse it to compile libreoffice online. You must have [brotli](https://github.com/google/brotli) installed.

First create the archive

```
make archive-libreoffice
```

You can give your archive `lo.tar.br` to someone, place it in the root directory, and restore it:

```
make restore-libreoffice
```
