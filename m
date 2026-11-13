Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578703;
	b=1dEOjeyuFS2esNzbG0bBwACU8LMJfkRuc6MOWOR7pSIX46ejMkcIJr0Id1rTa6btwTf+
	 jo+gemix3yV8N7Z5RK8gUx4X98Y4+9Wfii4MInnRmbN0KssFLg4m/5ty4DNcjeti2/TyO
	 hm5cE6GXnx2+HZZlRBu7MHeNNpHGeKG1c3aGil6aTBmqniX/DS1JAoBC5AxcbZRwAJUqb
	 EOJoW7YgOleu8rTIs93n/kZjZgA4iuk6mYXQQSaMWAzSNG66novCTkNWpb3YdIEnjzogH
	 lIo0OIABbHcPztsUuuVnFED0MB6ThMXLyrYvFPyxKcQ7TaI9er+DGQ3PnJogYF6IaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3SJ6jlHevLb8f+vzUSMjghyh91T9ryOrPPzYS/YN2RA=;
	b=c+Qx/psTOjpTE5psDNCXeSlUkcfsOSYweX4e97F6RbLCZSEGgsCKp+cn7oZFEnVQ5b3t
	 42cWUjZ4BDZK3SbM++YMwCT+jh4QIY+dABFd/uyLD9hzgEEhirJkKwyDC1AVh4GSYv9RI
	 l+XC9Rj90mGQQlW7cmCFMtBcO9qltZDPYK4ngsS1E+844z2g/RMlfdgZq3bmOU6oEQdhk
	 94UBzciVGXqmnrtsN14pTO0iKI8abUwAr/Ut2sRdv9vGP58ZVMmh52mw5EtElzT2GGyXV
	 DAj0FIezTkZILMXbt57BATXEqFeiyTb64a0sVXqwt/T7jPVujQjmLjUFG4t2Bc7DMCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/qabVby";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FF606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/qabVby
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B1F1F000C4;
	Fri, 13 Nov 2026 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578703;
	bh=3SJ6jlHevLb8f+vzUSMjghyh91T9ryOrPPzYS/YN2RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/qabVbyVLtSoLrEpwHfR5oU0XgDgvhyKQnEV87GSyvIKwkysKw+SjBlMwM5efehp
	 CXh45fLj07q7IXFT0qTtt46N74E341uZ0Dpuzj6jNG8d5MS7czvSuydGJ2u8Moqd/g
	 0wj6faLs9qkVq6OqpvtttUyzdV8CS66fhDkcFGvPk97u4ns1oNwClgmfiiu+zxoCko
	 /E25611x4W0mvmijAkPxy6ak3wRsmymyo2HgM/kNWXR+gMRKMFKjpmboHE4gq6O4kV
	 HnMbq966GilFxkZI91EoXO3xOgCA4O3LlQV8P78MOqPY6vg5Jafh1EBvHPt4T7uFRj
	 2dsHzYSDd3P4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/5] btrfs: replace btrfs_repair_io_failure() to use bio for page iteration
Date: Fri, 13 Nov 2026 09:04:57 -0500
Message-ID: <20261113135926.1497314-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050424-failed-7.3-d00b85308abe@kernel.org>
References: <20261107050424-failed-7.3-d00b85308abe@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 15ed4a938b30fcb72e96187f36e2c4ff0e6e2227 ]

Currently btrfs_repair_io_failure() uses a @paddrs[] array to iterate
pages.

Such a parameter is required for bs > ps cases, as one fs block crosses
several pages.

However there is a much simpler and existing way to iterate pages: bio
and bvec_iter.

This changes btrfs_repair_io_failure() by:

- Use a const @bvec_iter pointer to locate where the pages are
- Extract file offset/logical from the @bbio
- Require no @step parameter
  Above features allow us to shorten the parameter list.

- Rename the function to btrfs_repair_bbio_failure()

- Change the caller in btrfs_repair_eb_io_failure() to allocate a bbio
  Unlike the data read path, we do not have a handy bbio in that case.
  So we need to allocate one just for btrfs_repair_bbio_failure().

- Change the error reporting in btrfs_repair_bbio_failure() to include
  root id and use inode number directly
  Now for btree inode we will report a proper inode number (1).

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: d00b85308abe ("btrfs: raid56: do not verify the content if there is no data checksum")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c     | 61 ++++++++++++++++++++++++++--------------------
 fs/btrfs/bio.h     |  5 ++--
 fs/btrfs/disk-io.c | 25 +++++++++++++------
 3 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cc0bd03048bae..f8d4c2d550073 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -186,7 +186,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	 */
 	struct bvec_iter saved_iter = repair_bbio->saved_iter;
 	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
-	const u64 logical = repair_bbio->saved_iter.bi_sector << SECTOR_SHIFT;
 	const u32 nr_steps = repair_bbio->saved_iter.bi_size / step;
 	int mirror = repair_bbio->mirror_num;
 	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
@@ -220,9 +219,8 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 
 	do {
 		mirror = prev_repair_mirror(fbio, mirror);
-		btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
-				  repair_bbio->file_offset, fs_info->sectorsize,
-				  logical, paddrs, step, mirror);
+		btrfs_repair_bbio_failure(repair_bbio, &repair_bbio->saved_iter,
+					  fs_info->sectorsize, mirror);
 	} while (mirror != fbio->bbio->mirror_num);
 
 done:
@@ -925,21 +923,23 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
  * The I/O is issued synchronously to block the repair read completion from
  * freeing the bio.
  *
- * @ino:	Offending inode number
- * @fileoff:	File offset inside the inode
+ * @bbio:	Original bbio where the repair is needed
+ * @orig_iter:	Points to where the repair start is
  * @length:	Length of the repair write
- * @logical:	Logical address of the range
- * @paddrs:	Physical address array of the content
- * @step:	Length of for each paddrs
  * @mirror_num: Mirror number to write to. Must not be zero
  */
-int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
-			    u32 length, u64 logical, const phys_addr_t paddrs[],
-			    unsigned int step, int mirror_num)
+int btrfs_repair_bbio_failure(struct btrfs_bio *bbio, const struct bvec_iter *orig_iter,
+			      u32 length, int mirror_num)
 {
-	const u32 nr_steps = DIV_ROUND_UP_POW2(length, step);
+	struct btrfs_inode *inode = bbio->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_io_stripe smap = { 0 };
-	struct bio *bio = NULL;
+	struct bvec_iter iter = *orig_iter;
+	struct bio *repair_bio = NULL;
+	const u64 logical = iter.bi_sector << SECTOR_SHIFT;
+	const u64 fileoff = bbio->file_offset +
+			    ((iter.bi_sector - bbio->saved_iter.bi_sector) << SECTOR_SHIFT);
+	u32 cur = 0;
 	int ret = 0;
 
 	BUG_ON(!mirror_num);
@@ -950,8 +950,9 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	ASSERT(IS_ALIGNED(fileoff, fs_info->sectorsize));
 	/* Either it's a single data or metadata block. */
 	ASSERT(length <= BTRFS_MAX_BLOCKSIZE);
-	ASSERT(step <= length);
-	ASSERT(is_power_of_2(step));
+
+	/* Our current iter should not be before the original bbio saved_iter. */
+	ASSERT(iter.bi_sector >= bbio->saved_iter.bi_sector);
 
 	/*
 	 * The fs either mounted RO or hit critical errors, no need
@@ -979,15 +980,22 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 		goto out_counter_dec;
 	}
 
-	bio = bio_alloc(smap.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
-	bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-	for (int i = 0; i < nr_steps; i++) {
-		ret = bio_add_page(bio, phys_to_page(paddrs[i]), step, offset_in_page(paddrs[i]));
-		/* We should have allocated enough slots to contain all the different pages. */
-		ASSERT(ret == step);
+	repair_bio = bio_alloc(smap.dev->bdev, max(1, length >> PAGE_SHIFT),
+			       REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
+	repair_bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
+	while (cur < length) {
+		struct page *page = bio_iter_page(&bbio->bio, iter);
+		const u32 pg_off = bio_iter_offset(&bbio->bio, iter);
+		const u32 cur_len = min(bio_iter_len(&bbio->bio, iter), length - cur);
+
+		ret = bio_add_page(repair_bio, page, cur_len, pg_off);
+		ASSERT(ret == cur_len);
+		bio_advance_iter_single(&bbio->bio, &iter, cur_len);
+		cur += cur_len;
 	}
-	ret = submit_bio_wait(bio);
-	bio_put(bio);
+
+	ret = submit_bio_wait(repair_bio);
+	bio_put(repair_bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
 		btrfs_dev_stat_inc_and_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
@@ -995,8 +1003,9 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	}
 
 	btrfs_info_rl(fs_info,
-		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-			     ino, fileoff, btrfs_dev_name(smap.dev),
+		"read error corrected: root %llu ino %llu off %llu (dev %s sector %llu)",
+			     btrfs_root_id(inode->root), btrfs_ino(inode), fileoff,
+			     btrfs_dev_name(smap.dev),
 			     smap.physical >> SECTOR_SHIFT);
 	ret = 0;
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 303ed6c7103d9..b7bd377a01624 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -126,8 +126,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
 void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace);
-int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
-			    u32 length, u64 logical, const phys_addr_t paddrs[],
-			    unsigned int step, int mirror_num);
+int btrfs_repair_bbio_failure(struct btrfs_bio *bbio, const struct bvec_iter *orig_iter,
+			      u32 length, int mirror_num);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc7ad92876c0b..0f3e8e74b7682 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -176,19 +176,24 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	const u32 step = min(fs_info->nodesize, PAGE_SIZE);
-	const u32 nr_steps = eb->len / step;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
+	struct btrfs_bio *bbio;
+	int ret;
 
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
+	/*
+	 * This bbio is only to queue all pages for btrfs_repair_bbio_failure().
+	 * Thus it will never get its endio called.
+	 */
+	bbio = btrfs_bio_alloc(max(1, fs_info->nodesize >> PAGE_SHIFT), REQ_OP_READ,
+			       BTRFS_I(fs_info->btree_inode), eb->start, NULL, NULL);
+	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
 	for (int i = 0; i < num_extent_pages(eb); i++) {
 		struct folio *folio = eb->folios[i];
 
 		/* No large folio support yet. */
 		ASSERT(folio_order(folio) == 0);
-		ASSERT(i < nr_steps);
 
 		/*
 		 * For nodesize < page size, there is just one paddr, with some
@@ -197,11 +202,17 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		 * For nodesize >= page size, it's one or more paddrs, and eb->start
 		 * must be aligned to page boundary.
 		 */
-		paddrs[i] = page_to_phys(&folio->page) + offset_in_page(eb->start);
+		ret = bio_add_page(&bbio->bio, &folio->page, min(PAGE_SIZE, fs_info->nodesize),
+				   offset_in_page(eb->start));
+		ASSERT(ret == min(PAGE_SIZE, fs_info->nodesize));
 	}
+	/* Since the bbio is never submitted, we have to save the iter manually. */
+	bbio->saved_iter = bbio->bio.bi_iter;
 
-	return btrfs_repair_io_failure(fs_info, 0, eb->start, eb->len,
-				       eb->start, paddrs, step, mirror_num);
+	ret = btrfs_repair_bbio_failure(bbio, &bbio->saved_iter, fs_info->nodesize,
+					mirror_num);
+	bio_put(&bbio->bio);
+	return ret;
 }
 
 /*
-- 
2.53.0

