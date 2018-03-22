# Project Title

This app hit the NY Times Most Popular Articles API and show a list of articles, that show details when items on the list are tapped.

### Prerequisites

iOS 9.1+
macOS 10.12+
XCode 9.1+
Swift 3.1+

## Running the code

- Install Xcode 9.1 or later
- open the "NYTimesArticles.xcworkspace" on Xcode
- Choose any simulator from the list
![Screenshot](/ScreenShot/chooseDevice.png)
- Hit the Play button

In case of running the code on a real device,

- Connect your device with the mac
- Choose your device from the device listing and modify the bundle identifier accordingly.
- Choose provisioning profile
- Hit the play button to run the code.

## Running the tests

### Using the Test Navigator

Hold the pointer over a bundle, class, or method name in the test navigator, a Run button appears. You can run one test, all the tests in a class, or all the tests in a bundle depending on where you hold the pointer in the test navigator list.

- To run all tests in a bundle, hold the pointer over the test bundle name and click the Run button that appears on the right.
![ScreenshotTestCase1](/ScreenShot/testCase1.png)

- To run a single test, hold the pointer over the test name and click the Run button that appears on the right.
![ScreenshotTestCase1](/ScreenShot/testCase2.png)

### Using the Source Editor

When you have a test class open in the source editor, a clear indicator appears in the gutter next to each test method name. Holding the pointer over the indicator displays a Run button. Clicking the Run button runs the test method, and the indicator then displays the pass or fail status of a test. Holding the pointer over the indicator will again display the Run button to repeat the test. This mechanism always runs just the one test at a time.
![ScreenshotTestCase1](/ScreenShot/testCase3.png)

## Code Coverage

Code coverage in Xcode is a testing option supported by LLVM. When enable code coverage, LLVM instruments the code to gather coverage data based on the frequency that methods and functions are called.

### Enable Code Coverage

- Select Edit Scheme from the scheme editor menu.
![ScreenshotTestCase1](/ScreenShot/codeCoverage1.png)

- Select the Test action.
- Enable the Code Coverage checkbox to gather coverage data.
![ScreenshotTestCase1](/ScreenShot/codeCoverage2.png)

- Click Close.
