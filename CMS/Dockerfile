# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM nexus.web.sandia.gov:8084/dotnet/aspnet:6.0 AS base
WORKDIR /app
# EXPOSE 80
EXPOSE 443

# This stage is used to build the service project
FROM nexus.web.sandia.gov:8084/dotnet/sdk:6.0 AS build
ARG BUILD_CONFIGURATION=Release
ARG http_proxy http://nouser:nopass@proxy.sandia.gov:80
ARG https_proxy $http_proxy
ENV http_proxy=http://nouser:nopass@proxy.sandia.gov:80
ENV https_proxy=$http_proxy
ENV no_proxy=*.sandia.gov

WORKDIR /src
COPY ["CMS/Nuget.Config", "./"]
COPY ["CMS/CMS.csproj", "CMS/"]
COPY ["Common/Common.csproj", "Common/"]
COPY ["DatabaseClasses/DatabaseClasses.csproj", "DatabaseClasses/"]
COPY ["DataModel/DataModel.csproj", "DataModel/"]
COPY ["ImportLib/ImportLib.csproj", "ImportLib/"]
RUN dotnet restore "./CMS/CMS.csproj" --configfile Nuget.Config
COPY . .
WORKDIR "/src/CMS"
RUN dotnet build "./CMS.csproj" -c $BUILD_CONFIGURATION -o /app/build


# Copy the SSL certificate
#COPY ["certificates/aspnetapp.pfx", "/https/aspnetapp.pfx"]

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./CMS.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# Copy the SSL certificate from the build stage to the final stage
#COPY ["certificates/aspnetapp.pfx", "/https/aspnetapp.pfx"]

ENTRYPOINT ["dotnet", "CAT.dll"]