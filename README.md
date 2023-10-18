# Neovim Setup Script

This script automates the process of setting up Neovim with essential plugins and configuration for a productive code editing environment. It is designed to work on macOS and Linux, specifically on systems using Homebrew (macOS) or APT (Linux) for package management.

## Features

- Installs Neovim.
- Sets up basic Neovim configuration.
- Installs and configures essential plugins:
  - YouCompleteMe for code completion.
  - coc.nvim for Language Server Protocol (LSP) support.
  - Gruvbox color scheme.
  - Autopairs for automatic pair insertion.
  - Lightline for a status line.
- Supports JavaScript, Python, C, and C++ by configuring YouCompleteMe.

## Usage

1. Clone this repository or download the script.
2. Make the script executable:

   ```bash
   chmod +x neovim_setup.sh
   ```

3. Run the script:

   ```bash
   ./neovim_setup.sh
   ```

4. The script will install Neovim, set up the configuration, install the plugins, and configure YouCompleteMe for JavaScript, Python, C, and C++.

5. After the script completes, open Neovim to start using your newly configured environment.

## Troubleshooting

- If you encounter any issues during the setup, please check the log file `neovim_setup.log` for detailed information about errors or problems that may have occurred.

## Customize

You can customize the script by editing it to include additional plugins, configurations, or support for different languages.

## License

This script is provided under the [MIT License](LICENSE). You are free to use, modify, and distribute it as needed.

**Note:** Ensure you have a backup of your existing Neovim configuration if you intend to use this script on an existing setup.

Enjoy your Neovim setup!
