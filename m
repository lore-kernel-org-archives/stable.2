Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB92D8376
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566272; cv=none; b=l4V2L468ZktGUo5bepCKsnP412wrEjkWy6x+wmy/WSoCY+YlmiblWCSLbt/o0eFSeOZ9cd+WKPdjXj4hsu/LAAb5APRsZ4pF0pD2+X4MAt11IvHM9GwQ6SlR/8TkqxYgwwVm5jISfjtE2xuBghpc+BQvwUOg+/SXc0rwj7bh8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566272; c=relaxed/simple;
	bh=qlWAXjGnToWOPE26IqPz2Niz1Xl+VrrlcwpDASIj0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bovwpwGX7een7eO/SlflSUSh20bbs4RDg+s3kIM0gBgDJb/9GqcT962TMxVaaCKgPv2u+S3BAf9dh8nwz+9GEbcGSHrS4i/JLHTM/XS4lQ/YB3Cw3q9ayycHr/U7QWeVG22Gae9crKi5qaRkJOvyBPS2tQ7oZ0xXgTVymPWBWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN9+cWh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN9+cWh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ACB1F000E9;
	Mon, 20 Jul 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566270;
	bh=AnkSGG7cMwaEg+pQouZatMtzONG6nPOi6EEZ3dEiUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KN9+cWh/wVrx/9x15bfjGGwtPn2vhUVcp/mOB5/0+QhQ+yAKfQQmRzswNkjzKdyme
	 EijuGbLO49eGqaXMLySAw92MfGbG33vzalWb4JrS51E/Ko10C9PEFDH3ptdOTgukuW
	 lSYm1Vm+r3XOCM0UpdOdnbrVidFMs9FPZfpd11BdDyiMVnyTRJ2dY72U9TAaq1kSuQ
	 lKB9GTkxGpPlXiEzKKQE11hbVnHF+Kjh+ca0hiVFUubsFfztDscNHLWZzU8FSL2xW9
	 5/B2DEH1n6pPdcl5bYKL4ZVYtyFmoERqrTqZhzvBFkrje1EwUrpU74JsUCTwSaQvGY
	 dz63SA70w+vCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] btrfs: remove folio parameter from ordered io related functions
Date: Mon, 20 Jul 2026 12:51:06 -0400
Message-ID: <20260720165108.2526667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071522-pogo-deflector-3286@gregkh>
References: <2026071522-pogo-deflector-3286@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit a11d6912fdd9e57aff889ec97256b1d6b4e5bf06 ]

Both functions btrfs_finish_ordered_extent() and
btrfs_mark_ordered_io_finished() are accepting an optional folio
parameter.

That @folio is passed into can_finish_ordered_extent(), which later will
test and clear the ordered flag for the involved range.

However I do not think there is any other call site that can clear
ordered flags of an page cache folio and can affect
can_finish_ordered_extent().

There are limited *_clear_ordered() callers out of
can_finish_ordered_extent() function:

- btrfs_migrate_folio()
  This is completely unrelated, it's just migrating the ordered flag to
  the new folio.

- btrfs_cleanup_ordered_extents()
  We manually clean the ordered flags of all involved folios, then call
  btrfs_mark_ordered_io_finished() without a @folio parameter.
  So it doesn't need and didn't pass a @folio parameter in the first
  place.

- btrfs_writepage_fixup_worker()
  This function is going to be removed soon, and we should not hit that
  function anymore.

- btrfs_invalidate_folio()
  This is the real call site we need to bother with.

  If we already have a bio running, btrfs_finish_ordered_extent() in
  end_bbio_data_write() will be executed first, as
  btrfs_invalidate_folio() will wait for the writeback to finish.

  Thus if there is a running bio, it will not see the range has
  ordered flags, and just skip to the next range.

  If there is no bio running, meaning the ordered extent is created but
  the folio is not yet submitted.

  In that case btrfs_invalidate_folio() will manually clear the folio
  ordered range, but then manually finish the ordered extent with
  btrfs_dec_test_ordered_pending() without bothering the folio ordered
  flags.

  Meaning if the OE range with folio ordered flags will be finished
  manually without the need to call can_finish_ordered_extent().

This means all can_finish_ordered_extent() call sites should get a range
that has folio ordered flag set, thus the old "return false" branch
should never be triggered.

Now we can:

- Remove the @folio parameter from involved functions
  * btrfs_mark_ordered_io_finished()
  * btrfs_finish_ordered_extent()

  For call sites passing a @folio into those functions, let them
  manually clear the ordered flag of involved folios.

- Move btrfs_finish_ordered_extent() out of the loop in
  end_bbio_data_write()

  We only need to call btrfs_finish_ordered_extent() once per bbio,
  not per folio.

- Add an ASSERT() to make sure all folio ranges have ordered flags
  It's only for end_bbio_data_write().

  And we already have enough safe nets to catch over-accounting of ordered
  extents.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 95ee2231896d ("btrfs: check and set EXTENT_DELALLOC_NEW before clearing EXTENT_DELALLOC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/compression.c  |  2 +-
 fs/btrfs/direct-io.c    |  9 ++++-----
 fs/btrfs/extent_io.c    | 30 ++++++++++++++++++++----------
 fs/btrfs/inode.c        |  6 ++++--
 fs/btrfs/ordered-data.c | 29 +++++------------------------
 fs/btrfs/ordered-data.h |  6 ++----
 6 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 65d883da86c60b..7bd5e7ff97f232 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -316,7 +316,7 @@ static void btrfs_finish_compressed_write_work(struct work_struct *work)
 	struct compressed_bio *cb =
 		container_of(work, struct compressed_bio, write_end_work);
 
-	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->len,
+	btrfs_finish_ordered_extent(cb->bbio.ordered, cb->start, cb->len,
 				    cb->bbio.bio.bi_status == BLK_STS_OK);
 
 	if (cb->writeback)
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 8ce58aa4189f2c..fae5e005da45a5 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -624,7 +624,7 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write)
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+			btrfs_finish_ordered_extent(dio_data->ordered,
 						    pos, length, false);
 		else
 			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
@@ -656,9 +656,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
-					    !bio->bi_status);
+		btrfs_finish_ordered_extent(bbio->ordered, dip->file_offset,
+					    dip->bytes, !bio->bi_status);
 	} else {
 		unlock_dio_extent(&inode->io_tree, dip->file_offset,
 				  dip->file_offset + dip->bytes - 1, NULL);
@@ -736,7 +735,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 
 		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
 		if (ret) {
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+			btrfs_finish_ordered_extent(dio_data->ordered,
 						    file_offset, dip->bytes,
 						    !ret);
 			bio->bi_status = errno_to_blk_status(ret);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0d50f3063d346d..5af9974559c10d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -485,6 +485,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
 	const u32 sectorsize = fs_info->sectorsize;
+	u32 bio_size = 0;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, bio) {
@@ -495,6 +496,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		/* Only order 0 (single page) folios are allowed for data. */
 		ASSERT(folio_order(folio) == 0);
 
+		bio_size += len;
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
@@ -505,13 +507,15 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		"incomplete page write with offset %zu and length %zu",
 				   fi.offset, fi.length);
 
-		btrfs_finish_ordered_extent(bbio->ordered, folio, start, len,
-					    !error);
 		if (error)
 			mapping_set_error(folio->mapping, error);
+
+		ASSERT(btrfs_folio_test_ordered(fs_info, folio, start, len));
+		btrfs_folio_clear_ordered(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
 
+	btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, bio_size, !error);
 	bio_put(bio);
 }
 
@@ -1376,10 +1380,14 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 				fs_info->sectorsize_bits,
 				blocks_per_folio);
 
-		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
-			btrfs_mark_ordered_io_finished(inode, folio,
-				page_start + (bit << fs_info->sectorsize_bits),
+		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size) {
+			u64 start = page_start + (bit << fs_info->sectorsize_bits);
+
+			btrfs_folio_clear_ordered(fs_info, folio, start,
+						  fs_info->sectorsize);
+			btrfs_mark_ordered_io_finished(inode, start,
 				fs_info->sectorsize, false);
+		}
 		return ret;
 	}
 out:
@@ -1544,8 +1552,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 			btrfs_put_ordered_extent(ordered);
 
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       fs_info->sectorsize, true);
+			btrfs_folio_clear_ordered(fs_info, folio, cur, fs_info->sectorsize);
+			btrfs_mark_ordered_io_finished(inode, cur, fs_info->sectorsize, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1570,7 +1578,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * Since there is no bio submitted to finish the ordered
 			 * extent, we have to manually finish this sector.
 			 */
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
+			btrfs_folio_clear_ordered(fs_info, folio, cur,
+						  fs_info->sectorsize);
+			btrfs_mark_ordered_io_finished(inode, cur,
 						       fs_info->sectorsize, false);
 			if (!found_error)
 				found_error = ret;
@@ -2399,8 +2409,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		 * code is just in case, but shouldn't actually be run.
 		 */
 		if (IS_ERR(folio)) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       cur, cur_len, false);
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), cur,
+						       cur_len, false);
 			mapping_set_error(mapping, PTR_ERR(folio));
 			cur = cur_end + 1;
 			continue;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c79dd6ff03dc14..3f5312b1823afb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -456,7 +456,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		}
 	}
 
-	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes, false);
+	return btrfs_mark_ordered_io_finished(inode, offset, bytes, false);
 }
 
 static int btrfs_dirty_inode(struct btrfs_inode *inode);
@@ -2937,7 +2937,9 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(folio->mapping, ret);
-		btrfs_mark_ordered_io_finished(inode, folio, page_start,
+		btrfs_folio_clear_ordered(fs_info, folio, page_start,
+					  folio_size(folio));
+		btrfs_mark_ordered_io_finished(inode, page_start,
 					       folio_size(folio), !ret);
 		folio_clear_dirty_for_io(folio);
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6ac254a5290732..c7901fb167db79 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -338,30 +338,13 @@ static void finish_ordered_fn(struct btrfs_work *work)
 }
 
 static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				      struct folio *folio, u64 file_offset,
-				      u64 len, bool uptodate)
+				      u64 file_offset, u64 len, bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	lockdep_assert_held(&inode->ordered_tree_lock);
 
-	if (folio) {
-		ASSERT(folio->mapping);
-		ASSERT(folio_pos(folio) <= file_offset);
-		ASSERT(file_offset + len <= folio_pos(folio) + folio_size(folio));
-
-		/*
-		 * Ordered (Private2) bit indicates whether we still have
-		 * pending io unfinished for the ordered extent.
-		 *
-		 * If there's no such bit, we need to skip to next range.
-		 */
-		if (!btrfs_folio_test_ordered(fs_info, folio, file_offset, len))
-			return false;
-		btrfs_folio_clear_ordered(fs_info, folio, file_offset, len);
-	}
-
 	/* Now we're fine to update the accounting. */
 	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
 		btrfs_crit(fs_info,
@@ -403,8 +386,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 }
 
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct folio *folio, u64 file_offset, u64 len,
-				 bool uptodate)
+				 u64 file_offset, u64 len, bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
 	unsigned long flags;
@@ -413,7 +395,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
 	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
-	ret = can_finish_ordered_extent(ordered, folio, file_offset, len,
+	ret = can_finish_ordered_extent(ordered, file_offset, len,
 					uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
@@ -466,8 +448,7 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
  * extent(s) covering it.
  */
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				    struct folio *folio, u64 file_offset,
-				    u64 num_bytes, bool uptodate)
+				    u64 file_offset, u64 num_bytes, bool uptodate)
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
@@ -530,7 +511,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(end + 1 - cur < U32_MAX);
 		len = end + 1 - cur;
 
-		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
+		if (can_finish_ordered_extent(entry, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 			btrfs_queue_ordered_fn(entry);
 			spin_lock_irqsave(&inode->ordered_tree_lock, flags);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 4e152736d06cbd..cbfac6044dfb6a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -163,11 +163,9 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct folio *folio, u64 file_offset, u64 len,
-				 bool uptodate);
+				 u64 file_offset, u64 len, bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				    struct folio *folio, u64 file_offset,
-				    u64 num_bytes, bool uptodate);
+				    u64 file_offset, u64 num_bytes, bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
-- 
2.53.0

