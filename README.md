# Domainr::CLI2

Search for domains using [Domainr](https://domainr.com/) from the command line. Built on top of [stve/domainr](https://github.com/stve/domainr).

## Installation

Install with:

```
$ gem install domainr-cli2
```

## Setup

**NOTE:** You'll need a [Mashape API key](https://github.com/domainr/api/wiki) before you start.

Once you have your key, set it once and forget it:

```
$ domainr api_key <your-api-key-here>
```

## Usage

Use the `search` command to look for domains:

```
$ domainr search awesomeness
+-------------+-----------------+------------------------+
| Status      | Domain          | Path                   |
+-------------+-----------------+------------------------+
| UNAVAILABLE | awesomeness.com | http://awesomeness.com |
| UNAVAILABLE | awesomeness.net | http://awesomeness.net |
| DELETING    | awesomeness.org | http://awesomeness.org |
| UNAVAILABLE | awesomeness.us  | http://awesomeness.us  |
| UNAVAILABLE | awesomen.es     | http://awesomen.es/s   |
| UNKNOWN     | awesome.ne      | http://awesome.ne/ss   |
| PREMIUM     | aweso.men       | http://aweso.men/ess   |
| UNAVAILABLE | aweso.me        | http://aweso.me/ness   |
| UNAVAILABLE | awes.om         | http://awes.om/eness   |
| UNAVAILABLE | awe.so          | http://awe.so/meness   |
| UNAVAILABLE | aw.es           | http://aw.es/omeness   |
| UNAVAILABLE | aw              | http://aw/esomeness    |
+-------------+-----------------+------------------------+
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrisb/domainr-cli2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
