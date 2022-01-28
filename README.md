# dotfiles_update
A simple bash script to update dotfiles

Usage
----------------
Edit config file, add absolute path (no environment variable, no "~") of each config directory or file that you want to synchronize.

To update the config files in the repo, issue the following command
```bash
bash update_repo.sh pull
```

To update the system's config files based on the repo config, issue the following command
```bash
bash update_repo.sh push
```

To clear the repo config files, issue the following
```bash
bash update_repo.sh clear
```
