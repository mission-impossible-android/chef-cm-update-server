# cm-update-server-cookbook

[![Build Status](https://travis-ci.org/mission-impossible-android/chef-cm-update-server.svg)](https://travis-ci.org/mission-impossible-android/chef-cm-update-server)

This Chef cookbook provisions a simple instance of the unofficial
[cm-update-server](https://github.com/xdarklight/cm-update-server), for
distributing custom ROM updates (full & incremental) via the [CMUpdater
app](https://github.com/CyanogenMod/android_packages_apps_CMUpdater).

## Supported Platforms

* Ubuntu 14.04 LTS

## Attributes

| Key | Default |
|-----|---------|
| `['cm_update_server']['install_path']` | `/opt/nodejs/cm-update-server` |
| `['cm_update_server']['git_url']` | `https://github.com/xdarklight/cm-update-server.git` |
| `['cm_update_server']['git_revision']` | `master` |

## Usage

### cm-update-server::default

Include `cm-update-server` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cm-update-server::default]"
  ]
}
```

## Testing

We can run test-kitchen infrastructure tests either locally (with
Docker), or remotely (with EC2). We also run remote tests via Travis CI.

#### Local

This local testing environment requires Docker.

```
bundle install

# Individual commands
bundle exec kitchen create
bundle exec kitchen converge
bundle exec kitchen verify
bundle exec kitchen destroy

# (Alternate) All-in-one command
bundle exec kitchen test
```

#### Remote (EC2)

The remote testing environment requires an AWS account and some setup.

1. Create an **AWS user** (eg. `travis-kitchen`): https://console.aws.amazon.com/iam/home#users
2. **Attach Policy** "AmazonEC2FullAccess" to user: https://console.aws.amazon.com/iam/home#users/travis-kitchen
3. Import/create a **named SSH keypair**: https://console.aws.amazon.com/ec2/v2/home#KeyPairs

```txt
cp .kitchen.travis.yml .kitchen.local.yml

[sudo] pip install awscli
aws configure --profile travis-kitchen
# Follow prompts using AWS credentials created above

export AWS_PROFILE=travis-kitchen
export AWS_SSH_KEY_ID=<keypair name>

bundle exec kitchen test
```

(Optional) For running Travis CI tests, you'll need to create a new
keypair and download the private key (step #3 above), then store an
encrypted copy in the repo (See `travis.yml` for details):

    [sudo] gem install travis
    cd path/to/repo
    travis encrypt-file path/to/downloaded/id_rsa
    mv id_rsa.enc test/id_rsa.enc

## License and Authors

Author:: Patrick Connolly (patcon) \<patrick.c.connolly@gmail.com\>
