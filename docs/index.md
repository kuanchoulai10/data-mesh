# Unified SQL-based Data Pipelines

## 💡 Highlights

!!! success "Highlights"

    - [x] Built **cross-cloud** pipelines (**AWS + GCP**) to process both **structured/unstructured** data by integrating **Object** and **BigLake Tables**.
    - [x] Enabled **SQL-based ML inference** for annotating images by integrating **Remote Models** and **federated query capabilities**.

##

假設

## 

我用了哪些技術？

- 透過biglake table，取得在aws s3上的products.csv
- 透過object table，取得在gcs上的images
- 透過remote model，使得我們可以在bigquery裡使用cloud vision api，對gcs上的images進行annotation

我做了什麼？這樣做有什麼好處？

用一套unified的sql-based data pipeline，來處理結構化和非結構化資料，同時可以做ml / non-ml 的workloads，還可以跨雲。

好處?

- 減少上下文切換與多語言維護成本
- SQL 是數據與 BI 團隊的共同語言；新成員 onboarding 快。