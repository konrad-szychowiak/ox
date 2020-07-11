# ox

`ox` is a simple, bash-driven, console :o: noughts and crosses :x: :video_game: game.

## Installation

Enable executing the file.

```bash
chmod u+x ox
```

### `PATH`

If you really want, you can add `xo` to your PATH.

1. Open your terminal and check the PATH variable:

   ```bash
   echo $PATH
   ```

2. You will find a list of directories on your path, witch looks like this (more or less):

   ```
   /path/to/some/directory:…:/and/here/to/some/other/one
   ```

   It's likely, that you will find a directory like `/home/$USER/bin` or `/home/$USER/.local/bin`. (`$USER` will be your username in the system.)

3. Now move or link `ox` to one of those PATH directories. I highly suggest something local like mentioned `/home/$USER/bin` or `/home/$USER/.local/bin`.

4. Now you can accesses `xo` from every place.

## Usage

```sh
# without adding to PATH
./ox -h

# with PATH
ox -h
which ox # should return the path to the directory you've chosen
```

### Flags

| short | long      |                                    |
| ----- | --------- | ---------------------------------- |
| `-q`  | `--quiet` | does not print game logs           |
| `-h`  | `--help`  | prints this help message and exits |
| `-u`  | _n/a_     | **u**ser starts the game (DEFAULT) |
| `-c`  | _n/a_     | **c**pu starts the game            |
| `-x`  | _n/a_     | user plays crosses (DEFAULT)       |
| `-o`  | _n/a_     | user plays noughts                 |

### Options

Options take arguments to tweak how your session will work.

| option      |                                                  |
| ----------- | ------------------------------------------------ |
| `-X SYMBOL` | changes default symbol 'X' for crosses by SYMBOL |
| `-O SYMBOL` | changes default symbol 'O' for noughts by SYMBOL |

> `SYMBOL` can be any character supported by your terminal emulator.
> Colors are used to distinguish user's (red) and cpu's (blue) symbols.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
