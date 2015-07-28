# viacom-weather-diary

Rainy day journal is an app that encourages you to write when it rains.  

# building

Install using [CocoaPods](http://cocoapods.org).  

``` pod install ```

Add a file called "APIKeysAndSecrets.swift" with API keys from [Parse](http://www.parse.com) and [Forecast.io](http://forecast.io)

```let kForecastAPIKey = "KEY", kParseApplicationID = "ID", kParseClientKey = "KEY"```

This was a challenge for an interview — inspired by Viacom Labs

#functionality

The icon in the bottom left shows the weather when the text was created — currently either a raindrop for rainy or a sun for sunny, based on information from Forecast.io.  The icon in the bottom right shows an emoticon based on analysis of the positive or negative sentiment of the text.  Additionally, in the read view, the text is formatted to fill a shape based on the weather during writing — a circle for sunny or a raindrop shape for rainy.

<img src="https://github.com/harquail/viacom-weather-diary/blob/master/screenshots/iOS%20Simulator%20Screen%20Shot%20Jul%2027%2C%202015%2C%209.13.05%20PM.png" width="250"></img>
<img src="https://github.com/harquail/viacom-weather-diary/blob/master/screenshots/iOS%20Simulator%20Screen%20Shot%20Jul%2027%2C%202015%2C%209.13.16%20PM.png" width="250"></img>
<img src="https://github.com/harquail/viacom-weather-diary/blob/master/screenshots/iOS%20Simulator%20Screen%20Shot%20Jul%2027%2C%202015%2C%207.11.00%20PM.png" width="250"></img>
<img src="https://github.com/harquail/viacom-weather-diary/blob/master/screenshots/iOS%20Simulator%20Screen%20Shot%20Jul%2027%2C%202015%2C%207.10.54%20PM.png" width="250"></img>

