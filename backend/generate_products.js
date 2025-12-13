const fs = require('fs');

// Realistic product catalog with multiple platform offers
const productModels = [
    // Electronics - Smartphones
    {
        modelName: "Apple iPhone 14 Pro",
        brand: "Apple",
        category: "Electronics",
        description: "6.1-inch Super Retina XDR display with ProMotion. A16 Bionic chip. Pro camera system with 48MP Main camera. Up to 29 hours video playback.",
        rating: 4.7,
        image: "https://picsum.photos/400?random=iphone14",
        platforms: [
            { marketplace: "Amazon", seller: "Amazon India", price: 119900, discount: "10%", delivery: "2 days" },
            { marketplace: "Flipkart", seller: "Flipkart Retail", price: 121499, discount: "8%", delivery: "3 days" },
            { marketplace: "Croma", seller: "Croma Retail", price: 124990, discount: "5%", delivery: "5 days" },
            { marketplace: "Reliance Digital", seller: "Reliance Digital", price: 122900, discount: "7%", delivery: "4 days" },
        ]
    },
    {
        modelName: "Samsung Galaxy S23 Ultra",
        brand: "Samsung",
        category: "Electronics",
        description: "6.8-inch Dynamic AMOLED 2X display. Snapdragon 8 Gen 2. 200MP camera with 100x Space Zoom. S Pen included. All-day battery.",
        rating: 4.6,
        image: "https://picsum.photos/400?random=s23ultra",
        platforms: [
            { marketplace: "Amazon", seller: "Appario Retail", price: 109999, discount: "15%", delivery: "1 day" },
            { marketplace: "Flipkart", seller: "Samsung Brand Store", price: 112999, discount: "12%", delivery: "2 days" },
            { marketplace: "Myntra", seller: "Myntra Electronics", price: 114999, discount: "10%", delivery: "4 days" },
            { marketplace: "Croma", seller: "Croma", price: 111499, discount: "13%", delivery: "3 days" },
            { marketplace: "ShopParva", seller: "ShopParva Official", price: 108999, discount: "16%", delivery: "2 days" },
        ]
    },
    {
        modelName: "OnePlus 11 5G",
        brand: "OnePlus",
        category: "Electronics",
        description: "6.7-inch AMOLED display with 120Hz. Snapdragon 8 Gen 2. Hasselblad Camera for Mobile. 100W SUPERVOOC fast charging.",
        rating: 4.5,
        image: "https://picsum.photos/400?random=oneplus11",
        platforms: [
            { marketplace: "Amazon", seller: "OnePlus Official", price: 56999, discount: "12%", delivery: "2 days" },
            { marketplace: "Flipkart", seller: "Flipkart", price: 58499, discount: "10%", delivery: "3 days" },
            { marketplace: "Reliance Digital", seller: "Reliance Digital", price: 59999, discount: "8%", delivery: "5 days" },
        ]
    },

    // Electronics - Laptops
    {
        modelName: "MacBook Air M2",
        brand: "Apple",
        category: "Electronics",
        description: "13.6-inch Liquid Retina display. Apple M2 chip with 8-core CPU. 8GB unified memory. 256GB SSD storage. All-day battery life.",
        rating: 4.8,
        image: "https://picsum.photos/400?random=macbookair",
        platforms: [
            { marketplace: "Amazon", seller: "Appario Retail", price: 114900, discount: "5%", delivery: "3 days" },
            { marketplace: "Flipkart", seller: "Apple Authorized", price: 116900, discount: "3%", delivery: "4 days" },
            { marketplace: "Croma", seller: "Croma Electronics", price: 119900, discount: "0%", delivery: "2 days" },
            { marketplace: "Reliance Digital", seller: "Reliance Digital", price: 117900, discount: "2%", delivery: "5 days" },
        ]
    },
    {
        modelName: "Dell XPS 13",
        brand: "Dell",
        category: "Electronics",
        description: "13.4-inch FHD+ display. 12th Gen Intel Core i7. 16GB RAM. 512GB SSD. Premium InfinityEdge display.",
        rating: 4.5,
        image: "https://picsum.photos/400?random=dellxps",
        platforms: [
            { marketplace: "Amazon", seller: "Dell Official", price: 109990, discount: "8%", delivery: "4 days" },
            { marketplace: "Flipkart", seller: "RetailNet", price: 112490, discount: "6%", delivery: "5 days" },
            { marketplace: "Croma", seller: "Croma", price: 114990, discount: "4%", delivery: "3 days" },
        ]
    },

    // Electronics - Headphones
    {
        modelName: "Sony WH-1000XM5",
        brand: "Sony",
        category: "Electronics",
        description: "Industry-leading noise cancellation. 30-hour battery life. Premium sound quality with LDAC. Multipoint connection.",
        rating: 4.7,
        image: "https://picsum.photos/400?random=sonywh1000",
        platforms: [
            { marketplace: "Amazon", seller: "Cloudtail India", price: 29990, discount: "15%", delivery: "1 day" },
            { marketplace: "Flipkart", seller: "Sony India", price: 31490, discount: "12%", delivery: "2 days" },
            { marketplace: "Myntra", seller: "Myntra Audio", price: 32990, discount: "10%", delivery: "3 days" },
            { marketplace: "Croma", seller: "Croma", price: 30990, discount: "13%", delivery: "2 days" },
            { marketplace: "ShopParva", seller: "ShopParva", price: 29490, discount: "16%", delivery: "1 day" },
        ]
    },

    // Fashion - Shoes
    {
        modelName: "Nike Air Max 270",
        brand: "Nike",
        category: "Fashion",
        description: "Max Air unit for ultimate cushioning. Breathable mesh upper. Durable rubber outsole. Iconic Nike style.",
        rating: 4.4,
        image: "https://picsum.photos/400?random=nikeairmax",
        platforms: [
            { marketplace: "Amazon", seller: "Nike Official", price: 12995, discount: "20%", delivery: "3 days" },
            { marketplace: "Flipkart", seller: "Nike Store", price: 13495, discount: "18%", delivery: "4 days" },
            { marketplace: "Myntra", seller: "Myntra Fashion", price: 12795, discount: "21%", delivery: "2 days" },
            { marketplace: "ShopParva", seller: "ShopParva Sports", price: 12495, discount: "23%", delivery: "3 days" },
        ]
    },
    {
        modelName: "Adidas Ultraboost 22",
        brand: "Adidas",
        category: "Fashion",
        description: "Responsive BOOST cushioning. Primeknit+ upper. Continental rubber outsole. Energy-returning performance.",
        rating: 4.6,
        image: "https://picsum.photos/400?random=ultraboost",
        platforms: [
            { marketplace: "Amazon", seller: "Adidas Official", price: 16999, discount: "15%", delivery: "2 days" },
            { marketplace: "Flipkart", seller: "Adidas Store", price: 17499, discount: "12%", delivery: "3 days" },
            { marketplace: "Myntra", seller: "Myntra", price: 16799, discount: "16%", delivery: "2 days" },
        ]
    },

    // Fashion - Apparel
    {
        modelName: "Levi's 501 Original Jeans",
        brand: "Levi's",
        category: "Fashion",
        description: "Classic straight fit. Button fly. Iconic 501 style. Premium denim quality. Timeless design.",
        rating: 4.5,
        image: "https://picsum.photos/400?random=levis501",
        platforms: [
            { marketplace: "Amazon", seller: "Levi's Official", price: 3999, discount: "25%", delivery: "3 days" },
            { marketplace: "Flipkart", seller: "Levi's Store", price: 4199, discount: "22%", delivery: "4 days" },
            { marketplace: "Myntra", seller: "Myntra Fashion", price: 3899, discount: "27%", delivery: "2 days" },
            { marketplace: "ShopParva", seller: "ShopParva Fashion", price: 3799, discount: "29%", delivery: "3 days" },
        ]
    },

    // Home - Appliances
    {
        modelName: "Dyson V15 Detect",
        brand: "Dyson",
        category: "Home",
        description: "Laser dust detection. Powerful suction. LCD screen shows particle count. Up to 60 minutes runtime.",
        rating: 4.8,
        image: "https://picsum.photos/400?random=dysonv15",
        platforms: [
            { marketplace: "Amazon", seller: "Dyson India", price: 58900, discount: "10%", delivery: "4 days" },
            { marketplace: "Flipkart", seller: "Dyson Official", price: 59900, discount: "8%", delivery: "5 days" },
            { marketplace: "Croma", seller: "Croma", price: 61900, discount: "5%", delivery: "3 days" },
            { marketplace: "Reliance Digital", seller: "Reliance Digital", price: 60900, discount: "7%", delivery: "4 days" },
        ]
    },
    {
        modelName: "LG 55-inch OLED TV",
        brand: "LG",
        category: "Home",
        description: "4K OLED display. α9 Gen5 AI Processor. Dolby Vision IQ. webOS smart platform. Perfect for gaming.",
        rating: 4.7,
        image: "https://picsum.photos/400?random=lgoled",
        platforms: [
            { marketplace: "Amazon", seller: "Cloudtail", price: 129990, discount: "12%", delivery: "5 days" },
            { marketplace: "Flipkart", seller: "LG Official", price: 132990, discount: "10%", delivery: "6 days" },
            { marketplace: "Croma", seller: "Croma Electronics", price: 127990, discount: "13%", delivery: "4 days" },
            { marketplace: "Reliance Digital", seller: "Reliance Digital", price: 131990, discount: "11%", delivery: "5 days" },
            { marketplace: "ShopParva", seller: "ShopParva Home", price: 126990, discount: "14%", delivery: "5 days" },
        ]
    },

    // Beauty
    {
        modelName: "Dyson Airwrap Styler",
        brand: "Dyson",
        category: "Beauty",
        description: "Multi-styler for multiple hair types. Coanda effect styling. No extreme heat. Complete styling system.",
        rating: 4.6,
        image: "https://picsum.photos/400?random=airwrap",
        platforms: [
            { marketplace: "Amazon", seller: "Dyson Official", price: 45900, discount: "8%", delivery: "3 days" },
            { marketplace: "Flipkart", seller: "Dyson India", price: 46900, discount: "6%", delivery: "4 days" },
            { marketplace: "Myntra", seller: "Myntra Beauty", price: 47900, discount: "4%", delivery: "5 days" },
            { marketplace: "Croma", seller: "Croma", price: 46400, discount: "7%", delivery: "3 days" },
        ]
    },

    // Sports
    {
        modelName: "Yonex Astrox 99 Pro",
        brand: "Yonex",
        category: "Sports",
        description: "Professional badminton racket. Rotational Generator System. Namd graphite. Head-heavy balance for power.",
        rating: 4.7,
        image: "https://picsum.photos/400?random=yonex",
        platforms: [
            { marketplace: "Amazon", seller: "Yonex Official", price: 16990, discount: "10%", delivery: "3 days" },
            { marketplace: "Flipkart", seller: "Sports365", price: 17490, discount: "8%", delivery: "4 days" },
            { marketplace: "ShopParva", seller: "ShopParva Sports", price: 16790, discount: "11%", delivery: "3 days" },
        ]
    },
];

// Generate products array with individual entries for each platform
const products = [];
let productId = 1;

productModels.forEach(model => {
    model.platforms.forEach(platform => {
        products.push({
            id: `prod_${productId++}`,
            title: model.modelName,
            modelName: model.modelName,
            brand: model.brand,
            description: model.description,
            category: model.category,
            images: [model.image],
            rating: model.rating.toString(),
            offers: [{
                seller: platform.seller,
                price: platform.price,
                marketplace: platform.marketplace,
                url: `https://${platform.marketplace.toLowerCase().replace(' ', '')}.com`,
                discount: platform.discount,
                delivery: platform.delivery
            }]
        });
    });
});

console.log(`Generated ${products.length} product entries from ${productModels.length} models`);

// Generate server.js with enhanced comparison logic
const serverContent = `const http = require('http');

const products = ${JSON.stringify(products, null, 2)};

function normalizeProduct(product) {
  if (!product) return product;

  const categories = Array.isArray(product.categories)
    ? product.categories
    : [product.category];

  const rating = typeof product.rating === 'string'
    ? Number(product.rating)
    : product.rating;

  const modelName = product.modelName || product.title;

  return { ...product, categories, rating, modelName };
}

function normalizeQuery(query) {
  // Remove noise words and normalize
  const noiseWords = ['buy', 'price', 'online', 'best', 'cheapest', 'deal', 'offer'];
  let normalized = query.toLowerCase().trim();
  
  noiseWords.forEach(word => {
    normalized = normalized.replace(new RegExp(\`\\\\b\${word}\\\\b\`, 'gi'), '');
  });
  
  return normalized.trim().replace(/\\s+/g, ' ');
}

function groupProductsByModel(products) {
  const grouped = {};
  
  products.forEach(product => {
    const modelName = product.modelName || product.title;
    if (!grouped[modelName]) {
      grouped[modelName] = {
        modelName: modelName,
        productId: product.id,
        brand: product.brand,
        category: product.category,
        rating: typeof product.rating === 'string' ? Number(product.rating) : product.rating,
        image: product.images && product.images.length > 0 ? product.images[0] : '',
        deals: []
      };
    }
    
    // Add each offer as a deal
    if (product.offers && product.offers.length > 0) {
      product.offers.forEach(offer => {
        grouped[modelName].deals.push({
          platform: offer.marketplace || 'Unknown',
          seller: offer.seller || 'Unknown',
          price: offer.price,
          url: offer.url || '',
          currency: '₹',
          discount: offer.discount || null,
          delivery: offer.delivery || null
        });
      });
    }
  });
  
  // Identify best price for each model and sort deals by price
  Object.values(grouped).forEach(model => {
    if (model.deals.length > 0) {
      // Sort deals by price (lowest first)
      model.deals.sort((a, b) => a.price - b.price);
      
      // Mark best price
      const minPrice = Math.min(...model.deals.map(d => d.price));
      model.deals.forEach(deal => {
        deal.isBestPrice = deal.price === minPrice;
      });
    }
  });
  
  return Object.values(grouped);
}

const server = http.createServer((req, res) => {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  const url = new URL(req.url, \`http://\${req.headers.host}\`);
  const path = url.pathname;

  if (path === '/api/v1/products/search') {
    const query = url.searchParams.get('q')?.toLowerCase() || '';
    const results = products
      .filter(p =>
        p.title.toLowerCase().includes(query) ||
        p.brand.toLowerCase().includes(query) ||
        p.category.toLowerCase().includes(query) ||
        (p.modelName && p.modelName.toLowerCase().includes(query))
      )
      .map(normalizeProduct);
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(results));
  }

  else if (path === '/api/v1/search/compare') {
    const query = url.searchParams.get('q')?.toLowerCase() || '';
    const normalizedQuery = normalizeQuery(query);
    
    // Filter products matching query (search in title, brand, modelName)
    const matchedProducts = products.filter(p =>
      p.title.toLowerCase().includes(normalizedQuery) ||
      p.brand.toLowerCase().includes(normalizedQuery) ||
      (p.modelName && p.modelName.toLowerCase().includes(normalizedQuery)) ||
      p.category.toLowerCase().includes(normalizedQuery) ||
      p.description.toLowerCase().includes(normalizedQuery)
    );
    
    // Group by model and create comparison structure
    const comparisonResults = groupProductsByModel(matchedProducts);
    
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      query: query,
      normalizedQuery: normalizedQuery,
      results: comparisonResults
    }));
  }

  else if (path === '/api/v1/products/compare') {
    const id = url.searchParams.get('id');
    const product = products.find(p => p.id === id);
    if (product) {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify(normalizeProduct(product)));
    } else {
      res.writeHead(404);
      res.end(JSON.stringify({ error: 'Not found' }));
    }
  }

  else if (path === '/api/v1/kits/generate') {
    if (req.method === 'POST') {
      let body = '';
      req.on('data', chunk => body += chunk);
      req.on('end', () => {
        const { type, budget } = JSON.parse(body || '{}');
        const kitItems = products.slice(0, 5).map(normalizeProduct);
        const totalPrice = kitItems.reduce((sum, item) => sum + item.offers[0].price, 0);

        const kit = {
          id: "kit_" + Date.now(),
          name: \`\${type} Build\`,
          budget: budget,
          items: kitItems,
          totalPrice: totalPrice
        };
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(kit));
      });
    }
  }

  else if (path === '/api/v1/user/profile') {
    const mockProfile = {
      id: "user_123",
      name: "Demo User",
      email: "demo@shopparva.com",
      preferences: {
        theme: "dark",
        notifications: true
      }
    };
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(mockProfile));
  }

  else if (path === '/api/v1/ar-assets') {
    const assets = [
      { id: "ar_1", type: "glasses", modelUrl: "/models/glasses.glb", preview: "/images/glasses_preview.png" }
    ];
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(assets));
  }

  else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(\`Server running on port \${PORT}\`);
});
`;

fs.writeFileSync('server.js', serverContent);
console.log('✅ server.js generated with realistic product comparison data');
console.log('📊 Product Models:', productModels.length);
console.log('📦 Total Product Entries:', products.length);
console.log('🏪 Platforms: Amazon, Flipkart, Myntra, Croma, Reliance Digital, ShopParva');
