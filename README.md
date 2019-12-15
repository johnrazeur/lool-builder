# Lool builder

A simple tool to build all you need to create a libreoffice online docker image !

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
make change-version LIBREOFFICE_BRANCH="libreoffice6-4"
```

And now you can run the build, this command will compile poco, libreoffice core and libreoffice online:
```
sudo make
```

Create the docker image:
```
sudo make release
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