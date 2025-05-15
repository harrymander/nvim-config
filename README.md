# Neovim configuration

1. Clone to `~/.local/config/nvim`.
2. Create a virtualenv under `~/.local/config/nvim/.venv` and install the
   packages in `requirements.txt` into it:

   ```
   python3 -m venv .venv
   .venv/bin/python3 -m pip install -r requirements.txt
   ```

   Or using `uv`:

   ```
   uv venv --seed
   uv pip install -r requirements.txt
   ```
3. Open `nvim` and run `:checkhealth` command.
