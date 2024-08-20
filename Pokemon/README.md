# Pokèmon iOS App
## by Norman

## Technical Specifications
-- iOS Version Supported: tvOS 17.4 and above
-- Xcode Version: 15.3
-- MVVM (SwiftUI)
-- Open the app in xcode and build the app.

## Design Pattern
-- I choose MVVM as a Design pattern for this App. 
-- As it is a simple app which have just a List view on Launch & On selecting one of the item from the list, Navigate to its detail page. So have created this app following MVVM design pattern.
-- I have created a separate Service consuming classes (PokemonListingService, PokemonDetailService) following Interface segregation principle & Single Responsibility principle for each of its view.
-- I have segregated sub SwiftUI views to follow clean code principle & to be much readable.
-- I have used @Observable macro for `PokemonDetailViewModel` to minimise the boiler plate code. Apple recommends it.

## Internal Libraries
-- Created `NetworkService` Swift Package manager which can be re-used as a service layer to interact with Backend and receive the corresponding response.

## Unit tests
-- For all the service classes, viewmodels, I have written unit test creating mocks which covered 100% of the code.  

## XCUITests Automation
-- I have added UIAutomation test which helps covering test for the User Interface with approximately 97%.

## Improvements
-- There are always improvements can be made from the developer point of view.
-- We can cache the images of the Pokèmon whenever user see the details page. And on seeing the same page, we can load image from the cache.
-- I have added search as a seperate SwiftUI to have a flexible user experience for the user to always search even though user scroll to bottom.

