#/bin/bash

# Exit immediately on any error
set -e

# Check if TARGET is set
if [[ -z "$TARGET" ]]; then
  echo "❌ Error: TARGET environment variable is not set."
  exit 1
fi

echo "starting dbt seed"
if dbt seed --target "$TARGET"; then
  echo "dbt seed succeeded."
else
  echo "dbt seed failed."
  exit 1
fi

echo "running dbt run"
if dbt run --target "$TARGET"; then
  echo "dbt run succeeded."
else
  echo "dbt run failed."
  exit 1
fi

echo "Both dbt seed and dbt run completed successfully"