docker run -d --hostname virtual-rabbit --name rabbit-test -p 5672:5672 -p 8080:15672 rabbitmq:3-management
sleep 15
bundle exec rspec
