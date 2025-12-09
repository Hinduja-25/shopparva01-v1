import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../state/providers.dart';
import '../../core/theme_tokens.dart';
import 'widgets/product_card.dart';
import 'widgets/assistant_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> _categories = const ['All', 'Electronics', 'Fashion', 'Home', 'Beauty', 'Sports'];
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final homeFeed = ref.watch(homeFeedProvider);
    final isHighContrast = ref.watch(highContrastProvider);
    final user = ref.watch(userStateProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [ThemeTokens.primary, ThemeTokens.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name != null ? 'Welcome, ${user!.name}' : 'Welcome to ShopParva',
              style: ThemeTokens.bodySmall.copyWith(color: Colors.white70),
            ),
            Text(
              'Smart price comparison',
              style: ThemeTokens.headlineMedium.copyWith(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () => context.push('/watchlist'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: ThemeTokens.primary),
                accountName: Text(user?.name ?? 'Guest', style: const TextStyle(fontWeight: FontWeight.bold)),
                accountEmail: Text(user?.email ?? ''),
             ),
             ListTile(
               title: const Text('Home'),
               leading: const Icon(Icons.home),
               onTap: () => context.go('/'),
             ),
             ListTile(
               title: const Text('Kit Builder'),
               leading: const Icon(Icons.build),
               onTap: () => context.push('/kit-builder'),
             ),
             SwitchListTile.adaptive(
               title: const Text('High contrast mode'),
               secondary: const Icon(Icons.contrast),
               value: isHighContrast,
               onChanged: (value) => ref.read(highContrastProvider.notifier).state = value,
             ),
             const Divider(),
             ListTile(
               title: const Text('Sign Out'),
               leading: const Icon(Icons.logout),
               onTap: () {
                 ref.read(userStateProvider.notifier).logout();
                 context.go('/login');
               },
             ),
          ],
        ),
      ),
      body: Stack(
        children: [
          homeFeed.when(
            data: (products) {
              if (products.isEmpty) {
                 return const Center(child: Text('No products found. Please make sure the backend server is running.'));
              }

              final filteredProducts = _selectedCategory == 'All'
                  ? products
                  : products
                      .where((p) => p.categories.contains(_selectedCategory))
                      .toList();

              if (filteredProducts.isEmpty) {
                return Center(child: Text('No products in the $_selectedCategory category yet.'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 900 
                      ? 4 
                      : constraints.maxWidth > 600 ? 3 : 2;
                    
                    return MasonryGridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: filteredProducts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _HomeHeroSection(
                            categories: _categories,
                            selectedCategory: _selectedCategory,
                            onCategorySelected: (value) {
                              setState(() => _selectedCategory = value);
                            },
                          );
                        }

                        final product = filteredProducts[index - 1];
                        return SizedBox(
                          child: ProductCard(
                            product: product,
                            onTap: () => context.push('/product/${product.id}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          AssistantFloatingWidget(
            onTap: () {
               showDialog(context: context, builder: (_) => AlertDialog(
                 title: const Text("Shopping Assistant"),
                 content: const Text("I can help you find the best deals! Try searching for a brand like 'Sony' or 'Apple'."),
                 actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
               ));
            },
          ),
        ],
      ),
    );
  }
}

class _HomeHeroSection extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const _HomeHeroSection({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ThemeTokens.primary, ThemeTokens.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compare prices across marketplaces',
            style: ThemeTokens.headlineMedium.copyWith(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse curated products and instantly spot the best deal before you buy.',
            style: ThemeTokens.bodyMedium.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in categories)
                ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  selectedColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selectedCategory == category
                        ? ThemeTokens.primary
                        : Colors.white,
                  ),
                  backgroundColor: Colors.white.withOpacity(0.15),
                  onSelected: (_) => onCategorySelected(category),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
