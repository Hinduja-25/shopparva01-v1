# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project overview
- ShopParva is a Flutter-based, multi-platform shopping experience with an AI-flavored UX: home feed, search-based smart deal finder, kit builder, and watchlist.
- The frontend is a Flutter app under `lib/` using Riverpod for state management, GoRouter for navigation, Dio for HTTP, and Freezed/JsonSerializable for immutable models.
- A lightweight Node.js mock backend under `backend/` serves product search, comparison, and kit-generation endpoints over HTTP.

## Core development commands

### Prerequisites
- Flutter SDK (stable channel)
- Node.js and npm

### Backend (mock API server)
From the repo root:
- Install dependencies (first time only):
  - `cd backend`
  - `npm install`
- Run the mock API server (defaults to `http://localhost:3000`):
  - `npm start`

The server exposes REST endpoints under `/api/v1/...` and keeps all product data in memory.

### Flutter app (frontend)
From the repo root:
- Get Flutter dependencies:
  - `flutter pub get`
- Generate code for Freezed models and Riverpod (`*.g.dart`, `*.freezed.dart`, `providers.g.dart`):
  - One-off or on demand: `dart run build_runner build --delete-conflicting-outputs`
  - During active development (auto-regeneration): `dart run build_runner watch --delete-conflicting-outputs`
- Run the app on the default device (mobile, desktop, or web depending on your Flutter setup):
  - `flutter run`

Notes:
- The API base URL is configured in `lib/core/constants.dart` as `http://localhost:3000/api/v1`. For Android emulators, you may need to switch the host to `10.0.2.2` instead of `localhost`.

### Linting and static analysis
The project uses `flutter_lints` plus additional rules in `analysis_options.yaml`.

- Run analyzer across the project:
  - `flutter analyze`

### Tests
Flutter test support is configured via `flutter_test` in `pubspec.yaml`.

- Run all tests:
  - `flutter test`
- Run a single test file:
  - `flutter test test/path_to_test.dart`

## High-level architecture

### Application entrypoint and routing
- `lib/main.dart` is the entrypoint. It wraps the app in a `ProviderScope` (Riverpod) and creates a `MaterialApp.router` configured with a `GoRouter` instance.
- Routes are declared centrally in `_router` in `main.dart`:
  - `/login` → `LoginScreen`
  - `/` → `HomeScreen`
  - `/search` → `SearchScreen`
  - `/kit-builder` → `KitBuilderScreen`
  - `/watchlist` → `WatchlistScreen`
  - `/product/:id` → `ProductDetailScreen` (takes a `productId` path parameter).
- Navigation throughout the app uses `GoRouter` extensions (`context.go`, `context.push`) rather than manual `Navigator` calls.

### Cross-cutting core layer
- `lib/core/constants.dart` holds global constants, notably `AppConstants.apiBaseUrl`, which defines the frontend → backend boundary.
- `lib/core/theme_tokens.dart` defines design tokens: colors, spacing, radii, elevation, and text styles (based on Google Fonts `inter`). These tokens are consumed by the main theme and many widgets.
- `lib/core/theme.dart` builds the concrete `ThemeData` instances:
  - Standard light and dark themes with Material 3, using the tokenized color scheme and typography.
  - High-contrast variants (`highContrastLightTheme` / `highContrastDarkTheme`) that adjust colors and font sizes for better accessibility.

### State management and domain models
- Riverpod is used as the primary state management solution with code generation via `riverpod_annotation`/`riverpod_generator`:
  - `lib/state/providers.dart` declares all app-level providers and `@riverpod`-annotated classes.
  - Generated provider code lives in `lib/state/providers.g.dart` (maintained by `build_runner`).
- Key providers in `providers.dart`:
  - `apiServiceProvider` – exposes a singleton `ApiService` instance for HTTP calls.
  - `UserState` – manages the currently logged-in `User` (mock login/logout with an in-memory user instance).
  - `Watchlist` – maintains a list of `Product` instances in the watchlist and exposes `toggle` and `isWatched` helpers.
  - `SearchResults` – a `FutureProvider.family` that takes a search query, calls the API, and returns a list of `Product` objects.
  - `highContrastProvider` – a global `StateProvider<bool>` toggling the use of the high-contrast theme.
- Domain models live under `lib/models/` and are built with Freezed and JsonSerializable:
  - `product.dart` defines `Product` and `Offer` with rich fields (id, title, description, brand, categories, rating, images, offers).
  - `kit.dart` defines `Kit` (id, name, tags, budget, list of `Product` items, totalPrice).
  - `user.dart` defines `User` (id, email, optional name, and a watchlist list).

### Networking and API boundary
- `lib/services/api_service.dart` encapsulates all HTTP interactions using Dio and `AppConstants.apiBaseUrl`:
  - `searchProducts(String query)` – POSTs a search payload and converts the JSON response into a `List<Product>`.
  - `getProductComparison(String id)` – GETs detailed info for a single product, including comparison offers, returning a `Product?`.
  - `generateKit(String type, double budget)` – POSTs kit parameters and deserializes the response into a `Kit`.
- Screens and providers do not construct HTTP clients directly; they depend on `apiServiceProvider` so the networking layer remains centralized.

### Feature modules (Flutter UI)
The UI follows a feature-first folder structure under `lib/features/`.

- **Auth (`auth/`)**
  - `login_screen.dart` implements a simple email/password login form and a "Continue as Guest" path.
  - On successful login, it updates `UserState` via `userStateProvider` and navigates to `/`.

- **Home (`home/`)**
  - `home_screen.dart` shows the main product masonry grid and the accessibility drawer.
  - It uses `searchResultsProvider('electronics')` as a surrogate "home feed" and shows an animated `AssistantFloatingWidget` overlay as a shopping assistant entrypoint.
  - The drawer exposes navigation shortcuts (`/`, `/kit-builder`, `/watchlist`) and a high-contrast mode toggle, which directly manipulates `highContrastProvider`.
  - Reusable building blocks:
    - `widgets/product_card.dart` – a card widget that displays product imagery, rating, price, and brand using `CachedNetworkImage` and semantic labels.
    - `widgets/assistant_widget.dart` – a floating, animated assistant button with tooltip and accessibility semantics.

- **Search (`search/`)**
  - `search_screen.dart` provides an AppBar-embedded search field and drives `searchResultsProvider` with the current query.
  - Results are rendered using the same `ProductCard` widget, and tapping an item navigates to `/product/:id`.

- **Product detail (`product/`)**
  - `product_detail_screen.dart` is the detail view for a product, composed with multiple async providers:
    - `productDetailsProvider` (a `FutureProvider.family`) fetches full product details via `apiServiceProvider.getProductComparison`.
    - `priceHistoryProvider` synthesizes or fetches a list of `(date, price)` records for charting.
  - The screen is built using a `CustomScrollView` and `SliverAppBar` with a `Hero` image, primary pricing, description, comparison table, and price history chart.
  - Supporting widgets:
    - `widgets/comparison_table.dart` – given a list of `Offer`, it sorts by price, highlights the best deal, and surfaces marketplace/seller info.
    - `widgets/price_chart.dart` – renders a small line chart using `fl_chart` from the synthetic price history data.
  - Integration with `Watchlist`:
    - The detail screen reads and toggles watchlist membership via `watchlistProvider`, surfacing state as a heart icon in the app bar.

- **Kit builder (`kit_builder/`)**
  - `kit_builder_screen.dart` implements a multi-step "wizard" using `StepperType.horizontal` to gather:
    - Use case (e.g., Gaming, Office, Content Creation, Streaming).
    - Selected components (CPU, GPU, RAM, etc.).
    - Budget (slider-based).
  - It uses a local `StateProvider` (`localKitProvider`) to track the async generation state (`AsyncValue`) and calls `apiServiceProvider.generateKit(...)` with a synthesized query string and budget.
  - The resulting `Kit` is displayed in a bottom sheet with summary pricing and a list of items, each linkable to its product detail route.

- **Watchlist (`watchlist/`)**
  - `watchlist_screen.dart` reads from `watchlistProvider` and shows a simple list of saved products with thumbnail, title, current price, and a delete button.
  - Tapping a product navigates to its detail page; deleting calls `watchlistProvider.toggle`.

### Backend mock server
- The backend lives in `backend/` and is currently a single `server.js` file plus `package.json` with a `start` script.
- It uses Node's built-in `http` module and maintains a large in-memory array of `products`, each with `id`, `title`, `brand`, `description`, `category`, `images`, `rating`, and a list of `offers`.
- Key HTTP endpoints (all prefixed with `/api/v1`):
  - `GET /api/v1/products/search?q=<query>` – filters products by title, brand, or category and returns a JSON array.
  - `GET /api/v1/products/compare?id=<id>` – returns a single product (including its offers) for comparison; 404 if not found.
  - `POST /api/v1/kits/generate` – accepts a JSON body with `{ type, budget }`, picks a subset of products, and returns a synthetic `kit` object (id, name, budget, items, totalPrice).
- There is no persistence layer; restarting the server resets all data to the hard-coded product list.

### Code generation and when to run it
- Any changes to `@freezed` models (`lib/models/*.dart`) or to `@riverpod` providers (`lib/state/providers.dart`) require regenerating the associated `*.g.dart` / `*.freezed.dart` files.
- Use `dart run build_runner build --delete-conflicting-outputs` (or the `watch` variant) after such changes so that providers and models stay in sync with their generated counterparts.
