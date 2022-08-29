# de_challenge

## Prerequisites

  1. Docker
  2. Python 3

## Run steps. You can also check demo video.

  1. Go to the repo folder
  2. Run docker compose up --build
  3. Optional. Can connect to the postgres database using any IDE with the following credentials:
    host: localhost
    port: 5432
    username: postgres
    password: postgres
  4. Open new terminal and go to the repo folder
  5. Run docker compose run app
  6. Run python3.6 /app/main.py
  7. Wait for the script to run. After it ends successfully you should see the data in the trips table.
  8. In case of any error check is any records where upload and delete before running the script again
    Common errors with geocoding service:
    1. Service not available
    2. [Errno 99] Cannot assign requested address
  9. Ctrl + d to close app server
  10. Ctrl + c to stop docker containers

## Scalability

For existing data model using pandas is ok even for 100 millions records. Pandas can handle millions of row by chunking the datasets to a size that is according to the ram available in the system. If the data model gets more complex probably we would need to create additional tables in our data model (example: origin-destination, geocoding, boundaries) and also we can migrate to different framework like spark. 


## Pending improvements

  1. Check for a better geocoding service. Currently using nominatim but atleast free version is not scalable and sometime connection is lost.
  2. In case of fail include a rollback for partial uploaded records. This is to avoid step 8

## Cloud provider sketchup

Using AWS we could use the following process:

  1. Use S3 as a data warehouse to store raw files as well as processed file.
  2. Create a EC2 instance to execute scripts or run something like airflow for better workflow management. Other option can be to use Glue to schedule python script jobs.
  3. Create a database using Redshift. In this case we can set the script output to store csv files in S3 and which then we can upload to Redshift, this process between S3 and Redshift is really smooth.