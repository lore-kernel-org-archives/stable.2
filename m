Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A6429CFB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789101; cv=none; b=Q1C9h4+Boe8/Jx6HF/w/RtTJ7v0Xj1OhPS+1K8rWJl/wgt7ywavO6p4zaXa76nxnDlWIUtnyqbyLYT7nNwJqnCFjISo1bdFllImwRcloAVtrDQF8U0DJ6wvlc+CM1DcMm2tFmha4QOK6Bb6T7kBLR1pMN21yNaaWxTs5J0z5Euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789101; c=relaxed/simple;
	bh=HvffkjPy7b/iusT42GOMMwKpudQXAMX1JcHuEccrVsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLc28U7WdywTKWrF7ytkpV5llEgZFa8YdOoVryv6O6vlU0Y8ZF32g+11MIwMZn4kZb4Tag2JWh/jHZ8svBqZeEuCLSq17oJimHTqfNVQWZ7KjczXiq9QBMolpjPleqV/2bwfp9XqJXFJ9XkUBY0ZyoAu01O6xevTMrw1nK0D41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBwa2YDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBwa2YDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59C61F00A3A;
	Mon,  7 Sep 2026 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789097;
	bh=I3xvRCe6gs/IoKFAIY6uKwz9C+Cmx4PFJahjCtcodVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBwa2YDpzwZfbEusmGI5HRLBdllYWwqU4hKEB8XyfKRCcUaOIPKHKnMnMIdC2CNJP
	 0EIxeR4zfFmLjfooJ5TY71cK6vDBixoTCw9CYtQSspfle/yUBx9XS47j51vtrG7Rsb
	 UiX4mt7fiBD7pYIpoye9pJ3dB3T7BrN1vheZalxoo3dVLQJugKmMggZ2qBj3n7tFRF
	 nfRitC04ZIia3SJJQC2AxUHRZbwIJLdmgbc3JFwOuPra/PqXIzjgHvUv5LwWHnY/Pv
	 4bVAejDLzNb7V2u+DXXi1/3MQm7qu07omp6+ADHKGKQxRw6X94Z0xfXlcbDFZ19lEY
	 DWj3/4v7LG1sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] btrfs: rename functions to allocate and free extent maps
Date: Mon,  7 Sep 2026 09:51:34 -0400
Message-ID: <20260907135135.3104926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-unison-envision-12aa@gregkh>
References: <2026090311-unison-envision-12aa@gregkh>
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
 fs/btrfs/compression.c            |  8 +--
 fs/btrfs/dev-replace.c            |  4 +-
 fs/btrfs/extent_io.c              | 26 ++++-----
 fs/btrfs/extent_map.c             | 22 ++++----
 fs/btrfs/extent_map.h             |  4 +-
 fs/btrfs/file.c                   | 48 ++++++++--------
 fs/btrfs/inode.c                  | 92 +++++++++++++++----------------
 fs/btrfs/ioctl.c                  | 10 ++--
 fs/btrfs/relocation.c             |  4 +-
 fs/btrfs/scrub.c                  |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 52 ++++++++---------
 fs/btrfs/tests/inode-tests.c      | 42 +++++++-------
 fs/btrfs/tree-log.c               |  4 +-
 fs/btrfs/volumes.c                | 50 ++++++++---------
 fs/btrfs/zoned.c                  |  8 +--
 16 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4bc7a5e63b86d..0767e183eb955 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1088,7 +1088,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
 		/* once for the tree */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 out:
@@ -1134,7 +1134,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	 */
 	map = em->map_lookup;
 	num_items = 3 + map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
 							   num_items);
@@ -1696,7 +1696,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	}
 
 out_free_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1847,7 +1847,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	*naddrs = nr;
 	*stripe_len = io_stripe_size;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1984,7 +1984,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	"chunk start=%llu len=%llu doesn't have corresponding block group",
 				     em->start, em->len);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		if (bg->start != em->start || bg->length != em->len ||
@@ -1997,12 +1997,12 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
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
@@ -2408,7 +2408,7 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 	}
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -4047,8 +4047,8 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		write_unlock(&em_tree->lock);
 
 		/* once for us and once for the tree */
-		free_extent_map(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		/*
 		 * We may have left one free space entry and other possible
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 701fbd1b56766..93006ee45441a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -622,13 +622,13 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (!em || last_offset < em->start ||
 		    (last_offset + PAGE_SIZE > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			unlock_extent(tree, last_offset, end);
 			unlock_page(page);
 			put_page(page);
 			break;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (page->index == end_index) {
 			size_t zero_offset = offset_in_page(isize);
@@ -717,7 +717,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	em_len = em->len;
 	em_start = em->start;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	cb->len = bio->bi_iter.bi_size;
@@ -839,7 +839,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 fail1:
 	kfree(cb);
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index aa03f2bbcc11c..3ca3cb8612b30 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -622,7 +622,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 			cur_extent = i;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (num_extents > 1 && cur_extent < num_extents - 1) {
 		/*
@@ -880,7 +880,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	} while (start);
 	write_unlock(&em_tree->lock);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fd31058b703..80ee92bf92e84 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2531,7 +2531,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	}
 
 	if (em->start > start || em->start + em->len <= start) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 	}
 	read_unlock(&em_tree->lock);
@@ -2553,7 +2553,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		    logical, start, failrec->len);
 
 	failrec->logical = logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Set the bits in the private failure tree */
 	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
@@ -3276,7 +3276,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 		return PTR_ERR(em);
 	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
 				    logical, &geom);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		return ret;
 	}
@@ -3536,7 +3536,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 			return em;
 		}
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*em_cached = NULL;
 	}
 
@@ -3690,7 +3690,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/* we've found a hole, just zero and go on */
@@ -3997,7 +3997,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		if (btrfs_use_zone_append(inode, em->block_start))
 			opf = REQ_OP_ZONE_APPEND;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/*
@@ -5189,7 +5189,7 @@ void extent_readahead(struct readahead_control *rac)
 	}
 
 	if (em_cached)
-		free_extent_map(em_cached);
+		btrfs_free_extent_map(em_cached);
 
 	if (bio_ctrl.bio) {
 		if (submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags))
@@ -5296,7 +5296,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
 			    em->start != start) {
 				write_unlock(&map->lock);
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			if (test_range_bit(tree, em->start,
@@ -5336,13 +5336,13 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
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
@@ -5379,7 +5379,7 @@ static struct extent_map *get_extent_skip_holes(struct btrfs_inode *inode,
 
 		/* this is a hole, advance to the next extent */
 		offset = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (offset >= last)
 			break;
 	}
@@ -5673,7 +5673,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			flags |= FIEMAP_EXTENT_UNWRITTEN;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		if ((em_start >= last) || em_len == (u64)-1 ||
 		   (last == (u64)-1 && isize <= em_end)) {
@@ -5702,7 +5702,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 out_free:
 	if (!ret)
 		ret = emit_last_fiemap_cache(fieinfo, &cache);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
 			     &cached_state);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 5a36add213053..458618adab470 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -41,13 +41,13 @@ void extent_map_tree_init(struct extent_map_tree *tree)
 }
 
 /**
- * alloc_extent_map - allocate new extent map structure
+ * btrfs_alloc_extent_map - allocate new extent map structure
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
@@ -63,13 +63,13 @@ struct extent_map *alloc_extent_map(void)
 }
 
 /**
- * free_extent_map - drop reference count of an extent_map
+ * btrfs_free_extent_map - drop reference count of an extent_map
  * @em:		extent map being released
  *
  * Drops the reference out on @em by one and free the structure
  * if the reference count hits zero.
  */
-void free_extent_map(struct extent_map *em)
+void btrfs_free_extent_map(struct extent_map *em)
 {
 	if (!em)
 		return;
@@ -264,7 +264,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 
 			rb_erase_cached(&merge->rb_node, &tree->map);
 			RB_CLEAR_NODE(&merge->rb_node);
-			free_extent_map(merge);
+			btrfs_free_extent_map(merge);
 		}
 	}
 
@@ -278,7 +278,7 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->mod_len = (merge->mod_start + merge->mod_len) - em->mod_start;
 		em->generation = max(em->generation, merge->generation);
-		free_extent_map(merge);
+		btrfs_free_extent_map(merge);
 	}
 }
 
@@ -325,7 +325,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		em->mod_len = em->len;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
 	return ret;
@@ -624,7 +624,7 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 		 */
 		if (start >= existing->start &&
 		    start < extent_map_end(existing)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
 		} else {
@@ -638,14 +638,14 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
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
 
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 8e217337dff90..c4169aac5ab55 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -85,8 +85,8 @@ void replace_extent_mapping(struct extent_map_tree *tree,
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
index cfc515f0d25f9..7f64296624704 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -547,9 +547,9 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 
 		modified = false;
 		if (!split)
-			split = alloc_extent_map();
+			split = btrfs_alloc_extent_map();
 		if (!split2)
-			split2 = alloc_extent_map();
+			split2 = btrfs_alloc_extent_map();
 		if (!split || !split2)
 			no_splits = 1;
 
@@ -563,14 +563,14 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 		gen = em->generation;
 		if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
 			if (testend && em->start + em->len >= start + len) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				write_unlock(&em_tree->lock);
 				break;
 			}
 			start = em->start + em->len;
 			if (testend)
 				len = start + len - (em->start + em->len);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			write_unlock(&em_tree->lock);
 			continue;
 		}
@@ -608,7 +608,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			split->flags = flags;
 			split->compress_type = em->compress_type;
 			replace_extent_mapping(em_tree, em, split, modified);
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = split2;
 			split2 = NULL;
 		}
@@ -652,7 +652,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 							 modified);
 				ASSERT(ret == 0); /* Logic error */
 			}
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = NULL;
 		}
 next:
@@ -661,14 +661,14 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 		write_unlock(&em_tree->lock);
 
 		/* once for us */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/* once for the tree*/
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	if (split)
-		free_extent_map(split);
+		btrfs_free_extent_map(split);
 	if (split2)
-		free_extent_map(split2);
+		btrfs_free_extent_map(split2);
 }
 
 /*
@@ -2553,7 +2553,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 
-	hole_em = alloc_extent_map();
+	hole_em = btrfs_alloc_extent_map();
 	if (!hole_em) {
 		btrfs_drop_extent_cache(inode, offset, end - 1, 0);
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
@@ -2575,7 +2575,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 			ret = add_extent_mapping(em_tree, hole_em, 1);
 			write_unlock(&em_tree->lock);
 		} while (ret == -EEXIST);
-		free_extent_map(hole_em);
+		btrfs_free_extent_map(hole_em);
 		if (ret)
 			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					&inode->runtime_flags);
@@ -2609,7 +2609,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 		       0 : *start + *len - em->start - em->len;
 		*start = em->start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -3270,7 +3270,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -3317,7 +3317,7 @@ static int btrfs_zero_range(struct inode *inode,
 			 * do nothing except updating the inode's i_size if
 			 * needed.
 			 */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
@@ -3332,7 +3332,7 @@ static int btrfs_zero_range(struct inode *inode,
 		offset = alloc_start;
 		alloc_hint = em->block_start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
@@ -3344,13 +3344,13 @@ static int btrfs_zero_range(struct inode *inode,
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
@@ -3359,7 +3359,7 @@ static int btrfs_zero_range(struct inode *inode,
 								   mode);
 			return ret;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
 		alloc_end = alloc_start + sectorsize;
 		goto reserve_space;
@@ -3604,7 +3604,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			ret = add_falloc_range(&reserve_list, cur_offset,
 					       last_byte - cur_offset);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
@@ -3612,7 +3612,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 					last_byte - cur_offset);
 			if (ret < 0) {
 				cur_offset = last_byte;
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 		} else {
@@ -3625,7 +3625,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 				data_reserved, cur_offset,
 				last_byte - cur_offset);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		cur_offset = last_byte;
 	}
 
@@ -3716,11 +3716,11 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
 			break;
 
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		cond_resched();
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	unlock_extent_cached(&inode->io_tree, lockstart, lockend,
 			     &cached_state);
 	if (ret) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1f8e8cd49c12a..f2778d2b96663 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -944,7 +944,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		if (IS_ERR(em))
 			/* ret value is not necessary due to void function */
 			goto out_free_reserve;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent_compress(inode,
 						async_extent->start,
@@ -1027,15 +1027,15 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
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
@@ -1201,7 +1201,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
 					       ram_size, cur_alloc_size,
@@ -1896,7 +1896,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				ret = PTR_ERR(em);
 				goto error;
 			}
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
@@ -2334,7 +2334,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 	if (geom.len < bio_len + size)
 		ret = 1;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2372,11 +2372,11 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
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
@@ -2452,17 +2452,17 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
 	}
 
 	/* Once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Once for the tree */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 out_unlock:
 	write_unlock(&em_tree->lock);
 	unlock_extent(&inode->io_tree, start, start + len - 1);
 out:
-	free_extent_map(split_pre);
-	free_extent_map(split_mid);
-	free_extent_map(split_post);
+	btrfs_free_extent_map(split_pre);
+	btrfs_free_extent_map(split_mid);
+	btrfs_free_extent_map(split_post);
 
 	return ret;
 }
@@ -2670,7 +2670,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 				     GFP_NOFS, NULL);
 next:
 		search_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (ret)
 			return ret;
 	}
@@ -5349,7 +5349,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			btrfs_drop_extent_cache(inode, cur_offset,
 						cur_offset + hole_size - 1, 0);
-			hole_em = alloc_extent_map();
+			hole_em = btrfs_alloc_extent_map();
 			if (!hole_em) {
 				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					&inode->runtime_flags);
@@ -5376,7 +5376,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 							cur_offset +
 							hole_size - 1, 0);
 			}
-			free_extent_map(hole_em);
+			btrfs_free_extent_map(hole_em);
 		} else {
 			err = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
@@ -5384,13 +5384,13 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
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
 	unlock_extent_cached(io_tree, hole_start, block_end - 1, &cached_state);
 	return err;
 }
@@ -5550,7 +5550,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(map_tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (need_resched()) {
 			write_unlock(&map_tree->lock);
 			cond_resched();
@@ -7197,13 +7197,13 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
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
@@ -7381,7 +7381,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	trace_btrfs_get_extent(root, inode, em);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	return em;
@@ -7451,7 +7451,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 		u64 hole_len;
 		const u64 hole_end = extent_map_end(hole_em);
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			err = -ENOMEM;
 			goto out;
@@ -7466,7 +7466,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 		 * make sure it is based on the start from the caller
 		 */
 		if (hole_end <= start || hole_em->start > end) {
-		       free_extent_map(hole_em);
+		       btrfs_free_extent_map(hole_em);
 		       hole_em = NULL;
 		} else {
 		       hole_start = max(hole_em->start, start);
@@ -7506,9 +7506,9 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 	}
 out:
 
-	free_extent_map(hole_em);
+	btrfs_free_extent_map(hole_em);
 	if (err) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(err);
 	}
 	return em;
@@ -7539,7 +7539,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 					   block_len, type);
 	if (ret) {
 		if (em) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_drop_extent_cache(inode, start, start + len - 1, 0);
 		}
 		em = ERR_PTR(ret);
@@ -7852,7 +7852,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	       type == BTRFS_ORDERED_REGULAR);
 
 	em_tree = &inode->extent_tree;
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
 
@@ -7885,11 +7885,11 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	} while (ret == -EEXIST);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 
-	/* em got 2 refs now, callers needs to do free_extent_map once. */
+	/* em got 2 refs now, callers needs to do btrfs_free_extent_map once. */
 	return em;
 }
 
@@ -7942,7 +7942,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = NULL;
 			btrfs_dec_nocow_writers(fs_info, block_start);
 			goto out;
@@ -7955,7 +7955,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      ram_bytes, type);
 		btrfs_dec_nocow_writers(fs_info, block_start);
 		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = em = em2;
 		}
 
@@ -7965,7 +7965,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 	} else {
 		/* Our caller expects us to free the input extent map. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*map = NULL;
 
 		/* We have to COW, so need to reserve metadata and data space. */
@@ -8096,7 +8096,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 */
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
 	    em->block_start == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
 		 * fallback to buffered IO. This is not only because we can
@@ -8137,7 +8137,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * after we have submitted bios for all the extents in the range.
 	 */
 	if ((flags & IOMAP_NOWAIT) && len < length) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		ret = -EAGAIN;
 		goto unlock_err;
 	}
@@ -8186,7 +8186,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
 		iomap->flags |= IOMAP_F_ZONE_APPEND;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return 0;
 
@@ -8630,12 +8630,12 @@ static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
 		start_sector += clone_len >> 9;
 		file_offset += clone_len;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	} while (submit_len > 0);
 	return BLK_QC_T_NONE;
 
 out_err_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_err:
 	dip->dio_bio->bi_status = status;
 	btrfs_dio_private_put(dip);
@@ -10559,7 +10559,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
 					cur_offset + ins.offset -1, 0);
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 				&BTRFS_I(inode)->runtime_flags);
@@ -10586,7 +10586,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 						cur_offset + ins.offset - 1,
 						0);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
 		cur_offset += ins.offset;
@@ -11017,7 +11017,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 		logical_block_start = em->block_start + (start - em->start);
 		len = min(len, em->len - (start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, true);
@@ -11061,7 +11061,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		physical_block_start = (em->map_lookup->stripes[0].physical +
 					(logical_block_start - em->start));
 		len = min(len, em->len - (logical_block_start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
@@ -11116,7 +11116,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 out:
 	if (!IS_ERR_OR_NULL(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 	unlock_extent_cached(io_tree, 0, isize - 1, &cached_state);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d56d6144707bb..06f8dc9eda45e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1007,7 +1007,7 @@ static int check_defrag_in_cache(struct inode *inode, u64 offset, u32 thresh)
 
 	if (em) {
 		end = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (end - offset > thresh)
 			return 0;
 	}
@@ -1134,7 +1134,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
 		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
 		ret = false;
 
-	free_extent_map(next);
+	btrfs_free_extent_map(next);
 	return ret;
 }
 
@@ -1194,7 +1194,7 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 		*defrag_end = 0;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1350,13 +1350,13 @@ static int cluster_pages_for_defrag(struct inode *inode,
 			goto out_unlock_range;
 		}
 		if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			/* Ok, 0 means we did not defrag anything */
 			ret = 0;
 			goto out_unlock_range;
 		}
 		search_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 	clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 06cf946834017..22f29464020f3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2962,7 +2962,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 	struct extent_map *em;
 	int ret = 0;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
 
@@ -2978,7 +2978,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 		ret = add_extent_mapping(em_tree, em, 0);
 		write_unlock(&em_tree->lock);
 		if (ret != -EEXIST) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3d5cb6e6b3bbe..5ef2b38802aad 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3621,7 +3621,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		}
 	}
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 319fed82d741f..fc200d581dbf1 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -30,7 +30,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 			refcount_set(&em->refs, 1);
 		}
 #endif
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 }
 
@@ -58,7 +58,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_8K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -76,10 +76,10 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
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
@@ -97,9 +97,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
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
@@ -127,7 +127,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 			 em->block_start, em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -146,7 +146,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	struct extent_map *em;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -164,10 +164,10 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
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
@@ -185,9 +185,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
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
@@ -215,7 +215,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 			 em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -229,7 +229,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_4K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -247,9 +247,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
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
@@ -282,7 +282,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 			 em->block_start, em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -328,7 +328,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	u64 len = SZ_4K;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -346,9 +346,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
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
@@ -367,9 +367,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
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
@@ -395,7 +395,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 			 em->block_len);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	free_extent_map_tree(em_tree);
 
@@ -462,7 +462,7 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
 	int i, out_ndaddrs, out_stripe_len;
 	int ret;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		test_std_err(TEST_ALLOC_EXTENT_MAP);
 		return -ENOMEM;
@@ -540,10 +540,10 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
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
index c9874b12d337c..fcc0c394153f9 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -266,7 +266,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->block_start);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
 
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
index 10d8fed57b5df..b9690aa183038 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4656,7 +4656,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			continue;
 		}
 
@@ -4665,7 +4665,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, root, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9ab226814cfde..2c52bf40c8a40 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3117,7 +3117,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, em->start, em->start + em->len);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3307,7 +3307,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		trans->removing_chunk = false;
 	}
 	/* once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5495,7 +5495,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		kfree(map);
 		return ERR_PTR(-ENOMEM);
@@ -5513,7 +5513,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	ret = add_extent_mapping(em_tree, em, 0);
 	if (ret) {
 		write_unlock(&em_tree->lock);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	write_unlock(&em_tree->lock);
@@ -5535,7 +5535,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
@@ -5547,9 +5547,9 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	write_unlock(&em_tree->lock);
 
 	/* One for our allocation */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* One for the tree reference */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return block_group;
 }
@@ -5722,7 +5722,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 
 out:
 	kfree(chunk);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5808,7 +5808,7 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (miss_ndevs > btrfs_chunk_max_errors(map))
 		readonly = 1;
 end:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return readonly;
 }
 
@@ -5825,9 +5825,9 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
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
 
@@ -5865,7 +5865,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		ret = map->num_stripes;
 	else
 		ret = 1;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
@@ -5889,7 +5889,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			len = map->stripe_len * nr_data_stripes(map);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return len;
 }
@@ -5906,7 +5906,7 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			ret = 1;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return ret;
 }
@@ -6177,7 +6177,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	bioc->map_type = map->type;
 	bioc->num_stripes = num_stripes;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -6714,7 +6714,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -7210,18 +7210,18 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
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
 
@@ -7257,7 +7257,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 								    devid, uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
 				ret = PTR_ERR(map->stripes[i].dev);
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				return ret;
 			}
 		}
@@ -7274,7 +7274,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  em->start, em->len, ret);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -7637,12 +7637,12 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
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
@@ -8237,7 +8237,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bff56f87b426a..bb73265c28005 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1148,7 +1148,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets), GFP_NOFS);
 	if (!alloc_offsets) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return -ENOMEM;
 	}
 
@@ -1313,7 +1313,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		cache->meta_write_pointer = cache->alloc_offset + cache->start;
 
 	kfree(alloc_offsets);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -1461,7 +1461,7 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	em = search_extent_mapping(em_tree, ordered->file_offset,
 				   ordered->num_bytes);
 	em->block_start = *logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	write_unlock(&em_tree->lock);
 
 	list_for_each_entry(sum, &ordered->list, list) {
@@ -1623,7 +1623,7 @@ struct btrfs_device *btrfs_zoned_get_device(struct btrfs_fs_info *fs_info,
 	ASSERT(map->num_stripes == 1);
 	device = map->stripes[0].dev;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return device;
 }
-- 
2.53.0

