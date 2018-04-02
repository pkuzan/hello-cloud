# Hello Cloud
An AWS experiment.

This project will form the basis of our of Amazon AWS reference implementations.

A bootstrap class DefaultPricerApplication is provided for running in your IDE. However, this 
project does not include the Spring Boot Maven plugin so can't directly be deployed to Beanstalk for example.
This project builds to a normal Java JAR so other projects can depend on it.

In order to deploy to beanstalk, you need to perform a mvn install on this project, and then use 
another dependant project, such as S3PricerRepositroy, these projects will build to a single 
executable JAR file including full transitive closure.
