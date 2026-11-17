# qr-api

REST API for the **Access Platform**, handling events, tickets, QR codes, access validation and platform orchestration.

## Overview

`qr-api` is the core backend service of the Access Platform.

It exposes the platform's REST API and coordinates the main access-control use cases. The service is built around PHP and FrankenPHP and is designed as the central entry point for the other components of the platform.

The project is being developed as a learning and experimentation platform for distributed systems, software architecture, messaging, observability and modern development practices.

## Technology

- PHP 8.5
- FrankenPHP
- Docker / Docker Compose

The application initially runs FrankenPHP in **classic mode**. Worker Mode will be evaluated later as a separate technical evolution once the application has a stable baseline.

## Development

Development is fully containerized. PHP, Composer and the application runtime are executed inside Docker containers rather than relying on host-installed PHP tooling.

Build the development environment:

```bash
docker compose build
```

Start the development environment:

```bash
docker compose up
```

The API is available at:

```text
https://localhost:8232
```

Stop the environment:

```bash
docker compose down
```

## Project structure

The service follows a domain-oriented architecture. The application will progressively evolve around the core access-control domain and its use cases.

The initial development follows a vertical-slice approach: functionality is implemented end-to-end rather than building each technical layer or service in isolation.

## Role in Access Platform

`qr-api` is one of several services that make up the Access Platform.

Other components will progressively provide functionality such as:

- QR code generation
- Email delivery
- Public QR requests
- Management dashboard
- Android QR scanning
- Access analytics
- Infrastructure and local orchestration

The API will eventually communicate with some of these components through asynchronous messaging where this provides a meaningful architectural benefit.

## Project status

This project is under active development.

The current focus is **M1: Foundation & Core API**: establishing the application foundation and implementing the first functional vertical slice of the API.
