# Segment-Primer

[![Version](https://img.shields.io/cocoapods/v/Segment-Primer.svg?style=flat)](http://cocoapods.org/pods/Segment-Primer)
[![License](https://img.shields.io/cocoapods/l/Segment-Primer.svg?style=flat)](http://cocoapods.org/pods/Segment-Primer)

Primer integration for analytics-ios.

## Installation

Segment-Primer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'Segment-Primer'
```

## Getting Started

### Start the SDK

First you will need to register an account with [Primer](http://goprimer.com) to get a Primer token.

Once the Segment iOS SDK and the Segment-Primer CocoaPod is integrated with your app, toggle Primer on in your Segment integrations, and add your Primer token, which you can find on the Primer Dashboard under Project Settings. Refer to the [Primer Documentation](http://docs.goprimer.com) for more details on how to setup Primer.

Since Primer needs to be started as early as possible, you need to supply the token when you initialize the factory that is registered with the analytics client.

```objc
[configuration use:[SEGPrimerIntegrationFactory instanceWithToken:@"PRIMER_TOKEN"]];
```

This will start the Primer SDK under the hood and begin collecting events.

If your app doesn't require users to have an account, and you only want to show a screen the first time the app is installed and launched, call `+setRequiresLogin:` with `NO` (or `false` for Swift) on Primer before calling the start method.

### Present Onboarding

The most common time to present an onboarding experience is right when the application launches. The best way of doing this in most of the applications is by calling the presentation method in the `-viewDidLoad` of your first view controller to be presented to the user on app load.

To let the SDK automatically present an onboarding experience just simply call the `+presentExperience` method.

```objc
#import <Primer/Primer.h>
  
- (void)viewDidLoad {
    [super viewDidLoad];
    // Present the Primer onboarding experience
    [Primer presentExperience];
}
```

### Whitelist Domain

iOS 9 introduced App Transport Security that impacts your app and the Primer iOS SDK integration. You need to whitelist the Primer domain in your app by adding the following to your application's info plist.

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>goprimer.com</key>
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

Pro tip! If you right-click the info plist file in the project navigator and select Open As > Source Code, you can easily copy and paste the XML snippet under the main <dict> tag.

You're Done



## License

```
The MIT License (MIT)

Copyright (c) 2015 Primer, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
