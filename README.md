# Library

[![Build Status](https://travis-ci.org/tamasdancsi/library-ios.svg?branch=master)](https://travis-ci.org/tamasdancsi/library-ios)

A native iOS book library app written in Swift. Uses Open Library API.

## Installation

Download the source code, navigate to the main folder and install the pods first. Make sure to open `library.xcworkspace` instead of the default project file afterwards.

```sh
pod install
```

## Architecture

### MVVM

The basic architecture is [MVVMPattern.pngModel–view–viewmodel](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) instead of the casual MVC pattern to avoid massive view controllers.

### RxSwift

The app is using a reactive programming approach with the help of the [RxSwift](https://github.com/ReactiveX/RxSwift) library.

## Data

The app is using [Open Library's experimental search API](https://openlibrary.org/dev/docs/api/search).