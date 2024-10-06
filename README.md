# Laravel Localstack Project

## Introduction

This project is a starting point for running Laravel with Localstack for local AWS service emulation. It is perfect for any project running on AWS. It provides a Docker-based development environment for easy setup and testing. 

The implementation is based on the following blog posts:

- [Localstack and Laravel](https://einarhansen.dev/articles/2024-07-29-localstack-and-laravel)
- [Running Laravel Vapor Locally](https://einarhansen.dev/articles/2024-09-06-running-laravel-vapor-locally)

These articles offer in-depth explanations of the concepts and techniques used in this project.

## Prerequisites

- Docker and Docker Compose
- Git

## Getting Started

Follow these steps to set up and run the project:

1. Clone the repository:
   ```bash
   git clone https://github.com/einar-hansen/laravel-vapor-localstack.git
   cd laravel-vapor-localstack
   ```

2. Set up the environment:
   ```bash
   # Copy the .env file
   cp .env.example .env
   
   # Make the shell scripts executable
   chmod +x docker/localstack/init-aws.sh
   chmod +x docker/node/entrypoint.sh 
   chmod +x install-composer.sh 
   ```

3. Install dependencies:
   ```bash
   # Install npm dependencies
   docker compose run --rm node npm install
   
   # Download Composer
   ./install-composer.sh
   
   # Install Composer dependencies
   docker compose run --rm php-fpm php composer.phar install
   ```

4. Set up the application:
   ```bash
   # Generate application key
   docker compose run --rm php-fpm php artisan key:generate
   
   # Run migrations
   docker compose run --rm php-fpm php artisan migrate
   ```

5. Start the application:
   ```bash
   docker compose up -d
   ```

6. Access the application:
   Open [http://localhost:8000](http://localhost:8000) in your browser.

## Development

### Composer

The Laravel Vapor PHP image doesn't include Composer by default. We use a script to download it on-demand:

```bash
# Download Composer (if not already done)
./install-composer.sh

# Run Composer commands
docker compose run --rm php-fpm php composer.phar [command]
```

### Node

The Node environment is configured to run in the background:

```bash
# Install dependencies (if not already done)
docker compose run --rm node npm install

# Run npm commands
docker compose run --rm node npm [command]
```

### Laravel Artisan

Execute Artisan commands within the Docker environment:

```bash
docker compose run --rm php-fpm php artisan [command]
```

## Localstack

This project uses Localstack to emulate AWS services locally, allowing you to develop and test AWS integrations without connecting to actual AWS services.

### Configuration

Localstack is configured in the `docker-compose.yml` file and starts automatically with other services when you run `docker compose up`.

### Interacting with Localstack

Use the AWS CLI with the `--endpoint-url` parameter to interact with Localstack:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

### Init Script

The `docker/localstack/init-aws.sh` script initializes necessary AWS resources in Localstack when the container starts. You can modify this script to set up additional resources as needed.

### Laravel Vapor Local Development

This project includes configurations for running Laravel Vapor locally. Refer to the [Running Laravel Vapor Locally](https://einarhansen.dev/articles/2024-09-06-running-laravel-vapor-locally) blog post for detailed information on how this is implemented.

## Troubleshooting

If you encounter issues:

1. Verify all containers are running:
   ```bash
   docker compose ps
   ```

2. Check container logs:
   ```bash
   docker compose logs [service-name]
   ```

3. Rebuild containers if needed:
   ```bash
   docker compose build --no-cache
   ```

4. Ensure Localstack is properly initialized:
   ```bash
   docker compose logs localstack
   ```

## Additional Resources

- [Localstack Documentation](https://docs.localstack.cloud)
- [Laravel Documentation](https://laravel.com/docs)
- [Docker Documentation](https://docs.docker.com)

## Contributing

We welcome contributions to improve this project. Please follow these steps:

1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Make your changes and commit them with a clear commit message
4. Push your changes to your fork
5. Create a pull request with a description of your changes

Please ensure your code adheres to the existing style and include tests for new features.

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
