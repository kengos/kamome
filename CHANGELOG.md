# Changelogs

## 1.0.0

* Add executable command: `kamome`
  * kamome generate_csv
  * kamome generate_diff_csv [--date=1810]
  * kamome generate_json
  * kamome generate_diff_json [--date=1810]

## 0.9.0

* Fixed [Unexpected town value](https://github.com/kengos/kamome/issues/1)
  * Skip `block.call` in the case of `#ambisous_town` is true and is not a first appearance　model
* Drop support `type: :hash`
* Support `throw :break` in passed block
  ```rb
  Kamome::import_general_all do |model, lineno|
    throw :break if lineno > 10
    # Do not use `break` without `throw`
    # break if lineno > 10
  end
