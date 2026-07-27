Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02283D522F
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181858; cv=none; b=TXJDbtpUOPi9nxGaY85PRXyoFmx/kz9ZgVUP1e/rZ2S0ksfYG7czxQm/hjBUVRH1757UfwOcYNlYv6EEf093AQR6GVMP08mwrVubG7mANrZxoGMP8Y2CTmPJX4kk/hZS335WZOrrkQ+k1QelwWvXppBA7ZCLrOT0E1Ozc/D8bE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181858; c=relaxed/simple;
	bh=dAkBuV93OGK1T1inUnp71fqzzl06sf3TuQ7PNBVS9tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk43OwfK5JFs4nuqQIyyni5o74ZYeLcS8XL6Y8Eyby2+nNUhE8L37fO38NqzYbd9NEn70DdjLBLXMFcK5Ukigc+J0R8oXVBeC4wkJdco4ZkCt3FlTqT9ctYKt/HtfLp2JLW3pSgesi2BmBjzjtHxVoksf5lNpmm2C8M+PTpsgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwSar3ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwSar3ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2291F000E9;
	Mon, 27 Jul 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181856;
	bh=CJ1MzqBkSy3nPoHtOxpQUiNmeUhwoj/kjCuNshDlQWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwSar3ouOl0hdZ9BuA5j+W9PA70b4BsTYQwEwWbHheCmFDAuXCHZE+Zdivizo4Xn/
	 WtKZMaPHSB4s6xGdVRCuaWtIn79wUUwC4A0XS2gLZuO71itYd7VW0mnKs+FSE2IegF
	 jcbAgjq6IokpxuvgQhxI3q5g1t2hbWiuJUVfDjjoswN3TOXbr5EgZuQrLbdicXbUvU
	 lVtNFkltEO+io+sku370lQXxT3Nqt+VSOKMeKxOplAiW4SCBzbJfbtwu6Rcbkszoyp
	 PT5C5hIpGNGZChe/Cccm/cRevswOLRjUkC4rCCvCNhrc4KHyRGSbve4Dm/J5ChBX+X
	 3KrNP7pbPUoZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] dm: remove unnecessary braces from single statement blocks
Date: Mon, 27 Jul 2026 15:50:50 -0400
Message-ID: <20260727195052.1774404-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727195052.1774404-1-sashal@kernel.org>
References: <2026072050-armless-fidelity-4a3f@gregkh>
 <20260727195052.1774404-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 2d0f25cbc0d948e01573cc8ff5967e81bd98a4a1 ]

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: edf025f08385 ("dm-integrity: don't increment hash_offset twice")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c                     | 48 ++++++++-----------
 drivers/md/dm-stats.c                         |  9 ++--
 drivers/md/dm-stripe.c                        | 10 ++--
 drivers/md/dm-thin-metadata.c                 |  4 +-
 drivers/md/dm-writecache.c                    |  7 ++-
 drivers/md/persistent-data/dm-btree-spine.c   |  6 +--
 .../md/persistent-data/dm-space-map-disk.c    |  9 ++--
 7 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 4191ef1abc0230..be4d489269c179 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -631,11 +631,10 @@ static bool block_bitmap_op(struct dm_integrity_c *ic, struct page_list *bitmap,
 	end_bit %= PAGE_SIZE * 8;
 
 repeat:
-	if (page < end_page) {
+	if (page < end_page)
 		this_end_bit = PAGE_SIZE * 8 - 1;
-	} else {
+	else
 		this_end_bit = end_bit;
-	}
 
 	data = lowmem_page_address(bitmap[page].page);
 
@@ -1252,13 +1251,12 @@ static bool add_new_range(struct dm_integrity_c *ic, struct dm_integrity_range *
 		struct dm_integrity_range *range = container_of(*n, struct dm_integrity_range, node);
 
 		parent = *n;
-		if (new_range->logical_sector + new_range->n_sectors <= range->logical_sector) {
+		if (new_range->logical_sector + new_range->n_sectors <= range->logical_sector)
 			n = &range->node.rb_left;
-		} else if (new_range->logical_sector >= range->logical_sector + range->n_sectors) {
+		else if (new_range->logical_sector >= range->logical_sector + range->n_sectors)
 			n = &range->node.rb_right;
-		} else {
+		else
 			return false;
-		}
 	}
 
 	rb_link_node(&new_range->node, parent, n);
@@ -1365,15 +1363,14 @@ static unsigned int find_journal_node(struct dm_integrity_c *ic, sector_t sector
 	while (n) {
 		struct journal_node *j = container_of(n, struct journal_node, node);
 
-		if (sector == j->sector) {
+		if (sector == j->sector)
 			found = j - ic->journal_tree;
-		}
+
 		if (sector < j->sector) {
 			*next_sector = j->sector;
 			n = j->node.rb_left;
-		} else {
+		} else
 			n = j->node.rb_right;
-		}
 	}
 
 	return found;
@@ -1502,9 +1499,8 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size))) {
+		if (unlikely(!is_power_of_2(ic->tag_size)))
 			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-		}
 
 		total_size -= to_copy;
 	} while (unlikely(total_size));
@@ -2178,14 +2174,12 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 		smp_mb();
 		if (unlikely(waitqueue_active(&ic->copy_to_journal_wait)))
 			wake_up(&ic->copy_to_journal_wait);
-		if (READ_ONCE(ic->free_sectors) <= ic->free_sectors_threshold) {
+		if (READ_ONCE(ic->free_sectors) <= ic->free_sectors_threshold)
 			queue_work(ic->commit_wq, &ic->commit_work);
-		} else {
+		else
 			schedule_autocommit(ic);
-		}
-	} else {
+	} else
 		remove_range(ic, &dio->range);
-	}
 
 	if (unlikely(bio->bi_iter.bi_size)) {
 		sector_t area, offset;
@@ -2645,9 +2639,8 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 					mempool_free(io, &ic->journal_io_mempool);
 					goto skip_io;
 				}
-				for (l = j; l < k; l++) {
+				for (l = j; l < k; l++)
 					remove_journal_node(ic, &section_node[l]);
-				}
 			}
 			spin_unlock_irq(&ic->endio_wait.lock);
 
@@ -2674,9 +2667,8 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 				journal_entry_set_unused(je2);
 				r = dm_integrity_rw_tag(ic, journal_entry_tag(ic, je2), &metadata_block, &metadata_offset,
 							ic->tag_size, TAG_WRITE);
-				if (unlikely(r)) {
+				if (unlikely(r))
 					dm_integrity_io_error(ic, "reading tags", r);
-				}
 			}
 
 			atomic_inc(&comp.in_flight);
@@ -2787,9 +2779,9 @@ static void integrity_recalc(struct work_struct *w)
 	n_sectors = range.n_sectors;
 
 	if (ic->mode == 'B') {
-		if (block_bitmap_op(ic, ic->recalc_bitmap, logical_sector, n_sectors, BITMAP_OP_TEST_ALL_CLEAR)) {
+		if (block_bitmap_op(ic, ic->recalc_bitmap, logical_sector, n_sectors, BITMAP_OP_TEST_ALL_CLEAR))
 			goto advance_and_next;
-		}
+
 		while (block_bitmap_op(ic, ic->recalc_bitmap, logical_sector,
 				       ic->sectors_per_block, BITMAP_OP_TEST_ALL_CLEAR)) {
 			logical_sector += ic->sectors_per_block;
@@ -2808,9 +2800,9 @@ static void integrity_recalc(struct work_struct *w)
 
 	if (unlikely(++super_counter == RECALC_WRITE_SUPER)) {
 		recalc_write_super(ic);
-		if (ic->mode == 'B') {
+		if (ic->mode == 'B')
 			queue_delayed_work(ic->commit_wq, &ic->bitmap_flush_work, ic->bitmap_flush_interval);
-		}
+
 		super_counter = 0;
 	}
 
@@ -4512,9 +4504,9 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 
 	log2_blocks_per_bitmap_bit = log2_sectors_per_bitmap_bit - ic->sb->log2_sectors_per_block;
 	ic->log2_blocks_per_bitmap_bit = log2_blocks_per_bitmap_bit;
-	if (should_write_sb) {
+	if (should_write_sb)
 		ic->sb->log2_blocks_per_bitmap_bit = log2_blocks_per_bitmap_bit;
-	}
+
 	n_bitmap_bits = ((ic->provided_data_sectors >> ic->sb->log2_sectors_per_block)
 				+ (((sector_t)1 << log2_blocks_per_bitmap_bit) - 1)) >> log2_blocks_per_bitmap_bit;
 	ic->n_bitmap_blocks = DIV_ROUND_UP(n_bitmap_bits, BITMAP_BLOCK_SIZE * 8);
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index c1d1a4d5fa545b..34b929ebf44c52 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -606,12 +606,10 @@ static void dm_stat_for_entry(struct dm_stat *s, size_t entry,
 			while (lo + 1 < hi) {
 				unsigned int mid = (lo + hi) / 2;
 
-				if (s->histogram_boundaries[mid - 1] > duration) {
+				if (s->histogram_boundaries[mid - 1] > duration)
 					hi = mid;
-				} else {
+				else
 					lo = mid;
-				}
-
 			}
 			p->histogram[lo]++;
 		}
@@ -903,9 +901,8 @@ static int dm_stats_print(struct dm_stats *stats, int id,
 		if (s->n_histogram_entries) {
 			unsigned int i;
 
-			for (i = 0; i < s->n_histogram_entries + 1; i++) {
+			for (i = 0; i < s->n_histogram_entries + 1; i++)
 				DMEMIT("%s%llu", !i ? " " : ":", shared->tmp.histogram[i]);
-			}
 		}
 		DMEMIT("\n");
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 547aefe85c076a..01e20c476f69bb 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -364,14 +364,12 @@ static void stripe_status(struct dm_target *ti, status_type_t type,
 	switch (type) {
 	case STATUSTYPE_INFO:
 		DMEMIT("%d ", sc->stripes);
-		for (i = 0; i < sc->stripes; i++)  {
+		for (i = 0; i < sc->stripes; i++)
 			DMEMIT("%s ", sc->stripe[i].dev->name);
-		}
+
 		DMEMIT("1 ");
-		for (i = 0; i < sc->stripes; i++) {
-			DMEMIT("%c", atomic_read(&(sc->stripe[i].error_count)) ?
-			       'D' : 'A');
-		}
+		for (i = 0; i < sc->stripes; i++)
+			DMEMIT("%c", atomic_read(&(sc->stripe[i].error_count)) ?  'D' : 'A');
 		break;
 
 	case STATUSTYPE_TABLE:
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 0ce5cb545e7aa2..c143daeee5b3fa 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1522,9 +1522,9 @@ static int __find_block(struct dm_thin_device *td, dm_block_t block,
 	dm_block_t keys[2] = { td->id, block };
 	struct dm_btree_info *info;
 
-	if (can_issue_io) {
+	if (can_issue_io)
 		info = &pmd->info;
-	} else
+	else
 		info = &pmd->nb_info;
 
 	r = dm_btree_lookup(info, pmd->root, keys, &value);
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 9fd3139d2bf971..adda032579b9a9 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1981,9 +1981,8 @@ static void writecache_writeback(struct work_struct *work)
 			goto restart;
 	}
 
-	if (wc->overwrote_committed) {
+	if (wc->overwrote_committed)
 		writecache_wait_for_ios(wc, WRITE);
-	}
 
 	n_walked = 0;
 	INIT_LIST_HEAD(&skipped);
@@ -2012,9 +2011,9 @@ static void writecache_writeback(struct work_struct *work)
 		} else
 			e = container_of(wc->lru.prev, struct wc_entry, lru);
 		BUG_ON(e->write_in_progress);
-		if (unlikely(!writecache_entry_is_committed(wc, e))) {
+		if (unlikely(!writecache_entry_is_committed(wc, e)))
 			writecache_flush(wc);
-		}
+
 		node = rb_prev(&e->rb_node);
 		if (node) {
 			f = container_of(node, struct wc_entry, rb_node);
diff --git a/drivers/md/persistent-data/dm-btree-spine.c b/drivers/md/persistent-data/dm-btree-spine.c
index 45a39d4f1c10fb..883e5199ed63ad 100644
--- a/drivers/md/persistent-data/dm-btree-spine.c
+++ b/drivers/md/persistent-data/dm-btree-spine.c
@@ -132,9 +132,8 @@ void exit_ro_spine(struct ro_spine *s)
 {
 	int i;
 
-	for (i = 0; i < s->count; i++) {
+	for (i = 0; i < s->count; i++)
 		unlock_block(s->info, s->nodes[i]);
-	}
 }
 
 int ro_step(struct ro_spine *s, dm_block_t new_child)
@@ -183,9 +182,8 @@ void exit_shadow_spine(struct shadow_spine *s)
 {
 	int i;
 
-	for (i = 0; i < s->count; i++) {
+	for (i = 0; i < s->count; i++)
 		unlock_block(s->info, s->nodes[i]);
-	}
 }
 
 int shadow_step(struct shadow_spine *s, dm_block_t b,
diff --git a/drivers/md/persistent-data/dm-space-map-disk.c b/drivers/md/persistent-data/dm-space-map-disk.c
index 9868ee9cc812b0..bc7fd2eb12dba2 100644
--- a/drivers/md/persistent-data/dm-space-map-disk.c
+++ b/drivers/md/persistent-data/dm-space-map-disk.c
@@ -94,9 +94,8 @@ static int sm_disk_set_count(struct dm_space_map *sm, dm_block_t b,
 	struct sm_disk *smd = container_of(sm, struct sm_disk, sm);
 
 	r = sm_ll_insert(&smd->ll, b, count, &nr_allocations);
-	if (!r) {
+	if (!r)
 		smd->nr_allocated_this_transaction += nr_allocations;
-	}
 
 	return r;
 }
@@ -137,22 +136,20 @@ static int sm_disk_new_block(struct dm_space_map *sm, dm_block_t *b)
 	 * Any block we allocate has to be free in both the old and current ll.
 	 */
 	r = sm_ll_find_common_free_block(&smd->old_ll, &smd->ll, smd->begin, smd->ll.nr_blocks, b);
-	if (r == -ENOSPC) {
+	if (r == -ENOSPC)
 		/*
 		 * There's no free block between smd->begin and the end of the metadata device.
 		 * We search before smd->begin in case something has been freed.
 		 */
 		r = sm_ll_find_common_free_block(&smd->old_ll, &smd->ll, 0, smd->begin, b);
-	}
 
 	if (r)
 		return r;
 
 	smd->begin = *b + 1;
 	r = sm_ll_inc(&smd->ll, *b, *b + 1, &nr_allocations);
-	if (!r) {
+	if (!r)
 		smd->nr_allocated_this_transaction += nr_allocations;
-	}
 
 	return r;
 }
-- 
2.53.0

