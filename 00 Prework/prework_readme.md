# Pre-work - *Tipsyy*

**Tipsyy** is a tip calculator application for iOS.

Submitted by: **Yingying Zhang**

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

* [√] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [√] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [√] Remembering the bill amount across app restarts (if <10mins) --> Yingying: I didn't add the time limit'
* [ ] Using locale-specific currency and currency thousands separators.
* [√] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [√] List anything else that you can get done to improve the app functionality! -> Improved UI, Split Total Amount into 6, Share Split Amount

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/yzhanghearsay/iOs-dev/blob/master/Tipsyy%20Project/Tipsyy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I think Xcode is overall easy to use. My favorite part is that you have a bird view of the storyboard, very user friendly. One thing I find can easily confuse newbie users is that there are a lot of things you will need to drag and connect (e.g. control + drag an element to create an outlet, or action), it’s not easy to remember where those connections are and lots of options in the panel with dark panel in small font size - but once familiar it might be easier to work with. An Outlet is basically to call out a UI element in code, so that you make some changes with it, e.g. change its value. An Action is to create a function in code if you need to do something regarding a UI element. I checked out storyboards’ source code and noticed it was written in XML, so that we can connect UI and code - I imagine it being executed behind the scene so we can freely drag and drop UI elements and views to create code.. 

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** Define a closure, such as a class, with a list of properties and functions. One of the functions "functionName1" assigns values to one of its own properties. When create an instance of this class, use this "functionName1" to assign values to this instance, this creates a strong reference between this instance's property and the class's property. Even if one assign nil to this instance's property, there's still a strong reference that can cause memory leak.


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
