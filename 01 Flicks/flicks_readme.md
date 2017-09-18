# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **19** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [x] Add a search bar.
- [x] All images fade in.
- [x] For the large poster, load the low-res image first, switch to high-res when complete.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/yzhanghearsay/ios-dev/blob/master/01%20Flicks/flicks.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

- Display a view for networking error. I initially put the view on top of MovieCell, and it resulted in a weird gap between nav bar and MovieCell. Then I realized that that view should show up when there's no data, so I solved it by moving it below the MovieCell. However, I think networking error can happen when there's data (e.g. user trying to refresh but loses network at that time), so I think the best solution is to have a view on top of the MovieCell layer but I was not able to figure out how to do that.
- Make tab bar programmatically challenge 1: after added the tab bar, my nav bar is gone. Spent way too much time trying to figure out why. Lia helped me double check and noticed that I put nowPlayingViewController instead of nowPlayingNavigationController in places like array tabBarController.viewControllers. Honestly I'm still not totally clear why I can't put view  controller here.
- Make tab bar programmatically challenge 2: the tab bar appears on every view. There's no hints on how to disable it from other views. I did some research and solved it by adding self.tabBarController?.tabBar.isHidden to viewWillAppear func.
- Make tab bar programmatically challenge 3: because I programmatically made tab bar, I need to set its style programmatically as well. It was not straightforward but I was able to find answers from StackOverflow.
- A few times I didn't notice info/hints already provided by the Assignment page.
- Trying to parse Genre names from Movie DB and look up using genre ids. I was able to get the genre json into an array, but can't figure out a way to find name value using id. You'll see a big chunk of commented out genre related code in the MoviesViewController.swift.
- I was trying to make a nav bar button flipping between list and grid, but not able to make it work: 1. nav bar image doesn't change even though I tried to setBackgroundImage programmatically in @IBAction func switchLayoutButtonPressed(_ sender: Any). 2. Not able to get image to show up in collectionView, not sure why.

## License

    Copyright [2017] [Yingying Zhang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
