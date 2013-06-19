## Gifzo.app
Gifzo Mac Client

http://gifzo.net/

## Build

### CocoaPods

1\. Install CocoaPods at first time

```
$ [sudo] gem install cocoapods
$ pod setup
```

2\. Install pods for resolve dependencies

```
$ pod install
```

3\. Open `.xcworkspace` file

```
$ open Gifzo.xcworkspace
```

4\. Enjoy!

## Tips
### upload to your server
You can change the url Gifzo.app upload to.

```
% defaults write net.gifzo.Gifzo url -string "http://your.gifzo.server.com/"
```

## License
The MIT License (MIT)

Copyright (c) 2013 Kazato Sugimoto \<uiureo@gmail.com\>
