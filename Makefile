libilluminate-support.so:
	./bpc-prepare.sh src.list
	$(MAKE) -C ./Illuminate libilluminate-support

libilluminate-support:
	bpc -v \
		-c bpc.conf  \
		-l illuminate-support \
		-u psr-container        \
		-u illuminate-contracts \
		-u doctrine-inflector   \
		-u symfony-polyfill-php80           \
		-u symfony-contracts-translation    \
		-u php-hash                         \
		-u symfony-component-translation    \
		-u carbon                           \
		--input-file src.list

install-libilluminate-support:
	cd Illuminate && bpc -l illuminate-support --install
