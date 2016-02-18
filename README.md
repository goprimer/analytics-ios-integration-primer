# Segment-Primer

[![Version](https://img.shields.io/cocoapods/v/Segment-Primer.svg?style=flat)](http://cocoapods.org/pods/Segment-Primer)
[![License](https://img.shields.io/cocoapods/l/Segment-Primer.svg?style=flat)](http://cocoapods.org/pods/Segment-Primer)

Primer integration for analytics-ios.

## Installation

Segment-Primer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "Segment-Primer"
```

## Getting Started

First you will need to register an account with [Primer](http://goprimer.com) to get a Primer Token.

Once the Segment iOS SDK and the Segment-Primer CocoaPod is integrated with your app, toggle Primer on in your Segment integrations, and add your Primer Token which you can find on the Primer Dashboard under Project Settings.

Since Primer needs to be initialized as early as possible, you need to supply the Token when you initialize the factory that is registered with the analytics client.

```
[config use:[SEGPrimerIntegrationFactory instanceWithToken:@"PRIMER_TOKEN"]];
```

This will initialize the Primer SDK under the hood and begin collecting events and initializing the Primer Flow.

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
