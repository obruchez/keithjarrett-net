name := "keithjarrett-net"

version := "1.0-SNAPSHOT"

scalaVersion := "2.13.18"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

libraryDependencies ++= Seq(
  guice,
  "org.playframework" %% "play-slick" % "6.2.0",
  "org.playframework" %% "play-slick-evolutions" % "6.2.0",
  "org.postgresql" % "postgresql" % "42.7.5",
  "org.scalatestplus.play" %% "scalatestplus-play" % "7.0.1" % Test
)
