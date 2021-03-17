# PUG CLI

CLI interface for [pug](https://pugjs.org/).

## Setup

```bash
npm install -g @fcostarodrigo/pug-cli
```

## Usage

```bash
pug [options] [..files]
```

| Command                | Description                                          | Type                                |
| ---------------------- | ---------------------------------------------------- | ----------------------------------- |
| files                  | Files and folders to compile.                        | [default: ["."]]                    |
| --help                 | Show help                                            | [boolean]                           |
| --version              | Show version number                                  | [boolean]                           |
| -w, --watch            | Watch for changes                                    | [boolean]                           |
| -o, --out              | Output directory                                     | [string] [default: "."]             |
| -c, --config           | Configuration file path                              | [string]                            |
| -i, --ignore           | Path of file containing patterns like gitignore      | [string] [default: ".pugignore"]    |
| -e, --extensions       | List of extensions to compile                        | [array] [default: [".jade",".pug"]] |
| --options.basedir      | The root directory of all absolute inclusion         | [string]                            |
| --options.doctype      | Doctype to include in the templates if not specified | [string]                            |
| --options.self         | Use a self namespace to hold the locals              | [boolean]                           |
| --options.debug        | Log tokens and functions to stdout                   | [boolean]                           |
| --options.compileDebug | Include function source in the compiled template     | [boolean]                           |

Folders are searched for `.pug` and `.jade` files and `node_modules` is ignored by default.

The arguments prefixed with `options` are passed directly to pug, those options are used as local variables in pug templates as well.

Extra arguments prefixed with `options` are also passed to pug.

```bash
pug --options.message=hello
```

```pug
div= message
```

```html
<div>hello</div>
```

## Config file

You can also use config files to pass options.
The formats supported are "json", "yaml", "js", "coffee", "toml", and "ts".
The file name must be `.pugrc.ext` where `ext` is one of the supported extensions or no extension for yaml and json.
For the scripts, you can also use `pug.config.ext`.
And you can include a `pug` property in your `package.json` as well.

The configuration file will be resolved starting from the location of the file being compiled, and searching up the file tree until a config file is (or isn't) found.

Command line options take precedence over config file options.

You can use script config files to pass functions to the filter option.

```js
module.exports = {
  options: {
    filters: {
      upperCase: function (text) {
        return text.toUpperCase();
      },
    },
  },
};
```

```pug
div
  :upperCase
    Hello World!
```

```html
<div>HELLO WORLD!</div>
```

Tip: You can import other config files to inherit and extend configurations.

## Environment variables

You can also pass options with environment variables.

All environment variables prefixed with `PUG_` are used, the pug prefix is ignored and the option is camelCased.

You can also add a `.env` file with the environment variables.

Environment variables take precedence over config file options, but not command line arguments.

To pass options to pug directly prefix the variable with `PUG_OPTIONS__`.

```bash
PUG_OPTIONS__MESSAGE_TEXT=hello pug
```

```pug
div= messageText
```

```html
<div>hello</div>
```

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)
