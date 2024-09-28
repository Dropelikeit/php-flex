# PHPFlex

PHPFlex is a powerful command-line tool that allows developers to seamlessly switch between multiple PHP versions on their local environment. It provides a simple way to specify the desired PHP version for running commands or scripts, making it ideal for testing, development, and debugging across various PHP environments.

# _Features_:

- Version Switching: Instantly switch to any installed PHP version (e.g., 8.1, 8.2, 8.3) without changing system settings.
- Command Execution: Run any PHP command or script with the specified version directly from the terminal.
- User-friendly: Single function for all versions, simplifying multi-version management.
- Error Handling: Clear error messages if the specified PHP version is not found.

```bash
# Check the PHP version for 8.1
phpFlex 8.1 -v

# Run a PHP script with version 8.2
phpFlex 8.2 myscript.php

# Execute an inline PHP command with version 8.3
phpFlex 8.3 -r 'echo "Hello, PHP 8.3!";'
```

# Installation

---
To start using PHPFlex, execute the script `install.sh`. It checks whether you are using bash or zsh and installs PHPFlex to your configuration file.

*Hint:* It is important that you reload your configuration after installation to use PHPFlex.

Sometimes it is necessary to set the correct permission to run the script
```bash
chmod -x install.sh && \
./install.sh \
source ~/<.zshrc | .bashrc>
```

# Uninstall

---

To stop using PHPFlex, run the script `uninstall.sh`. It create a backup file of your configuration before PHPFlex is removed.

*Hint:* It is important to reload your configuration to remove PHPFlex from your current commandline session.

Sometimes it is necessary to set the correct permission to run the script
```bash
chmod -x uninstall.sh && \
./uninstall.sh \
source ~/<.zshrc | .bashrc>
```

# Tests

---

The scripts `install.sh` and `uninstall.sh` in the dir `src` are tested with [bats](https://bats-core.readthedocs.io/en/stable/).

To ensure that your configuration files (.zshrc or .bashrc) are not changed or even rendered unusable by the tests, a Docker image was added to the project. The tests should only be executed within the Docker container, otherwise the tests could change or even delete their configuration file.

The Docker image is based on an Ubuntu image with Homebrew installed.

If you want to run the tests, you only need to execute the following command:

```bash
make test
```

When the command is executed, a Docker container is built and the tests are executed in it.

# Contributions

---

Help us to improve this project by reporting bugs, enhancement requests or other suggestions via the issue tracker.

After creating the issue tracker, it is also possible to create a PR with reference to the issue.

Thank you very much for your support!