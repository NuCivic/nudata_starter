api = 2
core = 7.x

includes[core] = drupal-org-core.make

; Profile

projects[dkan][type] = profile
projects[dkan][download][type] = git
projects[dkan][download][url] = https://github.com/NuCivic/dkan.git
projects[dkan][download][branch] = 7.x-1.11_with_latest_ahoy
projects[dkan][patch][] = https://github.com/NuCivic/dkan/pull/972.diff
