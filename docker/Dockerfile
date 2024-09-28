FROM homebrew/brew

LABEL authors="Marcel Strahl <info@marcel-strahl.de>"

COPY src/install.sh /usr/local/bin/install.sh
COPY src/uninstall.sh /usr/local/bin/uninstall.sh
COPY tests/test_install.bats /usr/local/bin/test_install.bats
COPY tests/test_uninstall.bats /usr/local/bin/test_uninstall.bats

# Update Homebrew and install necessary packages
RUN brew update && \
    brew tap shivammathur/php && \
    brew install php@8.1 && \
    brew install php@8.2 && \
    brew install php@8.3 && \
    brew install bats-core && \
    # Clean up Homebrew cache to reduce image size
    brew cleanup

EXPOSE 9000

CMD ["php", "-a"]