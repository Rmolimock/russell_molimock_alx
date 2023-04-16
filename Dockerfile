# Use the official Ruby image as the base image
FROM ruby:2.7.4

# Set the working directory inside the container
WORKDIR /app

# Install the necessary system libraries for building the native extensions
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems specified in the Gemfile
RUN bundle install

# Copy the 'learning_ruby' directory into the container
COPY . .

# Expose the port that the Rails app will run on
EXPOSE 3000

# Set the environment variable for Rails to run in development mode
ENV RAILS_ENV=development

# Start the Rails server when the container is run
CMD ["rails", "server", "-b", "0.0.0.0"]
