# cm-update-server-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cm-update-server']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

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

The current testing environment requires Docker.

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

## License and Authors

Author:: Patrick Connolly (patcon) \<patrick.c.connolly@gmail.com\>
