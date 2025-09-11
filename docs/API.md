### Furniture_app – API and Component Documentation

This document describes all non-private SwiftUI components and helper APIs in the project, including examples and usage notes.

## Module overview
- **Entry point**: `Furniture_appApp`
- **Root view**: `ContentView`
- **Screens**: `HomeScreen`, `DetailScreen`
- **Reusable components (Home)**: `HomeScreen.AppBarView`, `HomeScreen.TagLineView`, `HomeScreen.SearchAndScanView`, `HomeScreen.CategoryView`, `HomeScreen.ProductCardView`, `HomeScreen.BottomNavBarItem`
- **Reusable components (Detail)**: `DescriptionView`, `ColorDotView`
- **Utilities**: `RoundedCorner` (`Shape`), `View.cornerRadius(_:corners:)`

Note: Components declared inside `HomeScreen` are nested types. From outside `HomeScreen`, reference them with the fully-qualified names (e.g., `HomeScreen.ProductCardView`).

## App entry
- **`Furniture_appApp: App`**
  - Creates a window group with `ContentView()`.
  - Usage: No direct usage beyond app launch.

```swift
@main
struct Furniture_appApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

- **`ContentView: View`**
  - Hosts the main `HomeScreen`.
  - Example:
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            HomeScreen()
        }
    }
}
```

## Screens
- **`HomeScreen: View`**
  - A `NavigationView`-based home screen with:
    - App bar, tagline, search, category selector
    - Two horizontal product sections: “Popular” and “Recommended”
    - Bottom navigation bar
  - Navigates to `DetailScreen` via `NavigationLink` for each product card.
  - Example:
```swift
struct SomeParentView: View {
    var body: some View {
        HomeScreen() // full home experience
    }
}
```

- **`DetailScreen: View`**
  - Product details screen with image, description, color dots, quantity, and an “Add To Cart” bar pinned at bottom.
  - Example:
```swift
NavigationLink("Open Details") { DetailScreen() }
```

## Home – nested components
These are declared inside `HomeScreen` and should be referenced externally as `HomeScreen.X`.

- **`HomeScreen.AppBarView: View`**
  - Top bar with menu and profile buttons.
  - Example:
```swift
HomeScreen.AppBarView()
```

- **`HomeScreen.TagLineView: View`**
  - Displays the “Find The Best Furniture!” tagline using custom fonts/colors.
  - Example:
```swift
HomeScreen.TagLineView()
```

- **`HomeScreen.SearchAndScanView: View`**
  - Search text field with a scan action button.
  - Example:
```swift
HomeScreen.SearchAndScanView()
```

- **`HomeScreen.CategoryView: View`**
  - Renders a category label with an underlined active indicator.
  - Props:
    - `isActive: Bool`
    - `text: String`
  - Example:
```swift
HomeScreen.CategoryView(isActive: true, text: "Chair")
```

- **`HomeScreen.ProductCardView: View`**
  - Displays a product image, title, star rating, and price.
  - Props:
    - `image: Image`
    - `size: CGFloat` (card width)
  - Example:
```swift
HomeScreen.ProductCardView(image: Image("chair_1"), size: 210)
```

- **`HomeScreen.BottomNavBarItem: View`**
  - Bottom navigation bar button with icon and action.
  - Props:
    - `image: Image`
    - `action: () -> Void`
  - Example:
```swift
HomeScreen.BottomNavBarItem(image: Image("Home")) {
    // handle tap
}
```

## Detail – components and helpers
- **`DescriptionView: View`**
  - Product title, rating, description, size/treatment specs, color dots, and quantity controls.
  - Example:
```swift
DescriptionView()
```

- **`ColorDotView: View`**
  - Circular color swatch.
  - Props:
    - `color: Color`
  - Example:
```swift
ColorDotView(color: .black)
```

- **`RoundedCorner: Shape`**
  - Creates a path with per-corner radii via `UIBezierPath`.
  - Initializers:
    - `radius: CGFloat = .infinity`
    - `corners: UIRectCorner = .allCorners`
  - Typical use via the `View` extension below.

- **`View.cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View`**
  - Applies corner radius to specific corners.
  - Example:
```swift
VStack { /* content */ }
    .background(Color("Primary"))
    .cornerRadius(50, corners: .topLeft)
```

## Navigation patterns
- From `HomeScreen`, products are wrapped in `NavigationLink` to `DetailScreen`.
```swift
NavigationLink(destination: DetailScreen()) {
    HomeScreen.ProductCardView(image: Image("chair_1"), size: 210)
}
```

## Assets, colors, and fonts
- Color assets used: `"Bg"`, `"Primary"`.
- Image assets used include: `"menu"`, `"Profile"`, `"Search"`, `"Scan"`, `"star"`, `"Home"`, `"fav"`, `"shop"`, `"User"`, and product images like `"chair_1"` … `"chair_4"`.
- Custom fonts referenced: `PlayfairDisplay-Regular`, `PlayfairDisplay-Bold`.

Ensure these exist in the asset catalog and project settings for correct rendering.

## Previews
- `HomeScreen_Previews` and `#Preview` for `DetailScreen` are provided for Xcode previews.
```swift
#Preview { DetailScreen() }
```

## Integration examples
Combine pieces to build custom layouts or reuse items in other views:
```swift
struct CustomListItem: View {
    var body: some View {
        HStack(spacing: 16) {
            HomeScreen.ProductCardView(image: Image("chair_2"), size: 160)
            VStack(alignment: .leading) {
                HomeScreen.TagLineView()
                HomeScreen.CategoryView(isActive: false, text: "Sofa")
            }
        }
        .padding()
    }
}
```

```swift
struct BottomBar: View {
    var body: some View {
        HStack {
            HomeScreen.BottomNavBarItem(image: Image("Home")) { /* ... */ }
            HomeScreen.BottomNavBarItem(image: Image("fav")) { /* ... */ }
            HomeScreen.BottomNavBarItem(image: Image("shop")) { /* ... */ }
            HomeScreen.BottomNavBarItem(image: Image("User")) { /* ... */ }
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}
```

## Notes on access control
- Swift defaults to `internal` access for types and members unless marked `private` or `public`.
- This app does not declare `public` types; components are intended for in-module reuse. Private helpers inside `HomeScreen` (e.g., `categoryScrollView`, `productSection`) are intentionally not part of the public surface.

