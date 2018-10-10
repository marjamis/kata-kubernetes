# charts

A location for a collection of my general Helm Charts, at least until they get to a point in which they need to be moved elsewhere.

All chart directories can be packaged with:
```bash
make packages
```
or if you just want to run it against a specific chart you can run:
```bash
make -e create=<name_of_chart_directory> package 
```
