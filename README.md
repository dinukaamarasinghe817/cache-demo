# Optimizing Performance: Server-Side Caching with Ballerina

## Overview

This project showcases the usage of Ballerina's `bal persist`, the data persistent feature with `Redis` DB to improve application performance by caching frequently accessed data.

## Features

- **Persistent Caching**: Utilizes Ballerina's `bal persist` with `Redis` to store and retrieve data efficiently.
- **Demo API**: Provides a simple API to demonstrate caching functionality.

## Usage

1. **Clone the Repository**:
   ```
   git clone https://github.com/dinukaamarasinghe817/cache-demo.git
   ```

2. **Navigate to the Project Directory**:
   ```
   cd cache-demo
   ```

3. **Setup the Redis server**:
    
    Set up the Redis DB server using one of the following methods,
   #### Setup a Redis server locally

    Install a Redis server on your machine locally by downloading and installing it based on your development platform. See the [official Redis documentation](https://redis.io/download/).
  
    #### Setup using docker

    Use Docker to create a DB server deployment.
    1. Install Docker on your machine if you haven't already.
    2. Pull the Redis Docker image from Docker Hub using the command `docker pull redis`.
    3. Run the Redis container as follows `docker run -d -p 6379:6379 --name <container-name> redis`.

    #### Setup a cloud-based Redis service

    Use a cloud-based DB solution such as Google’s Cloud, Amazon’s Web Services, or Microsoft’s Azure database.
    1. Visit [Redis cloud console](https://app.redislabs.com).
    2. Login using email and password or using one of the Single Sign-On options.
    3. Select either Amazon Web Services, Google Cloud, or Microsoft Azure as the database vendor.
    4. Select a region and create the database.
    5. Find your `username`, `password` and the `public endpoint`
    6. Replace the `connection` parameter in `Config.toml` file as below
   
          ```toml
        connection = "redis://<username>:<password>@<public_endpoint>"

4. **Configure caching**:
   
   In `Config.toml`, set the `maxAge` configuration parameter in `seconds` as you need.

5. **Build the Project**:
   ```
   bal build
   ```

6. **Run the Service**:
   ```
   bal run
   ```

7. **Test the API**:
   
   Use your preferred API testing tool (e.g., cURL, Postman, REST Client in VScode) to interact with the endpoints provided in `requests.http`.
