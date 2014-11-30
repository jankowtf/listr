# CHANGES IN listr VERSION 0.2

## NEW FEATURES

- argument `resolve_by`:
  Allows to choose the actual field on whoses basis name resolving/substitution is carried out (affects `getBy()` and all of its convencience wrappers)

## BUG FIXES

- couple of minor bug fixes w.r.t. names

## MAJOR CHANGES

- A: `getBy()`
  Generic way to retrieve values by structure fields as returned by `getStructure()`. Other retrieval functions were refactored to be wrappers around `getBy()`

## MINOR CHANGES

## MISC

-----

# CHANGES IN listr VERSION 0.1.2

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

- failed to bump version on GitHub

-----

# CHANGES IN listr VERSION 0.1.1

## NEW FEATURES

- `getByPath()`:
  Retrieve values by name-based or position based path
- new fields in structure table:
  - `path`: names-based path
  - `ppath`: position-based path

## BUG FIXES

- # 1

## MAJOR CHANGES

- A: `getByPath()`
- A: alternative way of retrieving structure table in `getRawStructure()`
- C: field `pindex` --> `oindex` (not *parent*, but *outer*)

## MINOR CHANGES

## MISC

-----

# CHANGES IN listr VERSION 0.1

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

- initial version

-----


