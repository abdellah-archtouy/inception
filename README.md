# Inception

## Table of Contents

- [Introduction](#introduction)
- [Objectives](#objectives)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Installation and Setup](#installation-and-setup)
- [Usage](#usage)
- [Bonus Features](#bonus-features)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

---

## Introduction

Inception is a project from the **42 School** curriculum designed to introduce students to system administration and containerization using **Docker** and **Docker Compose**. The goal is to set up a complete multi-container environment that runs various services, all orchestrated using Docker Compose.

![Docker Architecture](./assets/docker-architecture.png)

## Objectives

- Learn and apply containerization concepts.
- Deploy services using Docker and Docker Compose.
- Ensure each service runs in its own dedicated container.
- Use **volumes** and **networks** to manage data and communication.
- Follow security best practices.

## Technologies Used

- **Docker**
- **Docker Compose**
- **NGINX** (Reverse Proxy)
- **MariaDB** (Database Server)
- **WordPress** (Content Management System)
- **Redis** (Optional for caching)
- **Makefile** (For automation)

## Project Structure

```
inception/
├── srcs/
│   ├── nginx/
│   │   ├── Dockerfile
│   │   ├── nginx.conf
│   ├── wordpress/
│   │   ├── Dockerfile
│   │   ├── wp-config.php
│   ├── mariadb/
│   │   ├── Dockerfile
│   │   ├── init.sql
│   ├── redis/ (Bonus)
│   │   ├── Dockerfile
│   ├── .env
├── docker-compose.yml
├── Makefile
└── README.md
```

## Installation and Setup

### Prerequisites

- **Docker** installed on your system.
- **Docker Compose** installed.

### Steps

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/inception.git
   cd inception
   ```
2. Configure environment variables in `.env` file.
3. Build and start the containers:
   ```sh
   make up
   ```
4. To stop and remove containers:
   ```sh
   make down
   ```
5. Check running containers:
   ```sh
   docker ps
   ```

## Usage

- Access the WordPress website at `http://localhost`
- Use `docker logs <container_name>` to debug services.

## Bonus Features

- **Redis** for caching.
- **TLS/SSL Certificates** for secure communication.
- **FTP Server** for file transfers.
- **Adminer** for database management.

## Troubleshooting

- If a service does not start, check logs using:
  ```sh
  docker logs <container_name>
  ```
- Ensure no conflicting services are running on required ports.
- Use `docker-compose down -v` to remove all volumes if issues persist.

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [WordPress Configuration](https://wordpress.org/support/article/editing-wp-config-php/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [NGINX Configuration](https://nginx.org/en/docs/)

![Project Workflow](./assets/project-workflow.png)

