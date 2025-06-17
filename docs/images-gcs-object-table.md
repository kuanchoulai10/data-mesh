# Annotate Product Images

<figure markdown="span">
  ![](./static/images-gcs-object-table.drawio.svg)
  <figcaption>Annotate product images using BigQuery and Cloud Vision</figcaption>
</figure>


## Create a Cloud Storage Bucket and Upload Images

- Google Cloud Storage bucket name: `kcl-us-test`
- Region: `us`
- Data: `*.png` (sample images)

## Create a Dataset

```sql
create schema if not exist products
options(
  location="us"
)
```

## Create an Object Table

Create a BigQuery connection to the Cloud Storage bucket containing the images:

```terraform
--8<-- "infra/main.tf:gcp-bq-conn-images"
```

The connection's service account must have the following roles:

- `roles/storage.objectViewer`
- `roles/serviceusage.serviceUsageConsumer`

```sql
create external table `kcl-tw-data-7c9b.products.images`
with connection `kcl-tw-data-7c9b.us.bg-object-tables`
options(
  object_metadata = 'SIMPLE',
  uris = ['gs://kcl-us-test/*.png']
)
```

## Create a Remote Model

Create a BigQuery connection to the Cloud Vision API:

```terraform
--8<-- "infra/main.tf:gcp-bq-conn-vision"
```

```sql
create or replace model `kcl-tw-data-7c9b.products.vision`
remote with connection `kcl-tw-data-7c9b.us.bg-cloud-vision`
options(
    remote_service_type='CLOUD_AI_VISION_V1'
);
```

## Annotate images

```sql
select * from ml.annotate_image(
  model `kcl-tw-data-7c9b.products.vision`,
  table `kcl-tw-data-7c9b.products.images`,
  struct(['IMAGE_PROPERTIES'] AS vision_features)
)
```

## References

- [Annotate images with the `ML.ANNOTATE_IMAGE` function](https://cloud.google.com/bigquery/docs/annotate-image)
- [Create object tables](https://cloud.google.com/bigquery/docs/object-tables)