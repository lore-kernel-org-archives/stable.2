Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9C3939A9
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723065; cv=none; b=UO9uB7X/rnOdqobnMBo+2CDFhAkxntC8/qDmQKNvfcDonFyprA/4m1H7syKs+zBqxmXLcZts9pyJaoxYBh2rzwMDW717hImwWuI0pZNe88TL4VF+pVbhRvT4fjEEWkigeLqfk6J+qS8s3KJIfS++ecbS+40xlGANntPtOFMAk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723065; c=relaxed/simple;
	bh=emZQX/RK0+rwv2DGYhzC4FPP9nHlams2u9lwe+RsPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyUykGgWtKAuo2+R4up1+m/yzI5YqG3+ogkfGSCunWjS5fZbLMjnnag7nDZpNaQTEkpIz1EoEn0IZ1t0ViGF6MOymfRLoYbB2yv2bgaIcf71DhaLbl2iz3osJnS16HET2uggGVbN+HL26TbzVfWZog85IVxO1efWk8dBb4fNbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaHE/+Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaHE/+Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F81F00A3A;
	Sun,  6 Sep 2026 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723060;
	bh=MGt+EJcyWAV7uNpa8P05zHQmSzr8oFCCdrf2lFN/6f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gaHE/+Ie4wRaylMmPRTWl4LnbEKH7ldrVnklS1nOVsDyfRLcmHwnGa9L7RYuRWRsY
	 m6PskptAD/7jnW5n0t0hg726CjikPtW3XvMa/NRjZgFK7KBP8QnSmu1v2h4AO85zOf
	 kAWImHTxOf7bbapIqrn+tsZztWwEsJXeGZoSLPF+hP9WEckMRRneg7B1y0sj9yDTZn
	 5InJ4AsDjv/V51RxadH7Ju5RFFv8E8XfzFwV1fCnFzIdctXyjrvs+KFUXD2NtIPDJG
	 8g9Xd6Ra/b3uKDwe/xNa/k+tXx0yMqgh5ELckhVOYv4mfSzoK1tzsz+4foObd2yp2c
	 DzvSFLuJPf43Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
Date: Sun,  6 Sep 2026 15:30:54 -0400
Message-ID: <20260906193056.1792186-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193056.1792186-1-sashal@kernel.org>
References: <2026090310-unwarlike-canister-1f00@gregkh>
 <20260906193056.1792186-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 242570e80bfdf3f98ca13031c723edd72c69bdc2 ]

These functions are exported so they should have a 'btrfs_' prefix by
convention, to make it clear they are btrfs specific and to avoid
collisions with functions from elsewhere in the kernel. So add a prefix to
their name.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/compression.c            |  12 ++--
 fs/btrfs/defrag.c                 |  28 ++++----
 fs/btrfs/direct-io.c              |  20 +++---
 fs/btrfs/extent-io-tree.h         |   6 +-
 fs/btrfs/extent_io.c              |  30 ++++----
 fs/btrfs/extent_map.c             |  44 ++++++------
 fs/btrfs/extent_map.h             |   2 +-
 fs/btrfs/fiemap.c                 |   4 +-
 fs/btrfs/file.c                   |  60 ++++++++--------
 fs/btrfs/free-space-cache.c       |  10 +--
 fs/btrfs/inode.c                  | 112 +++++++++++++++---------------
 fs/btrfs/ioctl.c                  |   2 +-
 fs/btrfs/ordered-data.c           |   8 +--
 fs/btrfs/reflink.c                |   8 +--
 fs/btrfs/relocation.c             |  24 +++----
 fs/btrfs/tests/extent-io-tests.c  |   6 +-
 fs/btrfs/tests/extent-map-tests.c |  42 +++++------
 fs/btrfs/tests/inode-tests.c      |  40 +++++------
 fs/btrfs/tree-log.c               |   8 +--
 fs/btrfs/zoned.c                  |   2 +-
 20 files changed, 234 insertions(+), 234 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7bd5e7ff97f23..e0a95f8009044 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -499,7 +499,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + folio_size(folio) - 1;
-		lock_extent(tree, cur, page_end, NULL);
+		btrfs_lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -513,15 +513,15 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (extent_map_block_start(em) >> SECTOR_SHIFT) !=
 		    orig_bio->bi_iter.bi_sector) {
-			free_extent_map(em);
-			unlock_extent(tree, cur, page_end, NULL);
+			btrfs_free_extent_map(em);
+			btrfs_unlock_extent(tree, cur, page_end, NULL);
 			folio_unlock(folio);
 			folio_put(folio);
 			break;
 		}
 		add_size = min(em->start + em->len, page_end + 1) - cur;
-		free_extent_map(em);
-		unlock_extent(tree, cur, page_end, NULL);
+		btrfs_free_extent_map(em);
+		btrfs_unlock_extent(tree, cur, page_end, NULL);
 
 		if (folio->index == end_index) {
 			size_t zero_offset = offset_in_folio(folio, isize);
@@ -603,7 +603,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compress_type = extent_map_compression(em);
 	cb->orig_bbio = bbio;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	cb->nr_folios = DIV_ROUND_UP(compressed_len, PAGE_SIZE);
 	cb->compressed_folios = kcalloc(cb->nr_folios, sizeof(struct folio *), GFP_NOFS);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae9539482..9fc7babc40032 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -734,12 +734,12 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 
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
 
@@ -769,7 +769,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * file extent items in the inode's subvolume tree).
 	 */
 	if (em && (em->flags & EXTENT_FLAG_MERGED)) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 	}
 
@@ -779,10 +779,10 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 
 		/* Get the big lock and read metadata off disk. */
 		if (!locked)
-			lock_extent(io_tree, start, end, &cached);
+			btrfs_lock_extent(io_tree, start, end, &cached);
 		em = defrag_get_extent(BTRFS_I(inode), start, newer_than);
 		if (!locked)
-			unlock_extent(io_tree, start, end, &cached);
+			btrfs_unlock_extent(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
 			return NULL;
@@ -837,7 +837,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 
 	ret = true;
 out:
-	free_extent_map(next);
+	btrfs_free_extent_map(next);
 	return ret;
 }
 
@@ -894,9 +894,9 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
+		btrfs_unlock_extent(&inode->io_tree, page_start, page_end,
 			      &cached_state);
 		if (!ordered)
 			break;
@@ -1099,7 +1099,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		/* Allocate new defrag_target_range */
 		new = kmalloc(sizeof(*new), GFP_NOFS);
 		if (!new) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1109,7 +1109,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 
 next:
 		cur = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	if (ret < 0) {
 		struct defrag_target_range *entry;
@@ -1226,7 +1226,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		folio_wait_writeback(folios[i]);
 
 	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+	btrfs_lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
 		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
 		    &cached_state);
 	/*
@@ -1240,7 +1240,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 				     newer_than, do_compress, true,
 				     &target_list, last_scanned_ret);
 	if (ret < 0)
-		goto unlock_extent;
+		goto btrfs_unlock_extent;
 
 	list_for_each_entry(entry, &target_list, list) {
 		ret = defrag_one_locked_target(inode, entry, folios, nr_pages,
@@ -1253,8 +1253,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		list_del_init(&entry->list);
 		kfree(entry);
 	}
-unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+btrfs_unlock_extent:
+	btrfs_unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
 		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
 		      &cached_state);
 free_folios:
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 3e286f5fcdbd4..eb472dc3aab7d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -52,13 +52,13 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 	while (1) {
 		if (nowait) {
-			if (!try_lock_extent(io_tree, lockstart, lockend,
+			if (!btrfs_try_lock_extent(io_tree, lockstart, lockend,
 					     cached_state)) {
 				ret = -EAGAIN;
 				break;
 			}
 		} else {
-			lock_extent(io_tree, lockstart, lockend, cached_state);
+			btrfs_lock_extent(io_tree, lockstart, lockend, cached_state);
 		}
 		/*
 		 * We're concerned with the entire range that we're going to be
@@ -80,7 +80,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 							 lockstart, lockend)))
 			break;
 
-		unlock_extent(io_tree, lockstart, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, lockstart, lockend, cached_state);
 
 		if (ordered) {
 			if (nowait) {
@@ -157,7 +157,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 					     (1U << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
 					start + file_extent->num_bytes - 1, false);
 		}
@@ -268,7 +268,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 						      nowait);
 		if (ret < 0) {
 			/* Our caller expects us to free the input extent map. */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = NULL;
 			btrfs_dec_nocow_writers(bg);
 			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
@@ -281,7 +281,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 					      &file_extent, type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*map = em2;
 			em = em2;
 		}
@@ -294,7 +294,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*map = NULL;
 
 		if (nowait) {
@@ -484,7 +484,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * the generic code.
 	 */
 	if (extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		/*
 		 * If we are in a NOWAIT context, return -EAGAIN in order to
 		 * fallback to buffered IO. This is not only because we can
@@ -525,7 +525,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * after we have submitted bios for all the extents in the range.
 	 */
 	if ((flags & IOMAP_NOWAIT) && len < length) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		ret = -EAGAIN;
 		goto unlock_err;
 	}
@@ -573,7 +573,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->offset = start;
 	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/*
 	 * Reads will hold the EXTENT_DIO_LOCKED bit until the io is completed,
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6ffef1cd37c1b..3553bcf822e9f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -142,13 +142,13 @@ int __lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 bool __try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		       struct extent_state **cached);
 
-static inline int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+static inline int btrfs_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 			      struct extent_state **cached)
 {
 	return __lock_extent(tree, start, end, EXTENT_LOCKED, cached);
 }
 
-static inline bool try_lock_extent(struct extent_io_tree *tree, u64 start,
+static inline bool btrfs_try_lock_extent(struct extent_io_tree *tree, u64 start,
 				   u64 end, struct extent_state **cached)
 {
 	return __try_lock_extent(tree, start, end, EXTENT_LOCKED, cached);
@@ -179,7 +179,7 @@ static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	return __clear_extent_bit(tree, start, end, bits, cached, NULL);
 }
 
-static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+static inline int btrfs_unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				struct extent_state **cached)
 {
 	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached, NULL);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 29982abb4f9d3..ac46cd27a99bc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -409,13 +409,13 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 
 	/* step three, lock the state bits for the whole range */
-	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
+	btrfs_lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, cached_state);
 
-	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
+	btrfs_unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
 		__unlock_for_delalloc(inode, locked_folio, delalloc_start,
 				      delalloc_end);
@@ -947,7 +947,7 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 			return em;
 		}
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		*em_cached = NULL;
 	}
 
@@ -1102,7 +1102,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		bio_ctrl->last_em_start = em->start;
 
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 
 		/* we've found a hole, just zero and go on */
@@ -1153,9 +1153,9 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
-	free_extent_map(em_cached);
+	btrfs_free_extent_map(em_cached);
 
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
@@ -1344,7 +1344,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 * We've hit an error during previous delalloc range,
 			 * have to cleanup the remaining locked ranges.
 			 */
-			unlock_extent(&inode->io_tree, found_start,
+			btrfs_unlock_extent(&inode->io_tree, found_start,
 				      found_start + found_len - 1, NULL);
 			__unlock_for_delalloc(&inode->vfs_inode, folio,
 					      found_start,
@@ -1491,7 +1491,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(block_start != EXTENT_MAP_HOLE);
 	ASSERT(block_start != EXTENT_MAP_INLINE);
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	/*
@@ -2498,10 +2498,10 @@ void btrfs_readahead(struct readahead_control *rac)
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	if (em_cached)
-		free_extent_map(em_cached);
+		btrfs_free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
 }
 
@@ -2525,7 +2525,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	if (start > end)
 		return 0;
 
-	lock_extent(tree, start, end, &cached_state);
+	btrfs_lock_extent(tree, start, end, &cached_state);
 	folio_wait_writeback(folio);
 
 	/*
@@ -2533,7 +2533,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 	 * so here we only need to unlock the extent range to free any
 	 * existing extent state.
 	 */
-	unlock_extent(tree, start, end, &cached_state);
+	btrfs_unlock_extent(tree, start, end, &cached_state);
 	return 0;
 }
 
@@ -2602,7 +2602,7 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		}
 		if ((em->flags & EXTENT_FLAG_PINNED) || em->start != start) {
 			write_unlock(&extent_tree->lock);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			break;
 		}
 		if (test_range_bit_exists(io_tree, em->start,
@@ -2635,13 +2635,13 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 		 */
 		remove_extent_mapping(inode, em);
 		/* Once for the inode's extent map tree. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		start = extent_map_end(em);
 		write_unlock(&extent_tree->lock);
 
 		/* Once for us, for the lookup_extent_mapping() reference. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (need_resched()) {
 			/*
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 044970109c7b5..2a51c1958a11a 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -40,7 +40,7 @@ void extent_map_tree_init(struct extent_map_tree *tree)
 
 /*
  * Allocate a new extent_map structure.  The new structure is returned with a
- * reference count of one and needs to be freed using free_extent_map()
+ * reference count of one and needs to be freed using btrfs_free_extent_map()
  */
 struct extent_map *alloc_extent_map(void)
 {
@@ -58,7 +58,7 @@ struct extent_map *alloc_extent_map(void)
  * Drop the reference out on @em by one and free the structure if the reference
  * count hits zero.
  */
-void free_extent_map(struct extent_map *em)
+void btrfs_free_extent_map(struct extent_map *em)
 {
 	if (!em)
 		return;
@@ -373,7 +373,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			validate_extent_map(fs_info, em);
 			rb_erase(&merge->rb_node, &tree->root);
 			RB_CLEAR_NODE(&merge->rb_node);
-			free_extent_map(merge);
+			btrfs_free_extent_map(merge);
 			dec_evictable_extent_maps(inode);
 		}
 	}
@@ -390,7 +390,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		RB_CLEAR_NODE(&merge->rb_node);
 		em->generation = max(em->generation, merge->generation);
 		em->flags |= EXTENT_FLAG_MERGED;
-		free_extent_map(merge);
+		btrfs_free_extent_map(merge);
 		dec_evictable_extent_maps(inode);
 	}
 }
@@ -446,7 +446,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 out:
 	write_unlock(&tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 
 }
@@ -730,7 +730,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 		 */
 		if (start >= existing->start &&
 		    start < extent_map_end(existing)) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			*em_in = existing;
 			ret = 0;
 		} else {
@@ -743,14 +743,14 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			 */
 			ret = merge_extent_mapping(inode, existing, em, start);
 			if (WARN_ON(ret)) {
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 				*em_in = NULL;
 				btrfs_warn(fs_info,
 "extent map merge error existing [%llu, %llu) with em [%llu, %llu) start %llu",
 					   existing->start, extent_map_end(existing),
 					   orig_start, orig_start + orig_len, start);
 			}
-			free_extent_map(existing);
+			btrfs_free_extent_map(existing);
 		}
 	}
 
@@ -777,7 +777,7 @@ static void drop_all_extent_maps_fast(struct btrfs_inode *inode)
 		em = rb_entry(node, struct extent_map, rb_node);
 		em->flags &= ~(EXTENT_FLAG_PINNED | EXTENT_FLAG_LOGGING);
 		remove_extent_mapping(inode, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		if (cond_resched_rwlock_write(&tree->lock))
 			node = rb_first(&tree->root);
@@ -902,7 +902,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 			split->flags = flags;
 			replace_extent_mapping(inode, em, split, modified);
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = split2;
 			split2 = NULL;
 		}
@@ -940,7 +940,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				if (WARN_ON(ret != 0) && modified)
 					btrfs_set_inode_full_sync(inode);
 			}
-			free_extent_map(split);
+			btrfs_free_extent_map(split);
 			split = NULL;
 		}
 remove_em:
@@ -976,18 +976,18 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
@@ -1059,7 +1059,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		goto out_free_pre;
 	}
 
-	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	btrfs_lock_extent(&inode->io_tree, start, start + len - 1, NULL);
 	write_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, len);
 	if (!em) {
@@ -1106,16 +1106,16 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	add_extent_mapping(inode, split_mid, 1);
 
 	/* Once for us */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Once for the tree */
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 out_unlock:
 	write_unlock(&em_tree->lock);
-	unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
-	free_extent_map(split_mid);
+	btrfs_unlock_extent(&inode->io_tree, start, start + len - 1, NULL);
+	btrfs_free_extent_map(split_mid);
 out_free_pre:
-	free_extent_map(split_pre);
+	btrfs_free_extent_map(split_pre);
 	return ret;
 }
 
@@ -1177,7 +1177,7 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		remove_extent_mapping(inode, em);
 		trace_btrfs_extent_map_shrinker_remove_em(inode, em);
 		/* Drop the reference for the tree. */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		nr_dropped++;
 next:
 		if (ctx->scanned >= ctx->nr_to_scan)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index cd123b266b641..9339748742142 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -174,7 +174,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 		     u64 new_logical);
 
 struct extent_map *alloc_extent_map(void);
-void free_extent_map(struct extent_map *em);
+void btrfs_free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index df7f09f3b02e0..7364bae6b1720 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -661,7 +661,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	range_end = round_up(start + len, sectorsize);
 	prev_extent_end = range_start;
 
-	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
@@ -841,7 +841,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	}
 
 out_unlock:
-	unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, range_start, range_end, &cached_state);
 
 	if (ret == BTRFS_FIEMAP_FLUSH_CACHE) {
 		btrfs_release_path(path);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4bf595b973d05..e27fa2059d853 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -998,7 +998,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		struct btrfs_ordered_extent *ordered;
 
 		if (nowait) {
-			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
+			if (!btrfs_try_lock_extent(&inode->io_tree, start_pos, last_pos,
 					     cached_state)) {
 				for (i = 0; i < num_pages; i++) {
 					unlock_page(pages[i]);
@@ -1009,7 +1009,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 				return -EAGAIN;
 			}
 		} else {
-			lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
+			btrfs_lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
 		}
 
 		ordered = btrfs_lookup_ordered_range(inode, start_pos,
@@ -1017,7 +1017,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		if (ordered &&
 		    ordered->file_offset + ordered->num_bytes > start_pos &&
 		    ordered->file_offset <= last_pos) {
-			unlock_extent(&inode->io_tree, start_pos, last_pos,
+			btrfs_unlock_extent(&inode->io_tree, start_pos, last_pos,
 				      cached_state);
 			for (i = 0; i < num_pages; i++) {
 				unlock_page(pages[i]);
@@ -1102,7 +1102,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	else
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	return ret;
 }
@@ -1398,7 +1398,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		 * possible cached extent state to avoid a memory leak.
 		 */
 		if (extents_locked)
-			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+			btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
 				      lockend, &cached_state);
 		else
 			free_extent_state(cached_state);
@@ -1957,11 +1957,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_wait_writeback(folio);
 
-	lock_extent(io_tree, page_start, page_end, &cached_state);
+	btrfs_lock_extent(io_tree, page_start, page_end, &cached_state);
 	ret2 = set_folio_extent_mapped(folio);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -1971,7 +1971,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
 	if (ordered) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered);
@@ -1992,7 +1992,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_reset_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					   &cached_state);
 	if (ret2) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
+		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
@@ -2012,7 +2012,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-	unlock_extent(io_tree, page_start, page_end, &cached_state);
+	btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
@@ -2168,7 +2168,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
-		free_extent_map(hole_em);
+		btrfs_free_extent_map(hole_em);
 		if (ret)
 			btrfs_set_inode_full_sync(inode);
 	}
@@ -2201,7 +2201,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 		       0 : *start + *len - em->start - em->len;
 		*start = em->start + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2275,7 +2275,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
-		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		btrfs_lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
@@ -2290,7 +2290,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		if (!check_range_has_page(inode, lockstart, lockend))
 			break;
 
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			      cached_state);
 	}
 
@@ -2790,7 +2790,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out:
-	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 		      &cached_state);
 out_only_mutex:
 	if (!updated_inode && truncated_block && !ret) {
@@ -2919,7 +2919,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	else
 		ret = RANGE_BOUNDARY_WRITTEN_EXTENT;
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	return ret;
 }
 
@@ -2963,7 +2963,7 @@ static int btrfs_zero_range(struct inode *inode,
 			 * do nothing except updating the inode's i_size if
 			 * needed.
 			 */
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
@@ -2978,7 +2978,7 @@ static int btrfs_zero_range(struct inode *inode,
 		offset = alloc_start;
 		alloc_hint = extent_map_block_start(em) + em->len;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
@@ -2989,13 +2989,13 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 
 		if (em->flags & EXTENT_FLAG_PREALLOC) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_fallocate_update_isize(inode, offset + len,
 							   mode);
 			goto out;
 		}
 		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
 			if (!ret)
@@ -3004,7 +3004,7 @@ static int btrfs_zero_range(struct inode *inode,
 								   mode);
 			return ret;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
 		alloc_end = alloc_start + sectorsize;
 		goto reserve_space;
@@ -3071,7 +3071,7 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret) {
-			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
+			btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
 				      lockend, &cached_state);
 			goto out;
 		}
@@ -3079,7 +3079,7 @@ static int btrfs_zero_range(struct inode *inode,
 						alloc_end - alloc_start,
 						fs_info->sectorsize,
 						offset + len, &alloc_hint);
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			      &cached_state);
 		/* btrfs_prealloc_file_range releases reserved space on error */
 		if (ret) {
@@ -3191,7 +3191,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	locked_end = alloc_end - 1;
-	lock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 		    &cached_state);
 
 	btrfs_assert_inode_range_clean(BTRFS_I(inode), alloc_start, locked_end);
@@ -3214,19 +3214,19 @@ static long btrfs_fallocate(struct file *file, int mode,
 
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
 
@@ -3280,7 +3280,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	 */
 	ret = btrfs_fallocate_update_isize(inode, actual_end, mode);
 out_unlock:
-	unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 		      &cached_state);
 out:
 	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
@@ -3627,7 +3627,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 
 	last_extent_end = lockstart;
 
-	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0) {
@@ -3773,7 +3773,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	}
 
 out:
-	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	btrfs_free_path(path);
 
 	if (ret < 0)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 01588dd3c7028..effc8895516a5 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -340,7 +340,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(inode, 0);
 	truncate_pagecache(vfs_inode, 0);
 
-	lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	btrfs_drop_extent_map_range(inode, 0, (u64)-1, false);
 
 	/*
@@ -352,7 +352,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 	btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-	unlock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
+	btrfs_unlock_extent(&inode->io_tree, 0, (u64)-1, &cached_state);
 	if (ret)
 		goto fail;
 
@@ -1294,7 +1294,7 @@ cleanup_write_cache_enospc(struct inode *inode,
 			   struct extent_state **cached_state)
 {
 	io_ctl_drop_pages(io_ctl);
-	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
 		      cached_state);
 }
 
@@ -1419,7 +1419,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	if (ret)
 		goto out_unlock;
 
-	lock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
 		    &cached_state);
 
 	io_ctl_set_generation(io_ctl, trans->transid);
@@ -1475,7 +1475,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 	io_ctl_drop_pages(io_ctl);
 	io_ctl_free(io_ctl);
 
-	unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
 		      &cached_state);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab30015e52a7c..a281ddd318d95 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -746,12 +746,12 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 	if (!can_cow_file_range_inline(inode, offset, size, compressed_size))
 		return 1;
 
-	lock_extent(&inode->io_tree, offset, end, &cached);
+	btrfs_lock_extent(&inode->io_tree, offset, end, &cached);
 	ret = __cow_file_range_inline(inode, offset, size, compressed_size,
 				      compress_type, compressed_folio,
 				      update_i_size);
 	if (ret > 0) {
-		unlock_extent(&inode->io_tree, offset, end, &cached);
+		btrfs_unlock_extent(&inode->io_tree, offset, end, &cached);
 		return ret;
 	}
 
@@ -1243,7 +1243,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		goto done;
 	}
 
-	lock_extent(io_tree, start, end, &cached);
+	btrfs_lock_extent(io_tree, start, end, &cached);
 
 	/* Here we're doing allocation and writeback of the compressed pages */
 	file_extent.disk_bytenr = ins.objectid;
@@ -1258,7 +1258,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 					     1U << BTRFS_ORDERED_COMPRESSED);
@@ -1323,15 +1323,15 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 		 * block is also bogus then just don't worry about it.
 		 */
 		if (em->disk_bytenr >= EXTENT_MAP_LAST_BYTE) {
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			em = search_extent_mapping(em_tree, 0, 0);
 			if (em && em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
 				alloc_hint = extent_map_block_start(em);
 			if (em)
-				free_extent_map(em);
+				btrfs_free_extent_map(em);
 		} else {
 			alloc_hint = extent_map_block_start(em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		}
 	}
 	read_unlock(&em_tree->lock);
@@ -1502,23 +1502,23 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		 * Locked range will be released either during error clean up or
 		 * after the whole range is finished.
 		 */
-		lock_extent(&inode->io_tree, start, start + ram_size - 1,
+		btrfs_lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
 
 		em = btrfs_create_io_em(inode, start, &file_extent,
 					BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(em)) {
-			unlock_extent(&inode->io_tree, start,
+			btrfs_unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
 			ret = PTR_ERR(em);
 			goto out_reserve;
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 
 		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 						     1U << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
-			unlock_extent(&inode->io_tree, start,
+			btrfs_unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
 			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
@@ -1853,7 +1853,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * group that contains that extent to RO mode and therefore force COW
 	 * when starting writeback.
 	 */
-	lock_extent(io_tree, start, end, &cached_state);
+	btrfs_lock_extent(io_tree, start, end, &cached_state);
 	count = count_range_bits(io_tree, &range_start, end, range_bytes,
 				 EXTENT_NORESERVE, 0, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
@@ -1872,7 +1872,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 			clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
 					 NULL);
 	}
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
 	/*
 	 * Don't try to create inline extents, as a mix of inline extent that
@@ -2083,7 +2083,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	u64 end = file_pos + len - 1;
 	int ret = 0;
 
-	lock_extent(&inode->io_tree, file_pos, end, cached);
+	btrfs_lock_extent(&inode->io_tree, file_pos, end, cached);
 
 	if (is_prealloc) {
 		struct extent_map *em;
@@ -2091,10 +2091,10 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 		em = btrfs_create_io_em(inode, file_pos, &nocow_args->file_extent,
 					BTRFS_ORDERED_PREALLOC);
 		if (IS_ERR(em)) {
-			unlock_extent(&inode->io_tree, file_pos, end, cached);
+			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
 			return PTR_ERR(em);
 		}
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, file_pos, &nocow_args->file_extent,
@@ -2104,7 +2104,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	if (IS_ERR(ordered)) {
 		if (is_prealloc)
 			btrfs_drop_extent_map_range(inode, file_pos, end, false);
-		unlock_extent(&inode->io_tree, file_pos, end, cached);
+		btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
 		return PTR_ERR(ordered);
 	}
 
@@ -2384,7 +2384,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	if (cur_offset < end) {
 		struct extent_state *cached = NULL;
 
-		lock_extent(&inode->io_tree, cur_offset, end, &cached);
+		btrfs_lock_extent(&inode->io_tree, cur_offset, end, &cached);
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
 					     locked_folio, &cached,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
@@ -2788,7 +2788,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 				     EXTENT_DELALLOC_NEW, cached_state);
 next:
 		search_start = extent_map_end(em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		if (ret)
 			return ret;
 	}
@@ -3096,7 +3096,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 	}
 
 	clear_bits |= EXTENT_LOCKED;
-	lock_extent(io_tree, start, end, &cached_state);
+	btrfs_lock_extent(io_tree, start, end, &cached_state);
 
 	if (freespace_inode)
 		trans = btrfs_join_transaction_spacecache(root);
@@ -4781,11 +4781,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	folio_wait_writeback(folio);
 
-	lock_extent(io_tree, block_start, block_end, &cached_state);
+	btrfs_lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
+		btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 		folio_unlock(folio);
 		folio_put(folio);
 		btrfs_start_ordered_extent(ordered);
@@ -4795,7 +4795,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 
 	ret = btrfs_reset_extent_delalloc(inode, block_start, block_end, 0, &cached_state);
 	if (ret) {
-		unlock_extent(io_tree, block_start, block_end, &cached_state);
+		btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -4814,7 +4814,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 				  block_end + 1 - block_start);
 	btrfs_folio_set_dirty(fs_info, folio, block_start,
 			      block_end + 1 - block_start);
-	unlock_extent(io_tree, block_start, block_end, &cached_state);
+	btrfs_unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
 		set_extent_bit(&inode->io_tree, block_start, block_end,
@@ -4961,7 +4961,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
 			ret = btrfs_replace_extent_map_range(inode, hole_em, true);
-			free_extent_map(hole_em);
+			btrfs_free_extent_map(hole_em);
 		} else {
 			ret = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
@@ -4969,14 +4969,14 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
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
-	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
+	btrfs_free_extent_map(em);
+	btrfs_unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
 	return ret;
 }
 
@@ -5110,7 +5110,7 @@ static int btrfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
  * While truncating the inode pages during eviction, we get the VFS
  * calling btrfs_invalidate_folio() against each folio of the inode. This
  * is slow because the calls to btrfs_invalidate_folio() result in a
- * huge amount of calls to lock_extent() and clear_extent_bit(),
+ * huge amount of calls to btrfs_lock_extent() and clear_extent_bit(),
  * which keep merging and splitting extent_state structures over and over,
  * wasting lots of time.
  *
@@ -5160,7 +5160,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		state_flags = state->state;
 		spin_unlock(&io_tree->lock);
 
-		lock_extent(io_tree, start, end, &cached_state);
+		btrfs_lock_extent(io_tree, start, end, &cached_state);
 
 		/*
 		 * If still has DELALLOC flag, the extent didn't reach disk,
@@ -6838,9 +6838,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 	if (em) {
 		if (em->start > start || em->start + em->len <= start)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else if (em->disk_bytenr == EXTENT_MAP_INLINE && folio)
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 		else
 			goto out;
 	}
@@ -6998,7 +6998,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	trace_btrfs_get_extent(root, inode, em);
 
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 	return em;
@@ -7127,7 +7127,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	return 1;
 }
 
-/* The callers of this must take lock_extent() */
+/* The callers of this must take btrfs_lock_extent() */
 struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 				      const struct btrfs_file_extent *file_extent,
 				      int type)
@@ -7189,11 +7189,11 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		return ERR_PTR(ret);
 	}
 
-	/* em got 2 refs now, callers needs to do free_extent_map once. */
+	/* em got 2 refs now, callers needs to do btrfs_free_extent_map once. */
 	return em;
 }
 
@@ -7320,7 +7320,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	}
 
 	if (!inode_evicting)
-		lock_extent(tree, page_start, page_end, &cached_state);
+		btrfs_lock_extent(tree, page_start, page_end, &cached_state);
 
 	cur = page_start;
 	while (cur < page_end) {
@@ -7526,7 +7526,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
-		lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
 		 * size is not block aligned since we will be keeping the last
@@ -7541,7 +7541,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		inode_sub_bytes(&inode->vfs_inode, control.sub_bytes);
 		btrfs_inode_safe_disk_i_size_write(inode, control.last_size);
 
-		unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
@@ -8879,7 +8879,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, true);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 next:
 		num_bytes -= ins.offset;
 		cur_offset += ins.offset;
@@ -9134,7 +9134,7 @@ static ssize_t btrfs_encoded_read_inline(
 	}
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
-	unlock_extent(io_tree, start, lockend, cached_state);
+	btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -9255,7 +9255,7 @@ ssize_t btrfs_encoded_read_regular(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out;
 
-	unlock_extent(io_tree, start, lockend, cached_state);
+	btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	*unlocked = true;
 
@@ -9326,13 +9326,13 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 					       lockend - start + 1);
 		if (ret)
 			goto out_unlock_inode;
-		lock_extent(io_tree, start, lockend, cached_state);
+		btrfs_lock_extent(io_tree, start, lockend, cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     lockend - start + 1);
 		if (!ordered)
 			break;
 		btrfs_put_ordered_extent(ordered);
-		unlock_extent(io_tree, start, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 		cond_resched();
 	}
 
@@ -9349,7 +9349,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		 * For inline extents we get everything we need out of the
 		 * extent item.
 		 */
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 		em = NULL;
 		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
 						cached_state, extent_start,
@@ -9402,11 +9402,11 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		encoded->unencoded_len = count;
 		*disk_io_size = ALIGN(*disk_io_size, fs_info->sectorsize);
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	em = NULL;
 
 	if (*disk_bytenr == EXTENT_MAP_HOLE) {
-		unlock_extent(io_tree, start, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		unlocked = true;
 		ret = iov_iter_zero(count, iter);
@@ -9421,11 +9421,11 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret >= 0)
 		iocb->ki_pos += encoded->len;
 out_em:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out_unlock_extent:
 	/* Leave inode and extent locked if we need to do a read. */
 	if (!unlocked && ret != -EIOCBQUEUED)
-		unlock_extent(io_tree, start, lockend, cached_state);
+		btrfs_unlock_extent(io_tree, start, lockend, cached_state);
 out_unlock_inode:
 	if (!unlocked && ret != -EIOCBQUEUED)
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
@@ -9572,14 +9572,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 						    end >> PAGE_SHIFT);
 		if (ret)
 			goto out_folios;
-		lock_extent(io_tree, start, end, &cached_state);
+		btrfs_lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
 		    !filemap_range_has_page(inode->vfs_inode.i_mapping, start, end))
 			break;
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
-		unlock_extent(io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(io_tree, start, end, &cached_state);
 		cond_resched();
 	}
 
@@ -9629,7 +9629,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
 				       (1U << BTRFS_ORDERED_ENCODED) |
@@ -9644,7 +9644,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start + encoded->len > inode->vfs_inode.i_size)
 		i_size_write(&inode->vfs_inode, start + encoded->len);
 
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
@@ -9669,7 +9669,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (!extent_reserved)
 		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
 out_unlock:
-	unlock_extent(io_tree, start, end, &cached_state);
+	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
 		if (folios[i])
@@ -9935,7 +9935,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
-	lock_extent(io_tree, 0, isize - 1, &cached_state);
+	btrfs_lock_extent(io_tree, 0, isize - 1, &cached_state);
 	while (prev_extent_end < isize) {
 		struct btrfs_key key;
 		struct extent_buffer *leaf;
@@ -10113,7 +10113,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!IS_ERR_OR_NULL(map))
 		btrfs_free_chunk_map(map);
 
-	unlock_extent(io_tree, 0, isize - 1, &cached_state);
+	btrfs_unlock_extent(io_tree, 0, isize - 1, &cached_state);
 
 	if (ret)
 		btrfs_swap_deactivate(file);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b6152b36f81ec..ba34af1efdeda 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4627,7 +4627,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 						 args.compression, &unlocked);
 
 		if (!unlocked) {
-			unlock_extent(io_tree, start, lockend, &cached_state);
+			btrfs_unlock_extent(io_tree, start, lockend, &cached_state);
 			btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 		}
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 692f03803da9e..2c448e4ef0484 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1160,7 +1160,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 		cachedp = cached_state;
 
 	while (1) {
-		lock_extent(&inode->io_tree, start, end, cachedp);
+		btrfs_lock_extent(&inode->io_tree, start, end, cachedp);
 		ordered = btrfs_lookup_ordered_range(inode, start,
 						     end - start + 1);
 		if (!ordered) {
@@ -1173,7 +1173,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 				refcount_dec(&cache->refs);
 			break;
 		}
-		unlock_extent(&inode->io_tree, start, end, cachedp);
+		btrfs_unlock_extent(&inode->io_tree, start, end, cachedp);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 	}
@@ -1191,7 +1191,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	struct btrfs_ordered_extent *ordered;
 
-	if (!try_lock_extent(&inode->io_tree, start, end, cached_state))
+	if (!btrfs_try_lock_extent(&inode->io_tree, start, end, cached_state))
 		return false;
 
 	ordered = btrfs_lookup_ordered_range(inode, start, end - start + 1);
@@ -1199,7 +1199,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 		return true;
 
 	btrfs_put_ordered_extent(ordered);
-	unlock_extent(&inode->io_tree, start, end, cached_state);
+	btrfs_unlock_extent(&inode->io_tree, start, end, cached_state);
 
 	return false;
 }
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 08e84c1eb47fa..74aa18155edd8 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -701,9 +701,9 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	 * because we have already locked the inode's i_mmap_lock in exclusive
 	 * mode.
 	 */
-	lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
+	btrfs_lock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
-	unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(dst)->io_tree, dst_loff, end, &cached_state);
 
 	btrfs_btree_balance_dirty(fs_info);
 
@@ -802,9 +802,9 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	 * mode.
 	 */
 	end = destoff + len - 1;
-	lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
+	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
-	unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
+	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
 
 	/*
 	 * We may have copied an inline extent into a page of the destination
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8130bfd1abbf2..d4573ae98e883 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1025,7 +1025,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				/* Take mmap lock to serialize with reflinks. */
 				if (!down_read_trylock(&inode->i_mmap_lock))
 					continue;
-				ret = try_lock_extent(&inode->io_tree, key.offset,
+				ret = btrfs_try_lock_extent(&inode->io_tree, key.offset,
 						      end, &cached_state);
 				if (!ret) {
 					up_read(&inode->i_mmap_lock);
@@ -1033,7 +1033,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				}
 
 				btrfs_drop_extent_map_range(inode, key.offset, end, true);
-				unlock_extent(&inode->io_tree, key.offset, end,
+				btrfs_unlock_extent(&inode->io_tree, key.offset, end,
 					      &cached_state);
 				up_read(&inode->i_mmap_lock);
 			}
@@ -1497,10 +1497,10 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 			end = (u64)-1;
 		}
 
-		/* the lock_extent waits for read_folio to complete */
-		lock_extent(&inode->io_tree, start, end, &cached_state);
+		/* the btrfs_lock_extent waits for read_folio to complete */
+		btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 		btrfs_drop_extent_map_range(inode, start, end, true);
-		unlock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 	}
 	return 0;
 }
@@ -2850,13 +2850,13 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 		else
 			end = cluster->end - offset;
 
-		lock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 		num_bytes = end + 1 - start;
 		ret = btrfs_prealloc_file_range(&inode->vfs_inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
 		cur_offset = end + 1;
-		unlock_extent(&inode->io_tree, start, end, &cached_state);
+		btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
 		if (ret)
 			break;
 	}
@@ -2889,10 +2889,10 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct reloc_contr
 	em->ram_bytes = em->len;
 	em->flags |= EXTENT_FLAG_PINNED;
 
-	lock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_lock_extent(&inode->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(inode, em, false);
-	unlock_extent(&inode->io_tree, start, end, &cached_state);
-	free_extent_map(em);
+	btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);
+	btrfs_free_extent_map(em);
 
 	return ret;
 }
@@ -3014,7 +3014,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 			goto release_folio;
 
 		/* Mark the range delalloc and dirty for later writeback */
-		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
+		btrfs_lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
 			    &cached_state);
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
 						clamped_end, 0, &cached_state);
@@ -3048,7 +3048,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 				       boundary_start, boundary_end,
 				       EXTENT_BOUNDARY, NULL);
 		}
-		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
+		btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
 			      &cached_state);
 		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
 		cur += clamped_len;
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index de226209220fe..acef895eebe27 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -191,7 +191,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 			sectorsize - 1, start, end);
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 	unlock_page(locked_page);
 	put_page(locked_page);
 
@@ -227,7 +227,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("there were unlocked pages in the range");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 	/* locked_page was unlocked above */
 	put_page(locked_page);
 
@@ -282,7 +282,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 		test_err("pages in range were not all locked");
 		goto out_bits;
 	}
-	unlock_extent(tmp, start, end, NULL);
+	btrfs_unlock_extent(tmp, start, end, NULL);
 
 	/*
 	 * Now to test where we run into a page that is no longer dirty in the
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 609bb6c9c0873..63b2522b093ac 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -36,7 +36,7 @@ static int free_extent_map_tree(struct btrfs_inode *inode)
 			refcount_set(&em->refs, 1);
 		}
 #endif
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	write_unlock(&em_tree->lock);
 
@@ -87,7 +87,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [0, 16K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [16K, 20K) following [0, 16K)  */
 	em = alloc_extent_map();
@@ -109,7 +109,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [16K, 20K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -145,7 +145,7 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -186,7 +186,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [0, 1K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Add [4K, 8K) following [0, 1K)  */
 	em = alloc_extent_map();
@@ -208,7 +208,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -242,7 +242,7 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 			 ret, em->start, em->len, em->disk_bytenr);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -279,7 +279,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -320,7 +320,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -388,7 +388,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [0, 8K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -410,7 +410,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 		test_err("cannot add extent range [8K, 32K)");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -445,7 +445,7 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 			 em->disk_bytenr, em->disk_num_bytes);
 		ret = -EINVAL;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 out:
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
@@ -513,7 +513,7 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("cannot add extent map [%llu, %llu)", start, start + len);
 		return ret;
@@ -751,7 +751,7 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 	ret = 0;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	ret2 = free_extent_map_tree(inode);
 	if (ret == 0)
 		ret = ret2;
@@ -793,7 +793,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("couldn't add extent map");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = alloc_extent_map();
 	if (!em) {
@@ -815,7 +815,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		test_err("couldn't add extent map");
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/*
 	 * Drop [0, 36K) This should skip the [0, 4K) extent and then split the
@@ -842,7 +842,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
@@ -876,7 +876,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 		goto out;
 	}
 
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
@@ -888,7 +888,7 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	ret = 0;
 out:
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	/* Unpin our extent to prevent warning when removing it below. */
 	ret2 = unpin_extent_cache(inode, 0, SZ_16K, 0);
 	if (ret == 0)
@@ -928,7 +928,7 @@ static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, em->start, em->len);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("couldn't add extent map for range [120K, 128K)");
 		goto out;
@@ -967,7 +967,7 @@ static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K);
 	write_unlock(&em_tree->lock);
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	if (ret < 0) {
 		test_err("couldn't add extent map for range [108K, 144K)");
 		goto out;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 3ea3bc2225fe8..1de8eb84772a5 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -268,7 +268,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("expected a hole, got %llu", em->disk_bytenr);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
 
 	/*
@@ -314,7 +314,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 * this?
 	 */
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -336,7 +336,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Regular extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -363,7 +363,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are split extents */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -392,7 +392,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -414,7 +414,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -447,7 +447,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -475,7 +475,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -505,7 +505,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -537,7 +537,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -570,7 +570,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Now for the compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -603,7 +603,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* Split compressed extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
@@ -638,7 +638,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	disk_bytenr = extent_map_block_start(em);
 	orig_start = em->start;
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -664,7 +664,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -698,7 +698,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
@@ -725,7 +725,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
 	if (IS_ERR(em)) {
@@ -757,7 +757,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 	offset = em->start + em->len;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
@@ -785,7 +785,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
@@ -858,7 +858,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 			 em->flags);
 		goto out;
 	}
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
@@ -883,7 +883,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (!IS_ERR(em))
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 28dcf8a8997b5..345bec62a6527 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4407,7 +4407,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	 * file which happens to refer to the same extent as well. Such races
 	 * can leave checksum items in the log with overlapping ranges.
 	 */
-	ret = lock_extent(&log_root->log_csum_range, sums->logical, lock_end,
+	ret = btrfs_lock_extent(&log_root->log_csum_range, sums->logical, lock_end,
 			  &cached_state);
 	if (ret)
 		return ret;
@@ -4424,7 +4424,7 @@ static int log_csums(struct btrfs_trans_handle *trans,
 	if (!ret)
 		ret = btrfs_csum_file_blocks(trans, log_root, sums);
 
-	unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
+	btrfs_unlock_extent(&log_root->log_csum_range, sums->logical, lock_end,
 		      &cached_state);
 
 	return ret;
@@ -5066,7 +5066,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(inode, em);
-			free_extent_map(em);
+			btrfs_free_extent_map(em);
 			continue;
 		}
 
@@ -5075,7 +5075,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(inode, em);
-		free_extent_map(em);
+		btrfs_free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 46a792e113ee4..b76d382b1fd76 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2033,7 +2033,7 @@ static void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered,
 	/* The em should be a new COW extent, thus it should not have an offset. */
 	ASSERT(em->offset == 0);
 	em->disk_bytenr = logical;
-	free_extent_map(em);
+	btrfs_free_extent_map(em);
 	write_unlock(&em_tree->lock);
 }
 
-- 
2.53.0

