pleaserun Cookbook
==================
A library cookbook to help interact with pleaserun.

Requirements
------------

Shouldn't require anything special.


Attributes
----------

* `node['pleaserun']['platform']` - which platform to use.  e.g. 'upstart', 'runit', 'sysv'

TODO: List you cookbook attributes here.

Usage
-----
#### pleaserun::default

Just include `pleaserun` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pleaserun]"
  ]
}
```

#### lwrp


```
include_recipe 'pleaserun::default'

pleaserun 'test' do
  name        'test'
  program     '/bin/echo'
  args        [ 'hello', 'world' ]
  description 'test app'
  action      :create
end
```

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 

* Paul Czarkowski ( username.taken@gmail.com)

License:

Apache2 blurb goes here.
