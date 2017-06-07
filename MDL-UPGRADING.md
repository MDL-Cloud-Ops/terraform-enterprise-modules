This repository has been forked from `git@github.com:hashicorp/terraform-enterprise-modules.git`
but has significant security changes. The default branch has been changed to
`mdl_master` to reflect this.

# Local setup

```
git clone git@github.com:MDL/terraform-enterprise-modules.git
cd terraform-enterprise-modules
git remote add hashicorp git@github.com:hashicorp/terraform-enterprise-modules.git
# We should not implicate McK while using public GitHub:
git config user.name {{PUBLIC NAME}}
git config user.email {{PUBLIC EMAIL}}
git fetch hashicorp
git checkout mdl_master
```

# Upgrading from HashiCorp

The following is a suggested process.

```
git fetch origin
git fetch hashicorp
git checkout mdl_master
git merge --ff-only origin/mdl_master
git checkout -b mdl_master_SAVEPOINT
git rebase -i hashicorp/{{RELEASE branch or tag}}
# Validate the Terraform changes that will occur and get the changes reviewed
git push origin --force mdl_master
git push origin mdl_master_SAVEPOINT:mdl_master_YYYYMMDD
```
