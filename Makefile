TAG = $$(git describe --tags --abbrev=0)


.PHONY: init
init:
	git submodule update --init --recursive

.PHONY: audit_fix
audit_fix:
	bun run yarn-audit-fix

.PHONY: release_prepatch
release_prepatch:
	git stash
	$(eval NEW_TAG := $(shell npm version prepatch))
	git tag -d $(TAG)
	cd katex && npm version prepatch
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: release_preminor
release_preminor:
	git stash
	$(eval NEW_TAG := $(shell npm version preminor))
	git tag -d $(TAG)
	cd katex && npm version preminor
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: release_prerelease
release_prerelease:
	git stash
	$(eval NEW_TAG := $(shell npm version prerelease))
	git tag -d $(TAG)
	cd katex && npm version prerelease
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: release_patch
release_patch:
	git stash
	$(eval NEW_TAG := $(shell npm version patch))
	git tag -d $(TAG)
	cd katex && npm version patch
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: release_minor
release_minor:
	git stash
	$(eval NEW_TAG := $(shell npm version minor))
	git tag -d $(TAG)
	cd katex && npm version minor
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: release_major
release_major:
	git stash
	$(eval NEW_TAG := $(shell npm version major))
	git tag -d $(TAG)
	cd katex && npm version major
	git reset HEAD^ && git add . && git commit -m $(NEW_TAG) && git tag $(NEW_TAG)

.PHONY: analyze
analyze:
	bun i && bun run analyze

.PHONY: analyze_katex
analyze_katex:
	cd katex && bun i && bun run analyze

.PHONY: build
build: build_js build_css build_js_katex build_css_katex

.PHONY: build_js
build_js:
	bun i && bun run build

.PHONY: build_js_katex
build_js_katex:
	mv src/index.tsx src/index.tsx.tmp
	cd katex && bun i && bun run build
	mv src/index.tsx.tmp src/index.tsx

.PHONY: build_css
build_css:
	bun i
	bun run build-default-css
	bun run build-dark-css
	bun run build-darkbronco-css
	bun run build-dorkula-css
	bun run build-chesterish-css
	bun run build-grade3-css
	bun run build-gruvboxd-css
	bun run build-gruvboxl-css
	bun run build-monokai-css
	bun run build-oceans16-css
	bun run build-onedork-css
	bun run build-solarizedd-css
	bun run build-solarizedl-css

.PHONY: build_css_katex
build_css_katex:
	cd katex && bun i
	cd katex && bun run build-default-css
	cd katex && bun run build-dark-css
	cd katex && bun run build-darkbronco-css
	cd katex && bun run build-dorkula-css
	cd katex && bun run build-chesterish-css
	cd katex && bun run build-grade3-css
	cd katex && bun run build-gruvboxd-css
	cd katex && bun run build-gruvboxl-css
	cd katex && bun run build-monokai-css
	cd katex && bun run build-oceans16-css
	cd katex && bun run build-onedork-css
	cd katex && bun run build-solarizedd-css
	cd katex && bun run build-solarizedl-css

.PHONY: storybook
storybook:
	bun i && bun run storybook
