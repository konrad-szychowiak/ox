<center>
:x::o:
</center>

# xo

`xo` is a simple, bash-driven, console :x: cross and :o: circle :video_game: game.

> Currently available only in polish [`PL_pl`].

## Installation

Enable executing the file.

```sh
chmod u+x xo
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

3. Now move or link `xo` to one of those PATH directories. I highly suggest something local like mentioned `/home/$USER/bin` or `/home/$USER/.local/bin`.

4. Now you can accesses `xo` from every place.

## Usage

```sh
# without adding to PATH
./xo -h

# with
xo -h
which xo # should return the path to the directory you've chosen
```

### Options

```
Składnia: xo [OPCJA [ARGUMENT] …]
Prosta gra w kółko i krzyżyk z komputerem.
Komputer gra losowo, więc gracz ma większe szanse na wygraną.
-h, --help	wyświetla tę pomoc i kończy działanie skryptu
-q, --quiet	nie pokazuje logów
-u		użytkownik zaczyna grę (DOMYŚLNE)
-c		komputer zaczyna grę
-x		gracz gra krzyżykiem (DOMYŚLNE)
-o		gracz gra kółkiem

Opcje z argumentami:
-X ZNAK		zastępuje domyslny znak krzyżyka (X) przez ZNAK
-O ZNAK		zastępuje domyslny znak kółka (O) przez ZNAK

```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
