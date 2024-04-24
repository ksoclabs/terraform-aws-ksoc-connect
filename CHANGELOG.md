# Changelog

All notable changes to this project will be documented in this file.

## [1.5.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.4.1...v1.5.0) (2024-04-24)


### Features

* Adds sts:TagSession to allowed actions of ksoc-connect policy document ([b0ff6b7](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/b0ff6b7f204e88a96587c95658af3f3f02a99f5a))

### [1.4.1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.4.0...v1.4.1) (2024-04-12)


### Bug Fixes

* Create releases on documentation changes ([8fa5aa9](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/8fa5aa951237b4f72ea6f46524a5331a48232c67))
* Update link in README to multi-region examples ([cf2546f](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/cf2546f05e1b8a154b40ceb8983ba719f78c48aa))

## [1.4.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.3.0...v1.4.0) (2024-04-12)


### Features

* Add support for multi-region EKS audit logs pipeline ([9da7429](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/9da7429599174655b650e372949dc7e8b7828ab2))

## [1.3.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.2.2...v1.3.0) (2024-02-28)


### Features

* Enable versioning for audit logs bucket ([d59d30a](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/d59d30a2d6405df15844e0da2801436b00f71299))

### [1.2.2](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.2.1...v1.2.2) (2024-02-21)


### Bug Fixes

* Update README ([#26](https://github.com/ksoclabs/terraform-aws-ksoc-connect/issues/26)) ([87c9bf7](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/87c9bf7fddaffd330fd0218084ef5c98ec4483f1))

### [1.2.1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.2.0...v1.2.1) (2024-02-16)


### Bug Fixes

* More recent AWS provider is needed for EKS Audit Logs ([5d547d9](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/5d547d93f5cdbff4453c6b285be2be57d89b665c))

## [1.2.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.1.1...v1.2.0) (2024-02-15)


### Features

* Add EKS audit logs pipeline resources ([a978210](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/a9782108ccce5cc187aaf7abbaccc9cb1511d48c))

### [1.1.1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.1.0...v1.1.1) (2024-01-30)


### Bug Fixes

* Updates missing IAM action and removes one that does not exist ([69e8e3d](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/69e8e3d0e7e7c2947e20b474a5481f51cc6c6c0c))

## [1.1.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.0.5...v1.1.0) (2024-01-30)


### Features

* Use specific IAM actions instead of full ReadOnly access ([3cbeb29](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/3cbeb29355cf5e8b580fff247b14e8cfd3221fa1))

### [1.0.4](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.0.3...v1.0.4) (2023-08-23)


### Bug Fixes

* Fix line endings ([2d00057](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/2d00057d4a987391f82c86de95c5912d1eafbe37))
* Remove ksoc_account_id from provider ([9307197](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/93071978a3c1994982a9b2de1def508d08bb66fd))

### [1.0.3](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.0.2...v1.0.3) (2023-08-21)


### Bug Fixes

* Updates module to use new format of provider ([856428a](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/856428a6242130d0186e9c3646e8e005662c864d))

### [1.0.2](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.0.1...v1.0.2) (2023-08-17)


### Bug Fixes

* Moves hardcoded strings within the module into variables ([d92d2c6](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/d92d2c6f16da8db8031d34e9d94e85fe6e7e0103))
* Updates example to use the correct required_providers with KSOC ([e5b20fc](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/e5b20fcaaea64a9888c8206f2ef21ae012b02fa5))

### [1.0.1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v1.0.0...v1.0.1) (2023-08-07)


### Bug Fixes

* removing un-used cloudtrail module. ([720f0e9](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/720f0e9d8d8ca26cf8be75883d17a11e1a368e7e))

## [1.0.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v0.3.1...v1.0.0) (2023-08-07)


### ⚠ BREAKING CHANGES

* Cut over to new Ksoc terraform provider

### Features

* Cut over to new Ksoc terraform provider ([4cf6357](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/4cf6357c23ae5e000c1d912cc2b2737eff7ccc72))

### [0.3.1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v0.3.0...v0.3.1) (2022-03-01)


### Bug Fixes

* fixing missing region data source. ([aea1c88](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/aea1c8870af62e8c1dfb7394afacc17f3dcc0fe1))
* fixing missing region data source. ([fe427b7](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/fe427b74bdc2c888707b94534fae9eacf2877ac5))

## [0.3.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v0.2.0...v0.3.0) (2022-02-28)


### Features

* aligning release process with azure module. ([731fb12](https://github.com/ksoclabs/terraform-aws-ksoc-connect/commit/731fb12869168851edbf749e43bfbe5c1cfa9f07))

<a name="v0.2.0"></a>
## [v0.2.0](https://github.com/ksoclabs/terraform-aws-ksoc-connect/compare/v0.1.0...v0.2.0) (2021-11-10)

### Pull Requests

* Merge pull request [#3](https://github.com/ksoclabs/terraform-aws-ksoc-connect/issues/3) from ksoclabs/add-auto-assign
* Merge pull request [#2](https://github.com/ksoclabs/terraform-aws-ksoc-connect/issues/2) from ksoclabs/changelog


<a name="v0.1.0"></a>
## v0.1.0 (2021-11-10)

### Pull Requests

* Merge pull request [#1](https://github.com/ksoclabs/terraform-aws-ksoc-connect/issues/1) from ksoclabs/ben.hartley/COM-67/initial
