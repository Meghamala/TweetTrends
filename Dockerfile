FROM openjdk:8
ADD jarstaging/com/application/tweet-trend/0.0.1-SNAPSHOT/tweet-trend-0.0.1-20240312.175816-1.jar ttrend_2.jar
ENTRYPOINT ["java", "-jar", "ttrend_2.jar"]