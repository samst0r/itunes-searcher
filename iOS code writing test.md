#iOS Development test.

Thank you for applying to Monitise Create. We are keen to recruit the best iOS developers, work with them to create great apps and in the process give them the opportunity to experience as wide a range of iOS technologies as possible and to learn first class professional development techniques and practices.

As part of the interview process, in order for us to determine your current level as an iOS developer we would like you to create a simple app. We have deliberately limited the scope of the app so that you don't need to spend too much time on it. We don't expect production ready code and are happy to see //TODO: with notes on what you would normally expect to put in given the time. However the basic app should work and not crash.

This is your chance to impress us. We are interested in clean, readable code that clearly expresses your intent, shows good design with a readily apparent structure. Extra marks for noting cool things that you could do given time and / or notes about Objective-C / framework issues / points of interest that show your capabilities as an iOS developer.


##App Requirements:

- A master / detail app.

- iPhone only. Bonus credit for a universal app - but this is not expected.

- iOS8 only. Bonus credit for supporting previous versions or pointing out in comments what you'd need to do for previous versions.

- Objective-C only. No Swift - as much as we would like to we are not moving over yet.

- Master view to contain a list of albums loaded from the end point - http://itunes.apple.com/search?term=SEARCHTERM1+SEARCHTERM2+...

	- where SEARCHTERMn is a string that the user can enter in a search box, text field or similar (your choice) that is visible somewhere in the master view. For example entering "Jack Johnson" in the search box would yield an end point of http://itunes.apple.com/search?term=Jack+Johnson

	- The web query and JSON parsing should be done on a background thread.


- Entering a new search term(s) should make the app reload the view with the result of the new search.
x§
- Master view should show, for each item returned: the artist name, track name and thumbnail of the artwork.

- Selecting a track from the master list should go to the detail view.

- The detail view should show: the track name, the album name, artist name, the artwork in a circular picture, price and the release date.

- You should not use any cocoa pods, or other external libraries to create the app. We want to see plain old Apple frameworks only. 



##Delivery of the app. 

- We would like to you create a GIT repository on github, bitbucket or similar that we can clone from. Alternatively you can send the project to us in a zip file.

- Please do NOT use the name Monitise Create in the repo or as the name of the repo. Something like "codetest" or similar please.

- You should provide a readme.md file with notes on how you went about the project and to let us know about all the cool things you could have done given the time plus any justification for design decisions.

- Your repository can be public but once we have cloned it and the interview process is over you should remove it from public view.



