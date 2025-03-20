To run the [Raif](https://github.com/CultivateLabs/raif) demo app, you need Ruby 3.4.2 and Postgres installed. Then, you can run the app using:

```
git clone git@github.com:CultivateLabs/raif_demo.git
cd raif_demo
bundle install
bin/rails db:create db:prepare
bin/rails s
```

You can then access the app at [http://localhost:3000](http://localhost:3000).
