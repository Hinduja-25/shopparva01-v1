const fs = require('fs');

const categories = ['Electronics', 'Fashion', 'Home', 'Beauty', 'Sports'];
const brands = ['Sony', 'Apple', 'Samsung', 'Nike', 'Adidas', 'LG', 'Dyson'];
const products = [];

for (let i = 1; i <= 100; i++) {
    const category = categories[Math.floor(Math.random() * categories.length)];
    const brand = brands[Math.floor(Math.random() * brands.length)];
    const price = (Math.random() * 1000 + 50).toFixed(2);

    products.push({
        id: `prod_${i}`,
        title: `${brand} ${category} Item ${i}`,
        brand: brand,
        description: `This is a high-quality ${category.toLowerCase()} product from ${brand}. Great value for money.`,
        category: category,
        images: [`https://picsum.photos/400?random=${i}`],
        rating: (Math.random() * 2 + 3).toFixed(1), // 3.0 to 5.0
        offers: [
            {
                seller: 'Official Store',
                price: parseFloat(price),
                marketplace: 'ShopParva',
                url: 'https://shopparva.com'
            },
            {
                seller: 'Competitor A',
                price: parseFloat((price * 1.1).toFixed(2)),
                marketplace: 'Amazon',
                url: 'https://amazon.com'
            }
        ]
    });
}

// Generate server.js content replacement
const serverContent = `const http = require('http');

const products = ${JSON.stringify(products, null, 2)};

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
    const results = products.filter(p => 
      p.title.toLowerCase().includes(query) || 
      p.brand.toLowerCase().includes(query) ||
      p.category.toLowerCase().includes(query)
    );
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(results));
  } 
  
  else if (path === '/api/v1/products/compare') {
      const id = url.searchParams.get('id');
      const product = products.find(p => p.id === id);
      if (product) {
          res.writeHead(200, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify(product));
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
             // Mock generation: pick random items fitting budget
             const kitItems = products.slice(0, 5); // Just pick first 5 for demo
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
console.log('server.js regenerated with 100 products');
