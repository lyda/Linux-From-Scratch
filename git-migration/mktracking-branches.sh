git for-each-ref \
  | awk '{print $3}' \
  | sed 's-refs/remotes/--' \
  | while read ref; do
      git branch $ref refs/remotes/$ref
    done
