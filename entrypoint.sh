#!/bin/sh
set -e

mkdir -p /root/.dbt

cat > /root/.dbt/profiles.yml <<EOF
cocosurf:
  target: prod
  outputs:
    prod:
      type: snowflake
      account: "$SNOWFLAKE_ACCOUNT"
      user: "$SNOWFLAKE_USER"
      password: "$SNOWFLAKE_PASSWORD"
      role: "$SNOWFLAKE_ROLE"
      database: "$SNOWFLAKE_DATABASE"
      warehouse: "$SNOWFLAKE_WAREHOUSE"
      schema: "$SNOWFLAKE_SCHEMA"
      threads: 4
EOF

exec dbt "$@"