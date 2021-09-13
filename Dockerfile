FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["SimpleWebHalloWorld.csproj", "."]
RUN dotnet restore "./SimpleWebHalloWorld.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "SimpleWebHalloWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SimpleWebHalloWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleWebHalloWorld.dll"]