# de-dbt-adventureworks
A small, free portfolio project showing **dbt Core depth** on **SQL Server (AdventureWorks)** with:
- staging/intermediate/marts
- incremental model
- snapshot
- custom generic test
- exposures
- CI via GitHub Actions (dbt parse + sqlfluff)

## Quick start
1) Create a new public repo on GitHub and push this folder (or use GitHub Desktop).
2) Install: `pip install dbt-core dbt-sqlserver sqlfluff`
3) Create a local `profiles.yml` (do **not** commit it) with the sample below.
4) Run: `dbt deps && dbt seed && dbt run && dbt test && dbt docs generate`

### Sample `profiles.yml` (local only — DO NOT COMMIT)
```yaml
aw_sqlserver:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: "ODBC Driver 17 for SQL Server"
      server: "localhost"
      port: 1433
      database: "AdventureWorks"
      schema: "dbo"
      user: "sa"
      password: "YOUR_PASSWORD"
      trust_cert: True
```

## Proof checklist
- [ ] Sources with freshness (`_sources.yml`) and docs screenshots in `/docs/`
- [ ] Staging models with tests
- [ ] Incremental model with `unique_key`
- [ ] Custom generic test (`percent_nulls_under_threshold`)
- [ ] Snapshot (Person)
- [ ] Exposure for a (future) dashboard
- [ ] CI green on PR (dbt parse + sqlfluff)
