help:
	@echo See README.make

all:
	$(MAKE) -C ladr lib
	$(MAKE) -C mace4.src
	$(MAKE) -C provers.src
	$(MAKE) -C apps.src
	$(MAKE) -C utilities
	@echo ""
	@echo "**** Now try 'make test1'. ****"
	@echo ""

ladr lib:
	$(MAKE) -C ladr lib

test1:
	bin/prover9 -f prover9.examples/x2.in | bin/prooftrans parents_only
	@echo ""
	@echo "**** If you see a proof, prover9 is probably okay. ****"
	@echo "**** Next try 'make test2'. ****"
	@echo ""

test2:
	bin/mace4 -v0 -f mace4.examples/group2.in | bin/interpformat tabular
	@echo ""
	@echo "**** If you see a group table, mace4 is probably okay. ****"
	@echo "**** Next try 'make test3'. ****"
	@echo ""

test3:
	bin/mace4 -n3 -m -1 < apps.examples/qg.in | bin/interpformat | bin/isofilter
	@echo ""
	@echo "*** If you see 5 interpretations, the apps are probably okay. ***"
	@echo ""
	@echo "*** All of the programs are in ./bin, and they can be copied anywhere you like. ***"
	@echo ""

clean:
	$(MAKE) -C ladr realclean
	$(MAKE) -C apps.src realclean
	$(MAKE) -C mace4.src realclean
	$(MAKE) -C provers.src realclean

realclean:
	$(MAKE) clean
	/bin/rm -R -f bin


# The following cleans up, then makes a .tar.gz file of the current
# directory, leaving it in the parent directory.  (Gnu make only.)

DIR = $(shell basename $(PWD))

dist:
	which gzip
	$(MAKE) realclean
	cd .. && tar cvf $(DIR).tar $(DIR)
	gzip -f ../$(DIR).tar
	ls -l ../$(DIR).tar.gz
