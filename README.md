# de-dbt-adventureworks
A small, free portfolio project showing **dbt Core depth** on **SQL Server (AdventureWorks)** with:
- staging/intermediate/marts
- incremental model
- snapshot
- custom generic test
- exposures
- CI via GitHub Actions (dbt parse + sqlfluff)

## Proof checklist
- [ ] Sources with freshness (`_sources.yml`) and docs screenshots in `/docs/`
- [ ] Staging models with tests
- [ ] Incremental model with `unique_key`
- [ ] Custom generic test (`percent_nulls_under_threshold`)
- [ ] Snapshot (Person)
- [ ] Exposure for a (future) dashboard
- [ ] CI green on PR (dbt parse + sqlfluff)

## Comments
AdventureWorksDW2022 is a static demo DB with last orders in 2014. Freshness is configured with a very wide window so that dbt can still demonstrate freshness checks without constantly flagging the sample data as stale
