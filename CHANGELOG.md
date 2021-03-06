# Changelog

Terraform Enterprise release versions have the format:

```
vYYYYMM-N
```

Where:

* `YYYY` and `MM` are the year and month of the release.
* `N` is increased with each release in a given month, starting with `1`

## v201704-3

APPLICATION LEVEL CHANGES:

(none)

MACHINE IMAGE CHANGES:

* Properly handle database passwords with non-alphanumeric characters
* Remove nginx's `client_max_body_size` limit so users can upload files larger than 1MB

TERRAFORM CONFIG CHANGES:

* Fix var reference issues when specifying `kms_key_id` as an input
* Add explicit IAM policy to KMS key when Terraform manages it
* Add explicit KMS Key Alias for more easily referencing the KMS key in the AWS Web Console

## v201704-2

APPLICATION LEVEL CHANGES:

(none)

MACHINE IMAGE CHANGES:

* Add `hashicorp-support` script to create an encrypted bundle of diagnostic information for passing to HashiCorp Support
* Switch main SSH username to `tfe-admin` from default `ubuntu`
* Allow AMI to be used in downstream Packer builds without triggering bootstrap behavior

TERRAFORM CONFIG CHANGES:

* Allow `kms_key_id` to be optionally specified as input
* Remove unused `az` variable

## v201704-1

APPLICATION LEVEL CHANGES:

(none)

MACHINE IMAGE CHANGES:

* Disable Consul remote exec
* Install git inside build worker Docker container to facilitate terraform module fetching
* Don't redirect traffic incoming from local build workers

TERRAFORM CONFIG CHANGES:

* Prevent extraneous diffs after RDS database creation

## v201703-2

APPLICATION LEVEL CHANGES:

(none)

MACHINE IMAGE CHANGES:

* Prevent race condition by waiting until Consul is running before continuing boot 
* Ensure that Vault is unsealed when instance reboots

## v201703-1

* Initial release!
