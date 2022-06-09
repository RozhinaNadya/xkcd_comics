# xkcd comics

The Shortcutter's Coding Challenge

You can see the task here: [Code challenge](https://github.com/shortcut/coding-assignment-mobile)

Client wants to create a comic viewer app based on [these comics](https://xkcd.com/).  
For MVP I chose features:  
- View comics: current comics, previous and next comics, comics by the comic number;
- Save comics to favourites and remove comics from favorites if necessary;
- View an explanation of the comic and view additional information about this comics on the website (from main screen and favourite screen);
- View information about license (this is a mandatory requirement of the author for permission to publish).

# Screenshots and comments

App icon, launch screen and main screen.  
The main screen displays the latest published comic. The reference was the main page of the website – show comics not as a feed, but one by one.

  <p align="center" width="100%"> 
    <img width="25%" src="/comicsMVP/Assets.xcassets/showAppIcon.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.07.44.png">
    <img width="25%" src="/comicsMVP/Assets.xcassets/showLaunchScreen.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.06.45.png">
    <img width="25%" src="/comicsMVP/Assets.xcassets/mainScreen.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.07.56.png">
  </p>
  
You can look at the previous comics or randomly, you can also find a specific comic by number if you know it. Keyboard is only numeric. 
In addition, you can watch the following comics, but in this case, the current comic is the last one, so you will get an error.
And if you enter a comic number greater than it is, you will be warned about this. And you can't watch the previous comic before the first comic.


  <p align="center" width="100%"> 
    <img width="15%" src="/comicsMVP/Assets.xcassets/prevComics.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.30.00.png">
    <img width="15%" src="/comicsMVP/Assets.xcassets/ErrorLastComicsToday.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.08.04.png">
    <img width="15%" src="/comicsMVP/Assets.xcassets/keyboard.imageset/2022-06-09 10.15.46.jpg">
    <img width="15%" src="/comicsMVP/Assets.xcassets/showNumber.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.08.24.png">
    <img width="15%" src="/comicsMVP/Assets.xcassets/ErrorMoreMax.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.08.35.png">
    <img width="15%" src="/comicsMVP/Assets.xcassets/ErrorLessOne.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.08.52.png">
  </p>
  
  
  Tap on the question icon briefly explains the comic. 
  You can also see more information about this comic on the wiki by clicking on the "Show more" button.
  You can add current comic to favourite comics and see more info too. Favorite comics are added to the feed. 
  You can remove the comic from your favorites any time.
  
   <p align="center" width="100%"> 
    <img width="18%" src="/comicsMVP/Assets.xcassets/explanationComics.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.11.49.png">
    <img width="18%" src="/comicsMVP/Assets.xcassets/showMore.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.12.00.png">
    <img width="18%" src="/comicsMVP/Assets.xcassets/addFavourite.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.12.29.png">
    <img width="18%" src="/comicsMVP/Assets.xcassets/favouriteScreen.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.12.43.png">
    <img width="18%" src="/comicsMVP/Assets.xcassets/explanationFavourite.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.13.17.png">
  </p>
  
  And another important thing is the license. 
  We are free to copy and reuse any of author's drawings (noncommercially) as long as we tell people where they're from.
  
   <p align="center" width="100%"> 
    <img width="20%" src="/comicsMVP/Assets.xcassets/aboutScreen.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.13.24.png">
    <img width="20%" src="/comicsMVP/Assets.xcassets/license.imageset/Simulator Screen Shot - iPhone 13 - 2022-06-09 at 10.13.31.png">
  </p>
  
  # Tools
  
  - MVC pattern that makes it easy to add and extend features;
  - Coding without storyboard, NSLayoutConstraint for screen layout;
  - Added custom buttons to fast implementation;
  - Singleton ComicsStore to easy interaction;
  - Codable type and Equatable type to JSONDecoder. Using DispatchQueue.main.async in decoder to prevent error "must be used from main thread only";
  - UITableViewDelegate to favourite comics feed;
  - ComicsTableViewCellDelegate to reload TableView when a comic is removed from the favorites list;
  - Extensions are written in separate files to quickly implement settings (including alerts). 
