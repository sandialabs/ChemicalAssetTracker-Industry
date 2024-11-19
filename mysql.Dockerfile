FROM mysql:8.0

# Set environment variables for the database
ENV MYSQL_DATABASE=cms
ENV MYSQL_USER=cms
ENV MYSQL_PASSWORD=cms
ENV MYSQL_ROOT_PASSWORD=rootpassword

COPY ["./DataModel/InitializationScripts", "/docker-entrypoint-initdb.d"]

# Expose the default MySQL port
EXPOSE 3306