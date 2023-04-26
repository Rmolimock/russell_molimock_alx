# Russell Molimock ALX Take-Home Assignment

## MacOs Installation

```
git clone https://github.com/Rmolimock/russell_molimock_alx.git

cd russell_molimock_alx

docker build -t russell_molimock_alx .
```

## Run the application

- create a .env file in the root directory and add the variable: YELP_API_KEY=your_api_key

```
docker run -p 3000:3000 -v $(pwd):/app russell_molimock_alx
```
