COMMIT=test
DOCKER_COMPOSE_TEST=docker compose -f docker-compose.yaml
DOCKER_COMPOSE_PHPFLEX_FUNCTION_TEST=docker compose -f docker-compose.phpflextest.yaml

.PHONY: test
test:
	${DOCKER_COMPOSE_TEST} run --rm phpflex bats tests/test_install.bats tests/test_uninstall.bats
	${DOCKER_COMPOSE_PHPFLEX_FUNCTION_TEST} run --rm phpflextest bats tests/test_phpflex.bats
