#/bin/bash

# Exit immediately on any error
set -e

# Check if TARGET is set
if [[ -z "$TARGET" ]]; then
  echo "❌ Error: TARGET environment variable is not set."
  exit 1
fi

echo "running dbt run"
if dbt run --target "$TARGET"; then
  echo "dbt run succeeded."
else
  echo "dbt run failed."
  exit 1
fi

echo "dbt run completed successfully"