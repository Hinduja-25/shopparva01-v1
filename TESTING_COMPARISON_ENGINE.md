# Testing the Product Comparison Engine

## Backend Changes ✅
1. **Added `/api/v1/search/compare` endpoint** - Groups products by model and returns platform comparison data
2. **Enhanced product data** - Added modelName field for better product identification
3. **Best price detection** - Automatically identifies and flags the lowest price

## Frontend Changes ✅
1. **New ProductDeal model** - Handles comparison data structure
2. **Refactored DealsScreen** - Now shows product comparison cards with:
   - Product header with brand, rating, and offer count
   - Multiple platform cards showing prices
   - Best price highlighted with badge and accent color
   - Platform icons (ShopParva, Amazon, etc.)
3. **Updated SearchScreen** - Added "Compare Prices" button to navigate to Deal Tab
4. **Smart navigation** - Search query automatically drives Deal Tab content

## How to Test

### 1. Start Backend Server
```bash
cd "D:\shopparva v1\backend"
node server.js
```
Server should start on port 3000.

### 2. Test Backend API
```bash
# Test comparison endpoint
curl "http://localhost:3000/api/v1/search/compare?q=samsung"
```

Expected response format:
```json
{
  "query": "samsung",
  "results": [
    {
      "modelName": "Samsung Galaxy S23",
      "productId": "prod_123",
      "brand": "Samsung",
      "category": "Electronics",
      "rating": 4.5,
      "image": "...",
      "deals": [
        {
          "platform": "ShopParva",
          "seller": "Official Store",
          "price": 54999,
          "currency": "$",
          "url": "...",
          "isBestPrice": true
        },
        {
          "platform": "Amazon",
          "seller": "Competitor A",
          "price": 55499,
          "currency": "$",
          "url": "...",
          "isBestPrice": false
        }
      ]
    }
  ]
}
```

### 3. Run Flutter App
```bash
cd "D:\shopparva v1"
flutter run
```

### 4. Test User Flow

#### Scenario 1: Search from Home Screen
1. Open the app
2. Type "Samsung" in the home screen search bar
3. Press Enter
4. You'll navigate to Search Screen
5. Click "Compare Prices" button
6. App should navigate to Deal Tab (Price Comparison)
7. Verify you see Samsung products with platform comparison cards

#### Scenario 2: Direct Search in Deal Tab
1. Navigate to Deal Tab using bottom navigation
2. Type "Nike" in the search bar
3. Press Enter
4. Verify comparison cards appear for Nike products

#### Scenario 3: Verify Comparison UI
For each product comparison card, verify:
- ✅ Product name is displayed prominently
- ✅ Brand name and rating are shown
- ✅ Number of offers is displayed (e.g., "2 offers")
- ✅ Multiple platform cards are shown (ShopParva, Amazon)
- ✅ Best price is highlighted with "BEST PRICE" badge
- ✅ Best price card has accent color border
- ✅ Each platform shows price in correct format
- ✅ Platform icons are displayed

### 5. Test Edge Cases
- Empty search query → Should show "Start Your Search" empty state
- Search with no results → Should show "No deals found" empty state
- Switch between tabs → Deal Tab should maintain search state

## Expected Behavior

### ✅ What Should Work
1. **Search Integration**: Search from any screen should populate Deal Tab
2. **Price Comparison**: Same product shown across multiple platforms
3. **Best Price Highlighting**: Lowest price clearly marked
4. **Smart Navigation**: Seamless flow from search to comparison
5. **Empty States**: Proper messages when no data available

### 🎯 Key Features Implemented
- Product-model-centric search (not random deals)
- Platform comparison view (ShopParva vs Amazon, etc.)
- Best price detection and highlighting
- Clean, premium UI matching ShopParva theme
- Responsive and smooth animations

## Sample Search Queries
- "Samsung" → Should show Samsung products across platforms
- "Nike" → Should show Nike products with price comparison
- "LG" → Should show LG products
- "Electronics" → Should show all electronics items
- "Fashion" → Should show fashion category items

## Troubleshooting

### Backend Issues
- **Port 3000 already in use**: Kill existing node processes
  ```powershell
  Get-Process -Name node | Stop-Process -Force
  ```
- **404 errors**: Ensure backend server is running and restarted after code changes

### Frontend Issues
- **API connection fails**: Check `lib/core/constants.dart` - Should point to `http://10.0.2.2:3000/api/v1` for Android emulator
- **Comparison not showing**: Clear app data and restart
- **Navigation issues**: Ensure dealSearchQueryProvider is properly set

## Architecture Summary

### Backend Flow
```
User Query → /api/v1/search/compare
  ↓
Filter products by title/brand/category
  ↓
Group by modelName
  ↓
Extract platform offers
  ↓
Identify best price
  ↓
Return comparison structure
```

### Frontend Flow
```
HomeScreen Search → SearchScreen
  ↓
Click "Compare Prices"
  ↓
Set dealSearchQueryProvider
  ↓
Navigate to Deal Tab (index 1)
  ↓
DealsScreen watches provider
  ↓
Fetch from /search/compare
  ↓
Display comparison cards
```

## Success Criteria ✅
- [x] Backend endpoint returns proper comparison data
- [x] Deal Tab shows product comparison (not random deals)
- [x] Best price is highlighted
- [x] Search drives Deal Tab content
- [x] UI matches ShopParva theme
- [x] Empty states are handled
- [x] Navigation is smooth and intuitive
