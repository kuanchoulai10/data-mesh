# Unified SQL-based Data Pipelines

## 💡 Highlights

!!! success "Highlights"

    - [x] Built **cross-cloud** pipelines (**AWS + GCP**) to process both **structured/unstructured** data by integrating **Object** and **BigLake Tables**.
    - [x] Enabled **SQL-based ML inference** for annotating images by integrating **Remote Models** and **federated query capabilities**.

![](./static/combined.drawio.svg)


In this project, we demonstrate how to build a unified **SQL-based data pipeline** that processes both **structured** and **unstructured** data across **AWS** and **GCP** for both **ML** and **non-ML** workloads. We leverage BigQuery's **Object Table** functionality to access images stored in **Google Cloud Storage**, and we also use **Remote Model** functionality to perform image annotation using the **Cloud Vision API**. Notably, we utilize **BigLake Tables** to access structured data stored in **AWS S3**, allowing us to join product information with image annotations seamlessly.

The pipeline is designed to be cross-cloud, enabling data teams to work with data stored in different cloud environments without the need for complex data movement or transformation processes. This approach reduces context switching and maintenance costs associated with using multiple languages and tools, as SQL serves as a common language for both data and BI teams.

## Scenario: E-commerce Company with a Cross-Cloud Architecture

Imagine you're working at an e-commerce company where different teams have made independent decisions about their tech stack based on their specific needs.

On the **backend side**, the product-related transactional data—such as product names, prices, categories, and units sold—is stored in **Amazon RDS**. To build a centralized data lake and enable downstream analytics, the data engineering team uses **AWS DMS** to continuously replicate this structured data into AWS S3.

Meanwhile, the **media team** is responsible for handling product images. For ease of use and integration with existing tools, they chose **Google Cloud Storage (GCS)** to store all product-related media assets like images and thumbnails. As a result, your organization ends up with **product metadata on AWS and product images on GCP**.

Now, the data team is tasked with analyzing **both the structured product information** and **the unstructured image data** to generate insights, such as:

- What visual characteristics are common among high-performing products?
- Can we automatically annotate and categorize product images?
- How do product descriptions align with image content?

But there's a problem.

The company don’t want to **maintain multiple pipelines using Python for image annotation and Spark for joining data**, nor do they want to **transfer large image files between clouds just to run ML models**.

The company want to keep things **simple**, **scalable**, and **SQL-driven**, so that **data analysts and BI teams can contribute directly without learning new tools**.

That’s where BigQuery becomes your central processing engine:

- We can use **BigLake Tables** to query structured product data directly from **AWS S3**.
- We can use **Object Tables** to access images stored in **GCS** without copying them.
- We can integrate **Remote Models** to call the **Cloud Vision API** for image annotation, directly within SQL.

This architecture allows your team to process both **structured** and **unstructured** data, across **AWS** and **GCP**, using just **SQL**—without building and maintaining separate pipelines or duplicating data across cloud environments.

## When Not to Use This Architecture?

While a unified SQL-based, cross-cloud pipeline on BigQuery offers simplicity and power, it's not always the right choice. Consider alternatives if:

- **To avoid vendor lock-in** to BigQuery's query engine or proprietary features like Remote Models and Object Tables. While they’re powerful, they tightly couple your pipelines to GCP.
- **BigQuery costs are a concern**. If your workloads involve large-scale image annotation or frequent joins over huge datasets, query costs can grow rapidly.
- **Teams prefer full Python-based workflows**. If data teams are more comfortable with notebooks, Python SDKs, and want flexibility outside SQL, it might be better to build pipelines in tools like Airflow or Prefect, using Python-native ML libraries.
- **You need real-time processing**. This architecture is designed for batch or scheduled workflows. If your use case requires low-latency streaming, a dedicated streaming engine like Apache Flink or Kafka Streams may be more appropriate.