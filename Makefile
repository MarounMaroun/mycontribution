INSTALL_PATH = /usr/local/bin/mycontribution

.PHONY: install
install:
	@sudo cp -f mycontribution.sh $(INSTALL_PATH)
	@sudo chmod +x $(INSTALL_PATH)
	@echo "Done installing!"

.PHONY: uninstall
uninstall:
	@sudo rm -f $(INSTALL_PATH)
	@echo "Done uninstalling!"

.PHONY: test
test:
	bash tests/test.sh
