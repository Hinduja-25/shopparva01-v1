import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme_tokens.dart';
import '../models/product_deal.dart';
import '../state/app_providers.dart';
import '../widgets/empty_and_loading.dart';

class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({super.key, this.searchQuery});

  final String? searchQuery;

  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen> {
  late Future<List<ProductDeal>> _futureDeals;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // Initialize with searchQuery from widget or provider
    final providerQuery = ref.read(dealSearchQueryProvider);
    final initialQuery = widget.searchQuery ?? providerQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
    _loadDeals();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Watch for changes from provider (when navigating to Deal Tab with search)
    final providerQuery = ref.watch(dealSearchQueryProvider);
    if (providerQuery != null && providerQuery != _searchController.text) {
      _searchController.text = providerQuery;
      _loadDeals();
      // Clear the provider after using it
      Future.microtask(() => ref.read(dealSearchQueryProvider.notifier).state = null);
    }
  }

  void _loadDeals() {
    final repo = ref.read(productRepositoryProvider);
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      _futureDeals = repo.searchForDeals(query);
    } else {
      // Empty query - show empty state
      _futureDeals = Future.value([]);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeTokens.backgroundDark,
      appBar: AppBar(
        title: const Text('Price Comparison'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search products to compare prices...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                          _loadDeals();
                        },
                      )
                    : null,
                filled: true,
                fillColor: ThemeTokens.surfaceDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _loadDeals(),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<ProductDeal>>(
        future: _futureDeals,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingShimmer();
          }

          final deals = snapshot.data!;
          if (deals.isEmpty) {
            return EmptyStateCard(
              title: _searchController.text.isEmpty
                  ? 'Start Your Search'
                  : 'No deals found',
              message: _searchController.text.isEmpty
                  ? 'Search for a product to compare prices across platforms'
                  : 'Try a different search term or check back later',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: deals.length,
            separatorBuilder: (_, __) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final deal = deals[index];
              return _ProductComparisonCard(deal: deal);
            },
          );
        },
      ),
    );
  }
}

/// Widget that displays a product with price comparison across platforms
class _ProductComparisonCard extends StatelessWidget {
  const _ProductComparisonCard({required this.deal});

  final ProductDeal deal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeTokens.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ThemeTokens.surfaceMuted,
                  ),
                  child: const Icon(Icons.devices, color: Colors.white54, size: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.modelName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            deal.brand,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.star_rounded,
                              size: 14, color: Colors.amber.shade400),
                          const SizedBox(width: 4),
                          Text(
                            deal.rating.toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ThemeTokens.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${deal.deals.length} offers',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ThemeTokens.primary),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          // Platform comparison cards
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: deal.deals.map((offer) {
                return _PlatformOfferCard(offer: offer);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for individual platform offer
class _PlatformOfferCard extends StatelessWidget {
  const _PlatformOfferCard({required this.offer});

  final DealOffer offer;

  IconData _getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'amazon':
        return Icons.shopping_bag;
      case 'flipkart':
        return Icons.local_mall;
      case 'myntra':
        return Icons.checkroom;
      case 'croma':
        return Icons.electrical_services;
      case 'reliance digital':
        return Icons.store;
      case 'shopparva':
        return Icons.storefront;
      default:
        return Icons.store;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: offer.isBestPrice
            ? ThemeTokens.accent.withOpacity(0.1)
            : ThemeTokens.surfaceMuted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: offer.isBestPrice
            ? Border.all(color: ThemeTokens.accent, width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Platform icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getPlatformIcon(offer.platform),
              color: Colors.white70,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      offer.platform,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (offer.isBestPrice) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: ThemeTokens.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'BEST PRICE',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  offer.seller,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (offer.discount != null && offer.discount!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: ThemeTokens.accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        offer.discount!,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: ThemeTokens.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  if (offer.discount != null && offer.discount!.isNotEmpty)
                    const SizedBox(width: 8),
                  Text(
                    '${offer.currency}${offer.price.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: offer.isBestPrice
                              ? ThemeTokens.accent
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (offer.delivery != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    offer.delivery!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white54, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.open_in_new,
            size: 16,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }
}
