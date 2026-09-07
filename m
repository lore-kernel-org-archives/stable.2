Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6C4446F7
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781663; cv=none; b=tf85D7tVsN0zC0y59dNJhbNNneY/l7v3iRw4rMshYY+MFWuUeL9hcO6wJ1XYpPFg6vKsMxxfeLJymPy5KwnKTaPprJw9ZB/Z0Oab5mzIvKrj0UHZAFxYI28xmHE9kkpB/b0zCi0g6Dg63cgxajjpF69zjFSRJDCyI8BuvRVBOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781663; c=relaxed/simple;
	bh=UiK34iKAFwTHa87WSWpKuBR/xWZDmraQT3zx6ikG+gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxVBb5Mwoir9RXOnsBRDo5L7xbFpdYf8Eq5tj/+fMbozpy6BelY57OZc3KllJb7lEfpBTujE1tVMIv/vZFGXEalvIzewnxCArxaCdc97ZVWsQrIcjX/wyqRdypVMC01Q/fO6X0BVE9Ly2twFGnafam+/H3ub/pX0cc6iEJqfvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYhwj4TP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYhwj4TP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DEC1F00A3E;
	Mon,  7 Sep 2026 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781659;
	bh=Ku+IPpXfFRNMXPdgiYnxJlEdjWNQd2p/z1jSKfMoBws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LYhwj4TPHlI4Vj1bN4oRK9QYWaoWQzXzTqy4vevWpGcReUTXcY4VXRcOdm0hleYFA
	 EsZVWcOuHIIyx4ZXzeomZv8aGsWgRGcAzlEkhSlbgXyzrIm8ZEKPkQFy6jNy6CQ+1Y
	 cJn0v0gw41Oif7J5aObq93LZWAx9pwwiXLwayp6yboJPl2+Ha+snhq3JWy0BQHkmsT
	 BBV7xl2o7PNpwM9ch+5njCZaP3+wkoVc5sd6ZT7mGNfG+oArTcbCbEmr2kKJGn695w
	 ZenpRIsk7KFIYxx6rm2LSb+Nj+bRv/RSPJHzfPs4IpIxobLH17vyTpuoWayoHYHn8f
	 LUCTY1vnGG7SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] btrfs: rename functions to allocate and free extent maps
Date: Mon,  7 Sep 2026 07:47:34 -0400
Message-ID: <20260907114735.2871157-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907114735.2871157-1-sashal@kernel.org>
References: <2026090310-catchy-recollect-7ab5@gregkh>
 <20260907114735.2871157-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ae98ae2a50d72b01d0a61cb21e1ac75bfcebc5f3 ]

These functions are exported and don't have a 'btrfs_' prefix in their
names, which goes against coding style conventions. Rename them to have
such prefix, making it clear they are from btrfs and avoiding potential
collisions in the future with functions defined elsewhere outside btrfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ sashal: Reduced backport -- upstream ae98ae2a50d72 touches 13 file(s), this
  backport carries 16. Not backported here:
  fs/btrfs/defrag.c
  fs/btrfs/direct-io.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c            | 20 +++----
 fs/btrfs/compression.c            | 10 ++--
 fs/btrfs/dev-replace.c            |  4 +-
 fs/btrfs/extent_io.c              | 16 +++---
 fs/btrfs/extent_map.c             | 36 ++++++-------
 fs/btrfs/extent_map.h             |  4 +-
 fs/btrfs/file.c                   | 37 ++++++-------
 fs/btrfs/inode.c                  | 88 +++++++++++++++----------------
 fs/btrfs/ioctl.c                  | 14 ++---
 fs/btrfs/relocation.c             |  4 +-
 fs/btrfs/scrub.c                  |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 52 +++++++++---------
 fs/btrfs/tests/inode-tests.c      | 42 +++++++--------
 fs/btrfs/tree-log.c               |  4 +-
 fs/btrfs/volumes.c                | 52 +++++++++---------
 fs/btrfs/zoned.c                  |  6 +--
 16 files changed, 196 insertions(+), 195 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1f9fbec887c03..4a92761695cd1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1152,7 +1152,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
 		/* once for the tree */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 out:
@@ -1199,7 +1199,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	 */
 	map = em->map_lookup;
 	num_items = 3 + map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(root, num_items);
 }
@@ -1854,7 +1854,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	}
 
 out_free_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1982,7 +1982,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	*naddrs = nr;
 	*stripe_len = io_stripe_size;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2111,7 +2111,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	"chunk start=%llu len=%llu doesn't have corresponding block group",
 				     em->start, em->len);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		if (bg->start != em->start || bg->length != em->len ||
@@ -2124,12 +2124,12 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 				bg->start, bg->length,
 				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_put_block_group(bg);
 			break;
 		}
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		btrfs_put_block_group(bg);
 	}
 	return ret;
@@ -2529,7 +2529,7 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -4306,8 +4306,8 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		write_unlock(&em_tree->lock);
 
 		/* once for us and once for the tree */
-		free_extent_map(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		/*
 		 * We may have left one free space entry and other possible
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index cb56ac8b925e6..8b06f1b7ebf4b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -354,7 +354,7 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
 
 	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		bio_put(bio);
 		return ERR_PTR(ret);
@@ -607,14 +607,14 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (!em || cur < em->start ||
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (page->index == end_index) {
 			size_t zero_offset = offset_in_page(isize);
@@ -713,7 +713,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	cb->compress_type = em->compress_type;
 	cb->orig_bio = bio;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	cb->nr_pages = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
@@ -827,7 +827,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	kfree(cb->compressed_pages);
 	kfree(cb);
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_bio_end_io(btrfs_bio(bio), ret);
 	return;
 }
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9c856a73d5333..c8b39be68f5ab 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -596,7 +596,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 			cur_extent = i;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (num_extents > 1 && cur_extent < num_extents - 1) {
 		/*
@@ -857,7 +857,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	} while (start);
 	write_unlock(&em_tree->lock);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 28dbac0bfab2f..611c931ddba92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1458,7 +1458,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		return PTR_ERR(em);
 	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
 				    logical, &geom);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		return ret;
 	}
@@ -1721,7 +1721,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 			return em;
 		}
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*em_cached = NULL;
 	}
 
@@ -1861,7 +1861,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/* we've found a hole, just zero and go on */
@@ -2168,7 +2168,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		if (btrfs_use_zone_append(inode, em->block_start))
 			op = REQ_OP_ZONE_APPEND;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/*
@@ -3340,7 +3340,7 @@ void extent_readahead(struct readahead_control *rac)
 	}
 
 	if (em_cached)
-		free_extent_map(em_cached);
+		btrfs_free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
 }
 
@@ -3446,7 +3446,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
 			    em->start != start) {
 				write_unlock(&map->lock);
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			if (test_range_bit(tree, em->start,
@@ -3486,13 +3486,13 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			 */
 			remove_extent_mapping(map, em);
 			/* once for the rb tree */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 next:
 			start = extent_map_end(em);
 			write_unlock(&map->lock);
 
 			/* once for us */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 
 			cond_resched(); /* Allow large-extent preemption. */
 		}
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 3518e638374ea..7f1139b3d9393 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -46,9 +46,9 @@ void extent_map_tree_init(struct extent_map_tree *tree)
  *
  * Allocate a new extent_map structure.  The new structure is
  * returned with a reference count of one and needs to be
- * freed using free_extent_map()
+ * freed using btrfs_free_extent_map()
  */
-struct extent_map *alloc_extent_map(void)
+struct extent_map *btrfs_alloc_extent_map(void)
 {
 	struct extent_map *em;
 	em = kmem_cache_zalloc(extent_map_cache, GFP_NOFS);
@@ -68,7 +68,7 @@ struct extent_map *alloc_extent_map(void)
  * Drops the reference out on @em by one and free the structure
  * if the reference count hits zero.
  */
-void free_extent_map(struct extent_map *em)
+void btrfs_free_extent_map(struct extent_map *em)
 {
 	if (!em)
 		return;
@@ -269,7 +269,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
-			free_extent_map(merge);
+			btrfs_free_extent_map(merge);
 		}
 	}
 
@@ -284,7 +284,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
 		em->generation = max(em->generation, merge->generation);
 		set_bit(EXTENT_FLAG_MERGED, &em->flags);
-		free_extent_map(merge);
+		btrfs_free_extent_map(merge);
 	}
 }
 
@@ -331,7 +331,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		em->mod_len = em->len;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
 	return ret;
@@ -662,7 +662,7 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 		 */
 		if (start >= existing->start &&
 		    start < extent_map_end(existing)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
 		} else {
@@ -676,14 +676,14 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 			ret = merge_extent_mapping(em_tree, existing,
 						   em, start);
 			if (ret) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				*em_in = NULL;
 				WARN_ONCE(ret,
 "unexpected error %d: merge existing(start %llu len %llu) with em(start %llu len %llu)\n",
 					  ret, existing->start, existing->len,
 					  orig_start, orig_len);
 			}
-			free_extent_map(existing);
+			btrfs_free_extent_map(existing);
 		}
 	}
 
@@ -708,7 +708,7 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		cond_resched_rwlock_write(&tree->lock);
 	}
 	write_unlock(&tree->lock);
@@ -757,8 +757,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 	 * range ends after our range (and they might be the same extent map),
 	 * because we need to split those two extent maps at the boundaries.
 	 */
-	split = alloc_extent_map();
-	split2 = alloc_extent_map();
+	split = btrfs_alloc_extent_map();
+	split2 = btrfs_alloc_extent_map();
 
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
@@ -840,7 +840,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->flags = flags;
 			split->compress_type = em->compress_type;
 			replace_extent_mapping(em_tree, em, split, modified);
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = split2;
 			split2 = NULL;
 		}
@@ -893,7 +893,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				if (WARN_ON(ret != 0) && modified)
 					btrfs_set_inode_full_sync(inode);
 			}
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = NULL;
 		}
 remove_em:
@@ -929,18 +929,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		 * Once for the tree reference (we replaced or removed the
 		 * extent map from the tree).
 		 */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		/* Once for us (for our lookup reference). */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		em = next_em;
 	}
 
 	write_unlock(&em_tree->lock);
 
-	free_extent_map(split);
-	free_extent_map(split2);
+	btrfs_free_extent_map(split);
+	btrfs_free_extent_map(split2);
 }
 
 /*
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 68d3f2c9ea1d8..f8727ca8ca244 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -97,8 +97,8 @@ void replace_extent_mapping(struct extent_map_tree *tree,
 			    struct extent_map *new,
 			    int modified);
 
-struct extent_map *alloc_extent_map(void);
-void free_extent_map(struct extent_map *em);
+struct extent_map *btrfs_alloc_extent_map(void);
+void btrfs_free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 407bce7a37ec8..04cf0525416b2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -5,6 +5,7 @@
 
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -2150,7 +2151,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 
-	hole_em = alloc_extent_map();
+	hole_em = btrfs_alloc_extent_map();
 	if (!hole_em) {
 		btrfs_drop_extent_map_range(inode, offset, end - 1, false);
 		btrfs_set_inode_full_sync(inode);
@@ -2167,7 +2168,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
-		free_extent_map(hole_em);
+		btrfs_free_extent_map(hole_em);
 		if (ret)
 			btrfs_set_inode_full_sync(inode);
 	}
@@ -2200,7 +2201,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 		       0 : *start + *len - em->start - em->len;
 		*start = em->start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2919,7 +2920,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2964,7 +2965,7 @@ static int btrfs_zero_range(struct inode *inode,
 			 * do nothing except updating the inode's i_size if
 			 * needed.
 			 */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
@@ -2979,7 +2980,7 @@ static int btrfs_zero_range(struct inode *inode,
 		offset = alloc_start;
 		alloc_hint = em->block_start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
@@ -2991,13 +2992,13 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
 		}
 		if (len < sectorsize && em->block_start != EXTENT_MAP_HOLE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
 			if (!ret)
@@ -3006,7 +3007,7 @@ static int btrfs_zero_range(struct inode *inode,
 								   mode);
 			return ret;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
 		alloc_end = alloc_start + sectorsize;
 		goto reserve_space;
@@ -3217,19 +3218,19 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 			ret = add_falloc_range(&reserve_list, cur_offset, range_len);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
 					&data_reserved, cur_offset, range_len);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			qgroup_reserved += range_len;
 			data_space_needed += range_len;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		cur_offset = last_byte;
 	}
 
@@ -3354,7 +3355,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 		struct extent_map *next_em;
 
 		next_em = btrfs_next_extent_map(em_tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		/*
 		 * There's no next extent map or the next one starts beyond our
@@ -3362,7 +3363,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 		 */
 		if (!next_em || next_em->start > end) {
 			read_unlock(&em_tree->lock);
-			free_extent_map(next_em);
+			btrfs_free_extent_map(next_em);
 			return (delalloc_len > 0);
 		}
 
@@ -3378,7 +3379,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	 */
 	if (em->block_start == EXTENT_MAP_HOLE ||
 	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return (delalloc_len > 0);
 	}
 
@@ -3389,7 +3390,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	if (delalloc_len == 0) {
 		*delalloc_start_ret = em->start;
 		*delalloc_end_ret = min(end, em_end - 1);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return true;
 	}
 
@@ -3406,7 +3407,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 		if (em_end < *delalloc_start_ret)
 			*delalloc_end_ret = min(end, em_end - 1);
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return true;
 	}
 
@@ -3418,7 +3419,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	if (*delalloc_end_ret + 1 == em->start)
 		*delalloc_end_ret = min(end, em_end - 1);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return true;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2a1d96a806a9..7d42e29ad9e87 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1023,7 +1023,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ret = btrfs_add_ordered_extent(inode, start,		/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
@@ -1127,15 +1127,15 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 		 * block is also bogus then just don't worry about it.
 		 */
 		if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			em = search_extent_mapping(em_tree, 0, 0);
 			if (em && em->block_start < EXTENT_MAP_LAST_BYTE)
 				alloc_hint = em->block_start;
 			if (em)
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 		} else {
 			alloc_hint = em->block_start;
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		}
 	}
 	read_unlock(&em_tree->lock);
@@ -1304,7 +1304,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
 					       ins.objectid, cur_alloc_size, 0,
@@ -2105,7 +2105,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				ret = PTR_ERR(em);
 				goto error;
 			}
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_add_ordered_extent(inode,
 					cur_offset, nocow_args.num_bytes,
 					nocow_args.num_bytes,
@@ -2553,11 +2553,11 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	if (pre == 0 && post == 0)
 		return 0;
 
-	split_pre = alloc_extent_map();
+	split_pre = btrfs_alloc_extent_map();
 	if (pre)
-		split_mid = alloc_extent_map();
+		split_mid = btrfs_alloc_extent_map();
 	if (post)
-		split_post = alloc_extent_map();
+		split_post = btrfs_alloc_extent_map();
 	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
 		ret = -ENOMEM;
 		goto out;
@@ -2633,17 +2633,17 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	}
 
 	/* Once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Once for the tree */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 out_unlock:
 	write_unlock(&em_tree->lock);
 	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
 out:
-	free_extent_map(split_pre);
-	free_extent_map(split_mid);
-	free_extent_map(split_post);
+	btrfs_free_extent_map(split_pre);
+	btrfs_free_extent_map(split_mid);
+	btrfs_free_extent_map(split_post);
 
 	return ret;
 }
@@ -2836,7 +2836,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 				     GFP_NOFS);
 next:
 		search_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (ret)
 			return ret;
 	}
@@ -5239,7 +5239,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			if (err)
 				break;
 
-			hole_em = alloc_extent_map();
+			hole_em = btrfs_alloc_extent_map();
 			if (!hole_em) {
 				btrfs_drop_extent_map_range(inode, cur_offset,
 						    cur_offset + hole_size - 1,
@@ -5259,7 +5259,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->generation = fs_info->generation;
 
 			err = btrfs_replace_extent_map_range(inode, hole_em, true);
-			free_extent_map(hole_em);
+			btrfs_free_extent_map(hole_em);
 		} else {
 			err = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
@@ -5267,13 +5267,13 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 				break;
 		}
 next:
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		cur_offset = last_byte;
 		if (cur_offset >= block_end)
 			break;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return err;
 }
@@ -7089,13 +7089,13 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	if (em) {
 		if (em->start > start || em->start + em->len <= start)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else if (em->block_start == EXTENT_MAP_INLINE && page)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else
 			goto out;
 	}
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
 		goto out;
@@ -7271,7 +7271,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	trace_btrfs_get_extent(root, inode, em);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	return em;
@@ -7305,7 +7305,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 				       BTRFS_COMPRESS_NONE);
 	if (ret) {
 		if (em) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
 						    start + len - 1, false);
 		}
@@ -7590,7 +7590,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	       type == BTRFS_ORDERED_NOCOW ||
 	       type == BTRFS_ORDERED_REGULAR);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
 
@@ -7612,7 +7612,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 
@@ -7676,7 +7676,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 						      nowait);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = NULL;
 			btrfs_dec_nocow_writers(bg);
 			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
@@ -7691,7 +7691,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = em2;
 			em = em2;
 		}
@@ -7704,7 +7704,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*map = NULL;
 
 		if (nowait) {
@@ -7895,7 +7895,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 */
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
 	    em->block_start == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
 		 * fallback to buffered IO. This is not only because we can
@@ -7936,7 +7936,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * after we have submitted bios for all the extents in the range.
 	 */
 	if ((flags & IOMAP_NOWAIT) && len < length) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		ret = -EAGAIN;
 		goto unlock_err;
 	}
@@ -8003,7 +8003,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
 		iomap->flags |= IOMAP_F_ZONE_APPEND;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return 0;
 
@@ -8363,12 +8363,12 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	} while (submit_len > 0);
 	return;
 
 out_err_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_err:
 	dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
@@ -10282,7 +10282,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			break;
 		}
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			btrfs_drop_extent_map_range(BTRFS_I(inode), cur_offset,
 					    cur_offset + ins.offset - 1, false);
@@ -10301,7 +10301,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
 		cur_offset += ins.offset;
@@ -10681,7 +10681,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		} else {
 			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
 						    disk_bytenr + cur, &geom);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		}
 		if (ret) {
 			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
@@ -10850,7 +10850,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * For inline extents we get everything we need out of the
 		 * extent item.
 		 */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						&cached_state, extent_start,
@@ -10903,7 +10903,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		encoded->unencoded_len = count;
 		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	if (disk_bytenr == EXTENT_MAP_HOLE) {
@@ -10925,7 +10925,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret >= 0)
 		iocb->ki_pos += encoded->len;
 out_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_unlock_extent:
 	if (!unlocked)
 		unlock_extent(io_tree, start, lockend, &cached_state);
@@ -11125,7 +11125,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ret = btrfs_add_ordered_extent(inode, start, num_bytes, ram_bytes,
 				       ins.objectid, ins.offset,
@@ -11454,7 +11454,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 		logical_block_start = em->block_start + (start - em->start);
 		len = min(len, em->len - (start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
@@ -11498,7 +11498,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		physical_block_start = (em->map_lookup->stripes[0].physical +
 					(logical_block_start - em->start));
 		len = min(len, em->len - (logical_block_start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
@@ -11553,7 +11553,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 out:
 	if (!IS_ERR_OR_NULL(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 	unlock_extent(io_tree, 0, isize - 1, &cached_state);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b84b1cce17723..869d33834e2a0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1097,7 +1097,7 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 	u64 ino = btrfs_ino(inode);
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		ret = -ENOMEM;
 		goto err;
@@ -1205,12 +1205,12 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 
 not_found:
 	btrfs_release_path(&path);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return NULL;
 
 err:
 	btrfs_release_path(&path);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ERR_PTR(ret);
 }
 
@@ -1240,7 +1240,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 */
 	if (em && test_bit(EXTENT_FLAG_MERGED, &em->flags) &&
 	    newer_than && em->generation >= newer_than) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 	}
 
@@ -1308,7 +1308,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 
 	ret = true;
 out:
-	free_extent_map(next);
+	btrfs_free_extent_map(next);
 	return ret;
 }
 
@@ -1572,7 +1572,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		/* Allocate new defrag_target_range */
 		new = kmalloc(sizeof(*new), GFP_NOFS);
 		if (!new) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1582,7 +1582,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 
 next:
 		cur = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	if (ret < 0) {
 		struct defrag_target_range *entry;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d37904a806d6a..4e6bfedee5ea6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2957,7 +2957,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	struct extent_map *em;
 	int ret = 0;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
 
@@ -2970,7 +2970,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
 	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 8cae31edc68d7..1dc150194fc75 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3803,7 +3803,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		}
 	}
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c5b3a631bf4fb..c634b02aa6699 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -31,7 +31,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 			refcount_set(&em->refs, 1);
 		}
 #endif
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	write_unlock(&em_tree->lock);
 }
@@ -60,7 +60,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_8K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -78,10 +78,10 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [0, 16K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [16K, 20K) following [0, 16K)  */
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -99,9 +99,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [16K, 20K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -129,7 +129,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 			 em->block_start, em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -148,7 +148,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	struct extent_map *em;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -166,10 +166,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [0, 1K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [4K, 8K) following [0, 1K)  */
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -187,9 +187,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -217,7 +217,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 			 em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -231,7 +231,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_4K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -249,9 +249,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -284,7 +284,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 			 em->block_start, em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -330,7 +330,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_4K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -348,9 +348,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [0, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -369,9 +369,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [8K, 32K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		ret = -ENOMEM;
@@ -397,7 +397,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 			 em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -464,7 +464,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	int i, out_ndaddrs, out_stripe_len;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -542,10 +542,10 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	remove_extent_mapping(&fs_info->mapping_tree, em);
 	write_unlock(&fs_info->mapping_tree.lock);
 	/* For us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_free:
 	/* For the tree */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	kfree(logical);
 	return ret;
 }
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 625f7d398368d..d180945bc1556 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -266,7 +266,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->block_start);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 
 	/*
@@ -296,7 +296,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -324,7 +324,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * this?
 	 */
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -346,7 +346,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Regular extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -374,7 +374,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are split extents */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -404,7 +404,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -426,7 +426,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -459,7 +459,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -488,7 +488,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -519,7 +519,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -552,7 +552,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -586,7 +586,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Now for the compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -620,7 +620,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Split compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -656,7 +656,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -683,7 +683,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -717,7 +717,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsize);
@@ -745,7 +745,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
 	if (IS_ERR(em)) {
@@ -778,7 +778,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -807,7 +807,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
@@ -880,7 +880,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 			 em->flags);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
@@ -905,7 +905,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ceb2a9556fe7b..9d180ad89c16f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4989,7 +4989,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			continue;
 		}
 
@@ -4998,7 +4998,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9f5d5f5c53131..83a43bc2f70eb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3123,7 +3123,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, em->start, em->start + em->len);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3313,7 +3313,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		trans->removing_chunk = false;
 	}
 	/* once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5500,7 +5500,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		kfree(map);
 		return ERR_PTR(-ENOMEM);
@@ -5518,7 +5518,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	ret = add_extent_mapping(em_tree, em, 0);
 	if (ret) {
 		write_unlock(&em_tree->lock);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	write_unlock(&em_tree->lock);
@@ -5540,7 +5540,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
@@ -5552,9 +5552,9 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	write_unlock(&em_tree->lock);
 
 	/* One for our allocation */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* One for the tree reference */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return block_group;
 }
@@ -5726,7 +5726,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 
 out:
 	kfree(chunk);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5811,7 +5811,7 @@ bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (miss_ndevs > btrfs_chunk_max_errors(map))
 		ret = false;
 end:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5828,9 +5828,9 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
 		if (!em)
 			break;
 		/* once for us */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/* once for the tree */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 }
 
@@ -5868,7 +5868,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		 * stripe under reconstruction.
 		 */
 		ret = map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
@@ -5895,7 +5895,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			len = map->stripe_len * nr_data_stripes(map);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return len;
 }
@@ -5915,7 +5915,7 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			ret = 1;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return ret;
 }
@@ -6178,10 +6178,10 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 		}
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return stripes;
 out_free_map:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ERR_PTR(ret);
 }
 
@@ -6745,7 +6745,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -7297,18 +7297,18 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
 	/* already mapped? */
 	if (em && em->start <= logical && em->start + em->len > logical) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return 0;
 	} else if (em) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return -ENOMEM;
 	}
 
@@ -7351,7 +7351,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 								    devid, uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
 				ret = PTR_ERR(map->stripes[i].dev);
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				return ret;
 			}
 		}
@@ -7368,7 +7368,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  em->start, em->len, ret);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -7717,12 +7717,12 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 				btrfs_warn(fs_info,
 	"chunk %llu missing %d devices, max tolerance is %d for writable mount",
 				   em->start, missing, max_tolerated);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = false;
 			goto out;
 		}
 		next_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		read_lock(&map_tree->lock);
 		em = lookup_extent_mapping(map_tree, next_start,
@@ -8316,7 +8316,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4e2ed51297ea1..6d68f1f0f1091 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1573,7 +1573,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 	bitmap_free(active);
 	kfree(zone_info);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -1718,7 +1718,7 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
 	em->block_start = *logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	write_unlock(&em_tree->lock);
 
 	list_for_each_entry(sum, &ordered->list, list) {
@@ -1869,7 +1869,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 	/* We only support single profile for now */
 	device = map->stripes[0].dev;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return device;
 }
-- 
2.53.0

