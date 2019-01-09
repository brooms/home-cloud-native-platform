# Install pip

See https://pip.pypa.io/en/stable/installing/

Add the following to '~/.profile’ (or equivalent) file:

```bash
# include path for pip
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
```

Get pip

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
python3 get-pip.py --user
```
