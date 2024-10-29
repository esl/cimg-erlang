# cimg-erlang

Multi-purpose Docker images with the [Erlang](https://www.erlang.org/) programming language installed. They are built on demand by Erlang Solutions.

They include:
- CircleCI convenience images based on [cimg/base](https://circleci.com/developer/images/image/cimg/base) that can be used to execute CircleCI jobs. See [Convenience images](https://circleci.com/docs/circleci-images/) for details.
- Ubuntu, Debian, Rocky Linux and AlmaLinux. These are used to build software packages, e.g. for [MongooseIM](https://github.com/esl/mongooseim).

## Usage

The simplest way is to use the images from the [`erlangsolutions/erlang`](https://hub.docker.com/repository/docker/erlangsolutions/erlang/general) repo.

- CircleCI images are tagged as `cimg-${ERLANG_VERSION}`, e.g. `cimg-27.1.2`, and you can use them in the CircleCI docker executor.
- Other images are tagged as `${OS}-${RELEASE}-${ERLANG_VERSION}`, e.g. `ubuntu-jammy-27.1.2`, and they can be used to build, package and run Erlang software.

## Build procedure

You can also clone the [esl/cimg-erlang](https://github.com/esl/cimg-erlang) repository, and build the Docker image yourself with `build.sh`:

```bash
$ OTP_VERSION=27.1.2 BASE_IMAGE=ubuntu:jammy ./build.sh
```

Note that only selected Linux distributions are supported (see [`tools/prepare.sh`](https://github.com/esl/cimg-erlang/blob/master/tools/prepare.sh)).

## Trigger build using "Trigger pipeline" on CircleCI

If you are a member of Erlang Solutions, you can trigger a CI build.

Go to the CircleCI project page, select branch: [CircleCI](https://app.circleci.com/pipelines/github/esl/cimg-erlang?branch=master).

Press the button:

![Tigger pipeline button](trigger-pipeline.png "Trigger pipeline")

Fill the parameters:

![Set otp-version](pipeline-build.png "Set otp-version")
