# Gotchu

## Introduction

Gotchu is a mobile iOS app that makes it easy for individuals to post and claim free items in their community. Utilizing a Google Firebase backend and a Swift iOS frontend, Gotchu provides a simplified user-friendly platform for exchanging goods. Whether you have items to give away or are in need of items, Gotchu streamlines the process and eliminates the hassle of navigating multiple buy-sell platforms.

## Dependencies

Google Firebase:

-   Firebase Auth

-   FirebaseFirestore

-   Firebase Storage

SDWebImageSwiftUI

## Installation

1.  Install Xcode.

Xcode is Apple's integrated development environment (IDE) used to develop software for macOS, iOS, iPadOS, watchOS, and tvOS. You can download the current release, Xcode 14 for free [here](https://developer.apple.com/xcode/). You will need Xcode to make any edits to the app code.

2.  Clone this repository in Xcode.

    1.  Copy the URL needed to clone the repo.

    2.  Open Xcode → click 'Clone an existing project' → Enter repo URL.

    3.  Save the cloned project to your computer.

3.  Connect Firebase to the app. 

    1.  Download the file GoogleService-Info.plist (firebase iOS config file).

    2.  Save the file to the root of the project.![](https://lh5.googleusercontent.com/4xTNsjjppf5f6kmop2JwgTO1mSXIKF6sD0o4GejfyI-R2DZZuiSVvHTwAGR8pxcobsUvknzxqKwD558uFp7iDBli56WuvlyWHve1SiCVLK0F3eZuE9UmEvr5zxw5EvWEyR-64wF5WgxYApeCrLvvvc8)

    This is how your file directory should look like with the added plist file: 

    ![](https://lh6.googleusercontent.com/w1hi5EMQ9So9BbmLzkg3qhaB8L9lQU2zpdua7LuzCSWVL8bOqRpFn2i7yOr0G6e4W0yfPFacCVAYbLXuEk09H9rxb4KVO1eUwYNPCW7YANrxJVUF1MM6LNxPgAScR9RK1bHA_Iku4fPRtO2F9g_vaI4)

3.  Launch the app via the Simulator or a real iPhone.

  **Simulator:** Xcode contains a powerful developer tool called Simulator that allows you to build and run the app on a simulated or real device without needing to lay out the user interface or write code. We recommend using the Simulator if you do not have access to an iPhone. If you do have an iPhone and wish to use it, follow the instructions below.

**Real device set up:**

**NOTE:** For development purposes, you will need to create a personal Apple ID if you do not already have one.

1.  Go to the project root NewTestProject folder in Xcode.

2.  Click 'Signing & Compatibilities'. Under 'Team', you'll want to click 'Add an Account' which will prompt you to sign in with your Apple ID. Assign your apple ID to Team. See below:

![](https://lh3.googleusercontent.com/TrlxNEeEQ_0z0J5GzjVak60QzEv0DD95Nonj6cDlUjym51uzipnXPrcSswnSNbZ_lds450445f1amRoW7Ibs9qOQRKESimSNz-qkM-iixuFk9jpZHPQ6p8Xk-4HPQUojxvNkHTYWJzoDuzZEV-Tk0j0)

3.  If this is your first time running a developer app on your device, you will need to enable Developer Mode. If you have already done this, you can skip this step. Instructions for enabling Developer Mode were taken from [here](https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device).

     1.  On your device, open Settings > Privacy & Security.

     2.  Scroll down to the Developer Mode list item and navigate into it. To toggle Developer mode, use the "Developer Mode" switch.

     ![](https://lh3.googleusercontent.com/D4qCCEC6Jei0Z3ZLoRAbZxuq4wUGDKbmfN--YNgOHyilVJywTSKYrSusJxl3z-dk609TxZPxCG6x5BeA5VdhXrRDUcZMRmJ3JXETSukxLNMD_bA4j-zZKIeGKWRJ6T0KuBW7dVJY-cW56El1PNRXUO8)

4.  Connect iPhone to computer via cable. Unlock the device. It may take a second for Xcode to prepare your device for development. The status bar will read Ready when it's finished preparing your device.  

5.  Choose your real device or Simulator device from the 'Run Destination' menu.

![](https://lh6.googleusercontent.com/Usshg6hTrhktvrIZ0igyh_ulCBSSU_Xk4lQWjO-s1s-5kWQzhnVuHHUJhGPF2VWy1_vfKYhNrU9a-0Z6UaG3Dg5hRm8zVr36XUvw9v8UwdlaFKmNIt42wf3NF3vTULv0zVKCG5ptPj56nrxObfPlo5A)

6\. Click the Play Button to begin the app launch on your chosen device or simulator. For real device, once the app finishes installing, you can unplug your phone from the computer and run the app independent of Xcode. Anytime, you make edits to the code, you will need to plug it back in to re-install the new version.
