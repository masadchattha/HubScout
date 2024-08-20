# HubScout

HubScout is an iOS app designed for GitHub enthusiasts to easily search for users, explore profiles, and discover followers. Whether you're a developer looking to connect with peers, scout for talent, or just stay updated on trends, HubScout has you covered. With its user-friendly interface, navigating GitHub profiles and repositories is effortless, giving you comprehensive insights into user activity.

## Features

- **GitHub User Search**: Quickly search for GitHub users by username.
- **User Profiles**: View detailed GitHub profiles, including user bio, repositories, and activity.
- **Followers List**: Browse and interact with user followers.
- **Favorite Users**: Save and manage your favorite GitHub users.
- **Custom UI Elements**: Leverage customized UI elements for a seamless user experience.
- **Support for iOS 17**: Fully updated to support the latest iOS features and enhancements.

## Recent Enhancements

Below is a summary of recent enhancements made to HubScout, reflecting the latest updates in the iOS development landscape:

1. **Removed Hardcoded Image Names**:
   - Switched from `UIImage(named:)` to `UIImage(resource:)` to minimize typos and leverage auto-generated resource names in Xcode.

2. **SwiftUI Previews**:
   - Added SwiftUI previews for UIKit components using Xcode 15's new `#Preview` macro.

3. **Content Unavailable Configuration**:
   - Implemented `updateContentUnavailableConfiguration` for default content unavailable views, replacing the custom `HSEmptyStateView`.

4. **iOS 17 Project Updates**:
   - Updated the iOS development target to 17.0.
   - Removed backward compatibility code and unused code for cleaner project maintenance.

5. **Diffable Data Sources**:
   - Converted collection views to use diffable data sources for a more modern and efficient data handling approach.

6. **Async/Await Migration**:
   - Migrated network calls to use `async/await` for a cleaner and more readable asynchronous code.

7. **Persistent Manager**:
   - Implemented a Persistent Manager to handle favoriting users, making it easier to manage user data across sessions.

8. **Scroll Handling**:
   - Improved scroll-to-top functionality in collection views for better user experience.

9. **Improved UI Interactions**:
   - Added swipe-to-delete functionality in favorites and updated navigation across the app.

10. **Dynamic Type Support**:
    - Ensured that custom UI elements like `HSBodyLabel` adopt dynamic type for accessibility.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/masadchattha/HubScout.git
   ```
2. Open `HubScout.xcodeproj` in Xcode.
3. Select the HubScout target and build the project.
4. Run on a device or simulator with iOS 17 or later.

## Usage

- Search for GitHub users using the search bar.
- Tap on any user to view their detailed profile.
- Use the favorites feature to save users for quick access later.
- Enjoy a smooth experience with custom-designed UI elements and latest iOS features.

## Contribution

Contributions are welcome! If you have any ideas, bug fixes, or new features, please open a pull request.
