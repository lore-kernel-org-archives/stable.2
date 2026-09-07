Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15444FECF9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795152; cv=none; b=P4X+zgfHvvgqmUTYA1ZAHSDics0R/rJdE+S9gH378hs9oOW3Ipdf8KuCtUxChrPcoy/FjZBEWN9DSUuffWx3JNGw1PWyrAYjTJEYMVseXgyA+OlJgw7XeiU1p3iFbMB3ds4DsHH123M7zIDT/oHmRUtmoIR8xMdf1xNZsateUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795152; c=relaxed/simple;
	bh=hzrN2xc4nbAjP7CLMRVXyfKUiu1JVuhkjJ56xEYYCU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVBrBPkG9RdnQOOq+ICZOWDXXrwQdkRAC7DMpQI4k7yRZu1viv/b9lsvtQ/VGMyNbPbnjCS2Pf3+9G7TI/BPTnDImaRaPlvQ/GyiCUTBzvMGYSnGPBQrdb30Sun+Qdb0kXZthAakupw+8/nDd6FSW5aET9D4Bywv5EMw29sPEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt09pmCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt09pmCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3C61F00ACA;
	Mon,  7 Sep 2026 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788795144;
	bh=WOLRmbxi1bMarf4sYOjYskAOFQkCyzkxoXucwM2viTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xt09pmCiRPhOK2t4DeJ63EmqP2zzMSL2V7OuwERIKGnmUCkG3n9BDFk1BqOTFQWM1
	 h0K4f2kZ04i1JVWtey4KmhYySNIfJtgCFgxHTzLRAweIT3/2cypaFMbEX07vyWw12N
	 8sCoSZUTDo2/L4qa6kw36eEGxrt804kqPKgeria8bwdN99cc0JGnzaZhyFPfGhEaL4
	 RxXaquvr+wlDvcfr8VtUHvAmZfHsgv5Na7XaXQarPP8kjC2czB1khupAGpXTIBeFZ/
	 fTeOJncG/K7hV4tPBHwNl34zNLLIW7qam3zb3Pam+9bESzMEMJwbfKePPn1ZMjL5cC
	 CWzrUacIUlCjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] btrfs: rename functions to allocate and free extent maps
Date: Mon,  7 Sep 2026 11:32:21 -0400
Message-ID: <20260907153222.3844162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-oblivion-chunk-24d7@gregkh>
References: <2026090311-oblivion-chunk-24d7@gregkh>
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
  backport carries 15. Not backported here:
  fs/btrfs/defrag.c
  fs/btrfs/direct-io.c
  fs/btrfs/zoned.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c            | 18 ++++-----
 fs/btrfs/compression.c            |  8 ++--
 fs/btrfs/dev-replace.c            |  2 +-
 fs/btrfs/extent_io.c              | 24 ++++++------
 fs/btrfs/extent_map.c             | 18 ++++-----
 fs/btrfs/extent_map.h             |  4 +-
 fs/btrfs/file.c                   | 48 +++++++++++------------
 fs/btrfs/inode.c                  | 64 +++++++++++++++----------------
 fs/btrfs/ioctl.c                  | 10 ++---
 fs/btrfs/relocation.c             |  4 +-
 fs/btrfs/scrub.c                  |  2 +-
 fs/btrfs/tests/extent-map-tests.c | 52 ++++++++++++-------------
 fs/btrfs/tests/inode-tests.c      | 42 ++++++++++----------
 fs/btrfs/tree-log.c               |  4 +-
 fs/btrfs/volumes.c                | 54 +++++++++++++-------------
 15 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c4e3c1a5de059..c04595b695ab3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1162,7 +1162,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		remove_extent_mapping(em_tree, em);
 		write_unlock(&em_tree->lock);
 		/* once for the tree */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 out:
@@ -1208,7 +1208,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 	 */
 	map = em->map_lookup;
 	num_items = 3 + map->num_stripes;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
 							   num_items);
@@ -1591,7 +1591,7 @@ static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	}
 
 out_free_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1734,7 +1734,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	*naddrs = nr;
 	*stripe_len = io_stripe_size;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1861,7 +1861,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	"chunk start=%llu len=%llu doesn't have corresponding block group",
 				     em->start, em->len);
 			ret = -EUCLEAN;
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		if (bg->start != em->start || bg->length != em->len ||
@@ -1874,12 +1874,12 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
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
@@ -3440,8 +3440,8 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 		write_unlock(&em_tree->lock);
 
 		/* once for us and once for the tree */
-		free_extent_map(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		/*
 		 * We may have left one free space entry and other possible
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 646416b5940e9..cffabf2b6327e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -565,13 +565,13 @@ static noinline int add_ra_bio_pages(struct inode *inode,
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
 			char *userpage;
@@ -662,7 +662,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	em_len = em->len;
 	em_start = em->start;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	cb->len = bio->bi_iter.bi_size;
@@ -779,7 +779,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 fail1:
 	kfree(cb);
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9a6055659c1a6..894d0b76986cd 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -683,7 +683,7 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 			if (srcdev == map->stripes[i].dev)
 				map->stripes[i].dev = tgtdev;
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	} while (start);
 	write_unlock(&em_tree->lock);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 38405087cc842..a70948e7c8365 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2495,7 +2495,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	}
 
 	if (em->start > start || em->start + em->len <= start) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 	}
 	read_unlock(&em_tree->lock);
@@ -2517,7 +2517,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		    logical, start, failrec->len);
 
 	failrec->logical = logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Set the bits in the private failure tree */
 	ret = set_extent_bits(failure_tree, start, end,
@@ -3120,7 +3120,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 			return em;
 		}
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*em_cached = NULL;
 	}
 
@@ -3275,7 +3275,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (prev_em_start)
 			*prev_em_start = em->start;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/* we've found a hole, just zero and go on */
@@ -3518,7 +3518,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		offset = em->block_start + extent_offset;
 		block_start = em->block_start;
 		compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/*
@@ -4366,7 +4366,7 @@ void extent_readahead(struct readahead_control *rac)
 	}
 
 	if (em_cached)
-		free_extent_map(em_cached);
+		btrfs_free_extent_map(em_cached);
 
 	if (bio) {
 		if (submit_one_bio(bio, 0, bio_flags))
@@ -4463,7 +4463,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 			if (test_bit(EXTENT_FLAG_PINNED, &em->flags) ||
 			    em->start != start) {
 				write_unlock(&map->lock);
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			if (test_range_bit(tree, em->start,
@@ -4503,13 +4503,13 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
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
@@ -4546,7 +4546,7 @@ static struct extent_map *get_extent_skip_holes(struct btrfs_inode *inode,
 
 		/* this is a hole, advance to the next extent */
 		offset = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (offset >= last)
 			break;
 	}
@@ -4840,7 +4840,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			flags |= FIEMAP_EXTENT_UNWRITTEN;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		if ((em_start >= last) || em_len == (u64)-1 ||
 		   (last == (u64)-1 && isize <= em_end)) {
@@ -4869,7 +4869,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 out_free:
 	if (!ret)
 		ret = emit_last_fiemap_cache(fieinfo, &cache);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
 			     &cached_state);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bd6229fb2b6f0..f1b01acef8881 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -45,9 +45,9 @@ void extent_map_tree_init(struct extent_map_tree *tree)
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
@@ -69,7 +69,7 @@ struct extent_map *alloc_extent_map(void)
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
@@ -620,7 +620,7 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
 		 */
 		if (start >= existing->start &&
 		    start < extent_map_end(existing)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
 		} else {
@@ -634,14 +634,14 @@ int btrfs_add_extent_mapping(struct btrfs_fs_info *fs_info,
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
index 38a293a9d0644..0c7a32c44bb6e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -539,9 +539,9 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 
 		modified = false;
 		if (!split)
-			split = alloc_extent_map();
+			split = btrfs_alloc_extent_map();
 		if (!split2)
-			split2 = alloc_extent_map();
+			split2 = btrfs_alloc_extent_map();
 		if (!split || !split2)
 			no_splits = 1;
 
@@ -555,14 +555,14 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -600,7 +600,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			split->flags = flags;
 			split->compress_type = em->compress_type;
 			replace_extent_mapping(em_tree, em, split, modified);
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = split2;
 			split2 = NULL;
 		}
@@ -644,7 +644,7 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 							 modified);
 				ASSERT(ret == 0); /* Logic error */
 			}
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = NULL;
 		}
 next:
@@ -653,14 +653,14 @@ void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -2411,7 +2411,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 
-	hole_em = alloc_extent_map();
+	hole_em = btrfs_alloc_extent_map();
 	if (!hole_em) {
 		btrfs_drop_extent_cache(inode, offset, end - 1, 0);
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
@@ -2433,7 +2433,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 			ret = add_extent_mapping(em_tree, hole_em, 1);
 			write_unlock(&em_tree->lock);
 		} while (ret == -EEXIST);
-		free_extent_map(hole_em);
+		btrfs_free_extent_map(hole_em);
 		if (ret)
 			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					&inode->runtime_flags);
@@ -2467,7 +2467,7 @@ static int find_first_non_hole(struct inode *inode, u64 *start, u64 *len)
 		       0 : *start + *len - em->start - em->len;
 		*start = em->start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -3103,7 +3103,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -3150,7 +3150,7 @@ static int btrfs_zero_range(struct inode *inode,
 			 * do nothing except updating the inode's i_size if
 			 * needed.
 			 */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
@@ -3165,7 +3165,7 @@ static int btrfs_zero_range(struct inode *inode,
 		offset = alloc_start;
 		alloc_hint = em->block_start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
@@ -3177,13 +3177,13 @@ static int btrfs_zero_range(struct inode *inode,
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
 			ret = btrfs_truncate_block(inode, offset, len, 0);
 			if (!ret)
 				ret = btrfs_fallocate_update_isize(inode,
@@ -3191,7 +3191,7 @@ static int btrfs_zero_range(struct inode *inode,
 								   mode);
 			return ret;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
 		alloc_end = alloc_start + sectorsize;
 		goto reserve_space;
@@ -3431,7 +3431,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			ret = add_falloc_range(&reserve_list, cur_offset,
 					       last_byte - cur_offset);
 			if (ret < 0) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
@@ -3439,7 +3439,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 					last_byte - cur_offset);
 			if (ret < 0) {
 				cur_offset = last_byte;
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				break;
 			}
 		} else {
@@ -3452,7 +3452,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 				data_reserved, cur_offset,
 				last_byte - cur_offset);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		cur_offset = last_byte;
 	}
 
@@ -3544,11 +3544,11 @@ static loff_t find_desired_extent(struct inode *inode, loff_t offset,
 			break;
 
 		start = em->start + em->len;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		cond_resched();
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 	if (ret) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3c61f540597d2..7f2aab8eb8705 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -859,7 +859,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 		if (IS_ERR(em))
 			/* ret value is not necessary due to void function */
 			goto out_free_reserve;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent_compress(inode,
 						async_extent->start,
@@ -942,15 +942,15 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
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
@@ -1069,7 +1069,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
 					       ram_size, cur_alloc_size, 0);
@@ -1700,7 +1700,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				ret = PTR_ERR(em);
 				goto error;
 			}
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
@@ -2277,7 +2277,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 				     NULL, cached_state, GFP_NOFS);
 next:
 		search_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (ret)
 			return ret;
 	}
@@ -4811,7 +4811,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 
 			btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
 						cur_offset + hole_size - 1, 0);
-			hole_em = alloc_extent_map();
+			hole_em = btrfs_alloc_extent_map();
 			if (!hole_em) {
 				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					&BTRFS_I(inode)->runtime_flags);
@@ -4839,7 +4839,7 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 							cur_offset +
 							hole_size - 1, 0);
 			}
-			free_extent_map(hole_em);
+			btrfs_free_extent_map(hole_em);
 		} else {
 			err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
 							cur_offset, hole_size);
@@ -4847,13 +4847,13 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
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
@@ -5003,7 +5003,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(map_tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (need_resched()) {
 			write_unlock(&map_tree->lock);
 			cond_resched();
@@ -6613,13 +6613,13 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
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
@@ -6795,7 +6795,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	trace_btrfs_get_extent(root, inode, em);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	return em;
@@ -6865,7 +6865,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 		u64 hole_len;
 		const u64 hole_end = extent_map_end(hole_em);
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			err = -ENOMEM;
 			goto out;
@@ -6880,7 +6880,7 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 		 * make sure it is based on the start from the caller
 		 */
 		if (hole_end <= start || hole_em->start > end) {
-		       free_extent_map(hole_em);
+		       btrfs_free_extent_map(hole_em);
 		       hole_em = NULL;
 		} else {
 		       hole_start = max(hole_em->start, start);
@@ -6920,9 +6920,9 @@ struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
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
@@ -6953,7 +6953,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 					   block_len, type);
 	if (ret) {
 		if (em) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_drop_extent_cache(inode, start, start + len - 1, 0);
 		}
 		em = ERR_PTR(ret);
@@ -7256,7 +7256,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	       type == BTRFS_ORDERED_REGULAR);
 
 	em_tree = &inode->extent_tree;
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return ERR_PTR(-ENOMEM);
 
@@ -7289,7 +7289,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	} while (ret == -EEXIST);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 
@@ -7340,7 +7340,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 						      ram_bytes, type);
 			btrfs_dec_nocow_writers(fs_info, block_start);
 			if (type == BTRFS_ORDERED_PREALLOC) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				*map = em = em2;
 			}
 
@@ -7359,7 +7359,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	}
 
 	/* this will cow the extent */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	*map = em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -7477,7 +7477,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 */
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
 	    em->block_start == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
 		 * fallback to buffered IO. This is not only because we can
@@ -7536,7 +7536,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return 0;
 
@@ -9874,7 +9874,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
 					cur_offset + ins.offset -1, 0);
 
-		em = alloc_extent_map();
+		em = btrfs_alloc_extent_map();
 		if (!em) {
 			set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 				&BTRFS_I(inode)->runtime_flags);
@@ -9901,7 +9901,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 						cur_offset + ins.offset - 1,
 						0);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
 		cur_offset += ins.offset;
@@ -10326,7 +10326,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 		logical_block_start = em->block_start + (start - em->start);
 		len = min(len, em->len - (start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, true);
@@ -10370,7 +10370,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		physical_block_start = (em->map_lookup->stripes[0].physical +
 					(logical_block_start - em->start));
 		len = min(len, em->len - (logical_block_start - em->start));
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
@@ -10425,7 +10425,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 out:
 	if (!IS_ERR_OR_NULL(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 	unlock_extent_cached(io_tree, 0, isize - 1, &cached_state);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 16c397062809f..22d040fe8c698 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1073,7 +1073,7 @@ static int check_defrag_in_cache(struct inode *inode, u64 offset, u32 thresh)
 
 	if (em) {
 		end = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (end - offset > thresh)
 			return 0;
 	}
@@ -1200,7 +1200,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em)
 		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
 		ret = false;
 
-	free_extent_map(next);
+	btrfs_free_extent_map(next);
 	return ret;
 }
 
@@ -1260,7 +1260,7 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
 		*defrag_end = 0;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -1409,13 +1409,13 @@ static int cluster_pages_for_defrag(struct inode *inode,
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
index 5b921e6ed94e2..11e8a7ee5e638 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2653,7 +2653,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 	struct extent_map *em;
 	int ret = 0;
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
 
@@ -2669,7 +2669,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 		ret = add_extent_mapping(em_tree, em, 0);
 		write_unlock(&em_tree->lock);
 		if (ret != -EEXIST) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c8d033deb8ab8..1d4cd90fa5efc 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3408,7 +3408,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		}
 	}
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 57379e96ccc90..c814b74c30496 100644
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
index 04022069761de..d983e6f358fb3 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -271,7 +271,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->block_start);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
 
 	/*
@@ -301,7 +301,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -329,7 +329,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * this?
 	 */
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -351,7 +351,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Regular extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -379,7 +379,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are split extents */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -409,7 +409,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -431,7 +431,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -464,7 +464,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -493,7 +493,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -524,7 +524,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -557,7 +557,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -591,7 +591,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Now for the compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -625,7 +625,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Split compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
@@ -661,7 +661,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = em->block_start;
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -688,7 +688,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -722,7 +722,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsize);
@@ -750,7 +750,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
 	if (IS_ERR(em)) {
@@ -783,7 +783,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -812,7 +812,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
@@ -889,7 +889,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 			 em->flags);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
@@ -914,7 +914,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cdb5a2770faf3..553838abc055f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4524,7 +4524,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			continue;
 		}
 
@@ -4533,7 +4533,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, root, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index da77493f4c17d..acda5ab93cf6b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3046,7 +3046,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, em->start, em->start + em->len);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -3143,7 +3143,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 
 out:
 	/* once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5243,7 +5243,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
-	em = alloc_extent_map();
+	em = btrfs_alloc_extent_map();
 	if (!em) {
 		kfree(map);
 		return -ENOMEM;
@@ -5261,7 +5261,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	ret = add_extent_mapping(em_tree, em, 0);
 	if (ret) {
 		write_unlock(&em_tree->lock);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ret;
 	}
 	write_unlock(&em_tree->lock);
@@ -5283,7 +5283,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
@@ -5295,9 +5295,9 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	write_unlock(&em_tree->lock);
 
 	/* One for our allocation */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* One for the tree reference */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -5454,7 +5454,7 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 
 out:
 	kfree(chunk);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -5515,7 +5515,7 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (miss_ndevs > btrfs_chunk_max_errors(map))
 		readonly = 1;
 end:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return readonly;
 }
 
@@ -5532,9 +5532,9 @@ void btrfs_mapping_tree_free(struct extent_map_tree *tree)
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
 
@@ -5572,7 +5572,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		ret = map->num_stripes;
 	else
 		ret = 1;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	down_read(&fs_info->dev_replace.rwsem);
 	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace) &&
@@ -5596,7 +5596,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			len = map->stripe_len * nr_data_stripes(map);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return len;
 }
@@ -5613,7 +5613,7 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 		map = em->map_lookup;
 		if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
 			ret = 1;
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	return ret;
 }
@@ -5875,7 +5875,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	bbio->map_type = map->type;
 	bbio->num_stripes = num_stripes;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -6151,7 +6151,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 out:
 	/* once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -6393,7 +6393,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -6772,18 +6772,18 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
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
 
@@ -6815,7 +6815,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 							devid, uuid, NULL, true);
 		if (!map->stripes[i].dev &&
 		    !btrfs_test_opt(fs_info, DEGRADED)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_report_missing_device(fs_info, devid, uuid, true);
 			return -ENOENT;
 		}
@@ -6824,7 +6824,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				add_missing_dev(fs_info->fs_devices, devid,
 						uuid);
 			if (IS_ERR(map->stripes[i].dev)) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				btrfs_err(fs_info,
 					"failed to init missing dev %llu: %ld",
 					devid, PTR_ERR(map->stripes[i].dev));
@@ -6845,7 +6845,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  em->start, em->len, ret);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -7196,12 +7196,12 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
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
@@ -7773,7 +7773,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
-- 
2.53.0

