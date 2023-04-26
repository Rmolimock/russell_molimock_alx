# Russell Molimock ALX Take-Home Assignment

## MacOs Installation

```
git clone https://github.com/Rmolimock/russell_molimock_alx.git

cd russell_molimock_alx

docker build -t russell_molimock_alx .
```

## Run the application

* create a .env file in the root directory and add the variable: YELP_API_KEY=your_api_key
* most of the app works without any Yelp API key, but creating one is free and easy: [https://www.yelp.com/developers/v3/manage_app](https://www.yelp.com/developers/v3/manage_app)


```
docker run -p 3000:3000 -v $(pwd):/app --name my_app russell_molimock_alx
```
That should have created a container called 'my_app.' Now, in another terminal, while that's running:

```
docker exec my_app rails db:migrate RAILS_ENV=development
```


## View Standup Studio
* visit 0.0.0.0:3000 in your browser
