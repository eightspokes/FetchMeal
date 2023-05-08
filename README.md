
<p float="center">
 <img
  src="https://user-images.githubusercontent.com/115739722/236899758-e2e4bdfd-dfde-47f1-908f-a980cdf36cfb.png"
  alt="Alt text"
  title="Optional title"
  style="height:600px; width:270px"
/>
  <img
  src="https://user-images.githubusercontent.com/115739722/236894466-b9fd0d07-41d7-4c39-b844-c39990722f89.png"
  alt="Alt text"
  title="Optional title"
  style="height:600px; width:270px"
/>
</p>

https://user-images.githubusercontent.com/115739722/236897695-55c3fad3-f554-488b-b7b8-299f4ada64c4.mp4


# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Testing](#tests)
6. [API](#api)
# FetchMeal
Dessert recipes IOS application

# Description
This is an iOS application that allows cooking enthusiasts to browse dessert recipes fetched from a remote API. The recipes are sorted alphabetically, and users can search for a specific recipe using a search window. Clicking on a recipe displays a detailed description, including ingredients, in a new window. Users can mark recipes as favorites, which are saved in user defaults and persist across app restarts

# Getting started
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download the FetchMeal project files from the repository.<br>
3. Open the project files in Xcode.<br>
4. Click Run Buttong in Xcode
You should see a screen with a title Desserts.<br>

# Usage
To find a recipe that you like, you can either scroll through the list of recipes or simply type its name in the search bar. Once you find a recipe you want to learn more about, click on it and you will be redirected to the details view where you can see a detailed description, ingredients, and measures.

If you want to save a recipe for later, scroll to the bottom of the detailed description and tap on "Add to Favorites". A small red heart will appear next to the recipe in the main menu to indicate that it has been bookmarked. You can remove the bookmark using the same method. Your chosen bookmarks will remain saved even when you exit and restart the app.

# Arhitecture

* Design Pattern<br> 
The app is designed using the MVVM architecture pattern, which offers numerous benefits for the project. By utilizing this 		pattern, the app benefits from low coupling and high cohesion, as well as a clear separation of concerns. This, in turn, makes the codebase easier to test, maintain, and expand over time.
* Async/await<br> 
The API Service uses the async/await mechanism to make API calls, which guarantees that we exit the asynchronous function only once and reduces the risk of common errors found in closure-based asynchronous code. By utilizing async and throw, we are moving risk to compile-time, which leads to less error-prone code. This approach provides improved readability and locality, compile-time checking, and better testability.
* Generics<br> 
The API Service has been implemented as a generic function that can be used to retrieve all meals or details of a meal by ID. By implementing the API Service in this way, it improves code conciseness and promotes reusability. This is because the same function can be used in multiple parts of the application to fetch data, rather than having to write separate functions for each endpoint.
* Protocols<br> 
The API Service is designed to implement a protocol, which will allow for easy integration with other components in the future. By using a protocol, the API Service can be easily mocked or replaced during testing. This makes the code more flexible, maintainable, and easier to modify in the future. Additionally, the protocol design promotes adherence to the single responsibility principle, as the API Service is responsible only for implementing the protocol methods, and not for handling any implementation details.

# Tests

The application currently includes tests to ensure basic functionality of the APIs. In future releases, additional tests will be implemented using mock objects to further improve test coverage and ensure the reliability of the application.


# Workflow

* Reporting bugs:<br> 
If you come across any issues while using the HelloWorld, please report them by creating a new issue on the GitHub repository.

* Reporting bugs form: <br> 
```
App version: 1.0
iOS version: 16.1
```
* Submitting pull requests: <br> 
If you have a bug fix or a new feature you'd like to add, please submit a pull request. Before submitting a pull request, 
please make sure that your changes are well-tested and that your code adheres to the Swift style guide.

* Improving documentation: <br> 
If you notice any errors or areas of improvement in the documentation, feel free to submit a pull request with your changes.

* Providing feedback:<br> 
If you have any feedback or suggestions for the HelloWorld project, please let us know by creating a new issue or by sending an email to the project maintainer.

# API 
* We are using a TheMealDb REST API
* For fetching all desserts : (https://themealdb.com/api/json/v1/1/filter.php?c=Dessert)
* For fetching a dessert by its ID : (https://themealdb.com/api/json/v1/1/lookup.php?i=)
