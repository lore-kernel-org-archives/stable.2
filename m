Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578704;
	b=GAHNztrEJjCaWo4Y2n2yelRPyG85nT9SDsjcKu4lWS8jb5Xj0CADzfoj86F1cghiL3J6
	 YIUlNUQCJzo88o6Mpw6DPFcU5hjDsD+z4ajVv9SP4JJ7g1N2WoCsI11D2LXBagaO4Q7+p
	 DNYij4U425M5nEzMqbtsBsUS8HFjpTvGOAykMQbSlrl+eLjP/FcK+hb2LECsXiHNEiSO6
	 nTnZd8ABdnIqRidCBteUSmuezRJRvFuynFEIqMOWGFI9dNAwcCh6n1m4pIyJXwiAhyc6/
	 8nz7C0vOtm79yF85c3akHDGdRJsOoZaCNM7uz/h9hgsU5U930sms3zz2Y/ytyodBBaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LI/XbCRGCKEshqe8SziMiE2Kvw2sKLDM5+xU8FeZ1u4=;
	b=YQvjJybXFDfkEKBgJdQgx0XBYyckRghfOMWgkZbWJKRatQxZ8A6rlsF9a7Mo+AkDzxVn
	 U80+pGVQg1FLG+ARfyIk4+ShhZBuD2sDr9hsZO6kVHh/m/5JIDe5iU0ueHnvx0vjH/SQA
	 PkO+ATchDKZWkW8qQSH2tBVFHONqLViBPRHhRE9rDdAsE5nQdLa2BdFt3mDZQqyvuCn8s
	 1VMX2H+3BwZffomGO1QOl+hSzs9OQXSacsIOL0Ua0ROtIU94pGs3Bgn/GCiRAfoTKPUuv
	 XlIDgU7dNU2ksRsm6WckrQ0UTjLP1Etw1jFHSW2wWLq4zlBqQPB8OA7K6xSlkjNRggA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYO9izgP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA49606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYO9izgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB01F000C5;
	Fri, 13 Nov 2026 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578704;
	bh=LI/XbCRGCKEshqe8SziMiE2Kvw2sKLDM5+xU8FeZ1u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dYO9izgPBiBAbn3c+5q+S2sxXKTEYYQFmaLdVdJ1K5K3HYqFc1XHnB3UiISHTTIoq
	 1+i4+kw9cLkRkG08OQmNI2ZsIW61fuhQNZ8sKdmzl79F9lac7fByltbtX68eDkq8wz
	 7Sic4p+YdrFcmWSr26lN2GAwv3kgY1cqKlXxlHz1tWijEAHM2YTO6gDDGMa4CbomSK
	 h804jOgxtGLmuv2sLH+RhoYUE/WPalJvN8arCIj0/7emHxueHF3S6/omEmOCj3DqCN
	 fMYdzSImoE/HiInnW3UlhJ8cmZF8VvjXj082cPt/90RRa81X/3c8CnAghdTcMXVLcJ
	 ooXF3waLkZwlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/5] btrfs: enhance btrfs_data_csum_ok() to use bio for page iteration
Date: Fri, 13 Nov 2026 09:04:58 -0500
Message-ID: <20261113135926.1497314-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135926.1497314-1-sashal@kernel.org>
References: <20261107050424-failed-7.3-d00b85308abe@kernel.org>
 <20261113135926.1497314-1-sashal@kernel.org>
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

[ Upstream commit 3e4a083bf0c8bb727517ae781052b80167443077 ]

Currently btrfs_data_csum_ok() requires a @paddr[] array to iterate all
possible pages for bs > ps cases.

However for all btrfs_data_csum_ok() call sites, we already have a
btrfs_bio, and the bio infrastructure has many flexible ways to iterate
multiple pages already.

Change btrfs_data_csum_ok() to make full use of btrfs_bio by:

- Change the parameter list to require a @bvec_iter pointer
  And remove @bio_offset, which can be calculated through @bvec_iter and
  bbio->saved_iter.

  Also remove paddrs[], we will iterate all the pages using bio
  interfaces.

- Make the same parameter changes to repair_one_sector()

- Use bio interfaces to iterate pages from a bio

- Rename the function to btrfs_bio_data_csum_ok()

- Remove on-stack paddrs[] array usage

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: d00b85308abe ("btrfs: raid56: do not verify the content if there is no data checksum")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c         | 82 +++++++++++++++---------------------------
 fs/btrfs/btrfs_inode.h |  4 +--
 fs/btrfs/inode.c       | 49 +++++++++++++++++++------
 3 files changed, 70 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f8d4c2d550073..19b4855969f53 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -180,29 +180,13 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct btrfs_failed_bio *fbio = repair_bbio->private;
 	struct btrfs_inode *inode = repair_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	/*
-	 * We can not move forward the saved_iter, as it will be later
-	 * utilized by repair_bbio again.
-	 */
-	struct bvec_iter saved_iter = repair_bbio->saved_iter;
-	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
-	const u32 nr_steps = repair_bbio->saved_iter.bi_size / step;
 	int mirror = repair_bbio->mirror_num;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-	phys_addr_t paddr;
-	unsigned int slot = 0;
 
-	/* Repair bbio should be eaxctly one block sized. */
+	/* Repair bbio should be exactly one block sized. */
 	ASSERT(repair_bbio->saved_iter.bi_size == fs_info->sectorsize);
 
-	btrfs_bio_for_each_block(paddr, &repair_bbio->bio, &saved_iter, step) {
-		ASSERT(slot < nr_steps);
-		paddrs[slot] = paddr;
-		slot++;
-	}
-
 	if (repair_bbio->bio.bi_status ||
-	    !btrfs_data_csum_ok(repair_bbio, dev, 0, paddrs)) {
+	    !btrfs_bio_data_csum_ok(repair_bbio, &repair_bbio->saved_iter, dev)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
 		repair_bbio->bio.bi_iter = repair_bbio->saved_iter;
 
@@ -236,25 +220,21 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
  * read succeeded to restore the redundancy.
  */
 static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
-						  u32 bio_offset,
-						  phys_addr_t paddrs[],
+						  const struct bvec_iter *orig_iter,
 						  struct btrfs_failed_bio *fbio)
 {
 	struct btrfs_inode *inode = failed_bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
-	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
-	const u32 nr_steps = sectorsize / step;
-	/*
-	 * For bs > ps cases, the saved_iter can be partially moved forward.
-	 * In that case we should round it down to the block boundary.
-	 */
-	const u64 logical = round_down(failed_bbio->saved_iter.bi_sector << SECTOR_SHIFT,
-				       sectorsize);
 	struct btrfs_bio *repair_bbio;
 	struct bio *repair_bio;
+	struct bvec_iter iter = *orig_iter;
+	const u32 sectorsize = fs_info->sectorsize;
+	const u32 bio_offset = ((iter.bi_sector - failed_bbio->saved_iter.bi_sector) <<
+				SECTOR_SHIFT);
+	const u64 logical = (iter.bi_sector << SECTOR_SHIFT);
 	int num_copies;
 	int mirror;
+	u32 cur = 0;
 
 	btrfs_debug(fs_info, "repair read error: read error at %llu",
 		    failed_bbio->file_offset + bio_offset);
@@ -275,17 +255,21 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	atomic_inc(&fbio->repair_count);
 
-	repair_bio = bio_alloc_bioset(NULL, nr_steps, REQ_OP_READ, GFP_NOFS,
-				      &btrfs_repair_bioset);
+	repair_bio = bio_alloc_bioset(NULL, max(1, sectorsize >> PAGE_SHIFT),
+				      REQ_OP_READ, GFP_NOFS, &btrfs_repair_bioset);
 	repair_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
-	for (int i = 0; i < nr_steps; i++) {
+	while (cur < sectorsize) {
+		struct page *page = bio_iter_page(&failed_bbio->bio, iter);
+		const u32 pg_off = bio_iter_offset(&failed_bbio->bio, iter);
+		const u32 cur_len = min(bio_iter_len(&failed_bbio->bio, iter),
+					sectorsize - cur);
 		int ret;
 
-		ASSERT(offset_in_page(paddrs[i]) + step <= PAGE_SIZE);
+		ret = bio_add_page(repair_bio, page, cur_len, pg_off);
+		ASSERT(ret == cur_len);
 
-		ret = bio_add_page(repair_bio, phys_to_page(paddrs[i]), step,
-				   offset_in_page(paddrs[i]));
-		ASSERT(ret == step);
+		bio_advance_iter_single(&failed_bbio->bio, &iter, cur_len);
+		cur += cur_len;
 	}
 
 	repair_bbio = btrfs_bio(repair_bio);
@@ -303,18 +287,16 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
-	const u32 step = min(sectorsize, PAGE_SIZE);
-	const u32 nr_steps = sectorsize / step;
-	struct bvec_iter *iter = &bbio->saved_iter;
+	struct bvec_iter iter;
 	blk_status_t status = bbio->bio.bi_status;
 	struct btrfs_failed_bio *fbio = NULL;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-	phys_addr_t paddr;
-	u32 offset = 0;
 
 	/* Read-repair requires the inode field to be set by the submitter. */
 	ASSERT(inode);
 
+	/* The original bbio should be sectorsize aligned. */
+	ASSERT(IS_ALIGNED(bbio->saved_iter.bi_size, sectorsize));
+
 	/*
 	 * Hand off repair bios to the repair code as there is no upper level
 	 * submitter for them.
@@ -327,16 +309,10 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
 	/* Clear the I/O error. A failed repair will reset it. */
 	bbio->bio.bi_status = BLK_STS_OK;
 
-	btrfs_bio_for_each_block(paddr, &bbio->bio, iter, step) {
-		paddrs[(offset / step) % nr_steps] = paddr;
-		offset += step;
-
-		if (IS_ALIGNED(offset, sectorsize)) {
-			if (status ||
-			    !btrfs_data_csum_ok(bbio, dev, offset - sectorsize, paddrs))
-				fbio = repair_one_sector(bbio, offset - sectorsize,
-							 paddrs, fbio);
-		}
+	for (iter = bbio->saved_iter; iter.bi_size;
+	     bio_advance_iter(&bbio->bio, &iter, sectorsize)) {
+		if (status || !btrfs_bio_data_csum_ok(bbio, &iter, dev))
+			fbio = repair_one_sector(bbio, &iter, fbio);
 	}
 	if (bbio->csum != bbio->csum_inline)
 		kvfree(bbio->csum);
@@ -924,7 +900,7 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
  * freeing the bio.
  *
  * @bbio:	Original bbio where the repair is needed
- * @orig_iter:	Points to where the repair start is
+ * @orig_iter:	Points to where the repair starts
  * @length:	Length of the repair write
  * @mirror_num: Mirror number to write to. Must not be zero
  */
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 1082fa92c1457..171f96bdb8aa7 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -513,8 +513,8 @@ void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
 				      const phys_addr_t paddrs[], u8 *dest);
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
 			   const u8 * const csum_expected);
-bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, const phys_addr_t paddrs[]);
+bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio, const struct bvec_iter *orig_iter,
+			    struct btrfs_device *dev);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa1201fe4d7f8..f842884722081 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3551,27 +3551,31 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
  * different noncontiguous pages.
  *
  * @bbio:	btrfs_io_bio which contains the csum
- * @dev:	device the sector is on
- * @bio_offset:	offset to the beginning of the bio (in bytes)
- * @paddrs:	physical addresses which back the fs block
+ * @orig_iter:	bvec iter pointing to the start of the block
+ * @dev:	device the sector is on (optional)
  *
  * Check if the checksum on a data block is valid.  When a checksum mismatch is
  * detected, report the error and fill the corrupted range with zero.
  *
  * Return %true if the sector is ok or had no checksum to start with, else %false.
  */
-bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
-			u32 bio_offset, const phys_addr_t paddrs[])
+bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio,
+			    const struct bvec_iter *orig_iter,
+			    struct btrfs_device *dev)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct bvec_iter iter = *orig_iter;
+	struct btrfs_csum_ctx cctx;
 	const u32 blocksize = fs_info->sectorsize;
-	const u32 step = min(blocksize, PAGE_SIZE);
-	const u32 nr_steps = blocksize / step;
+	const u32 bio_offset = (iter.bi_sector - bbio->saved_iter.bi_sector) << SECTOR_SHIFT;
 	u64 file_offset = bbio->file_offset + bio_offset;
 	u64 end = file_offset + blocksize - 1;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
+	u32 cur = 0;
+
+	ASSERT(iter.bi_sector >= bbio->saved_iter.bi_sector);
 
 	if (!bbio->csum)
 		return true;
@@ -3587,7 +3591,22 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	btrfs_calculate_block_csum_pages(fs_info, paddrs, csum);
+	btrfs_csum_init(&cctx, fs_info->csum_type);
+	while (cur < blocksize) {
+		struct page *page = bio_iter_page(&bbio->bio, iter);
+		const u32 pg_off = bio_iter_offset(&bbio->bio, iter);
+		const u32 cur_len = min(bio_iter_len(&bbio->bio, iter), blocksize - cur);
+		void *kaddr;
+
+		kaddr = kmap_local_page(page) + pg_off;
+		btrfs_csum_update(&cctx, kaddr, cur_len);
+		kunmap_local(kaddr);
+
+		bio_advance_iter_single(&bbio->bio, &iter, cur_len);
+		cur += cur_len;
+	}
+	btrfs_csum_final(&cctx, csum);
+
 	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		goto zeroit;
 	return true;
@@ -3597,8 +3616,18 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 				    bbio->mirror_num);
 	if (dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	for (int i = 0; i < nr_steps; i++)
-		memzero_page(phys_to_page(paddrs[i]), offset_in_page(paddrs[i]), step);
+	cur = 0;
+	iter = *orig_iter;
+	while (cur < blocksize) {
+		struct page *page = bio_iter_page(&bbio->bio, iter);
+		const u32 pg_off = bio_iter_offset(&bbio->bio, iter);
+		const u32 cur_len = min(bio_iter_len(&bbio->bio, iter), blocksize - cur);
+
+		memzero_page(page, pg_off, cur_len);
+
+		bio_advance_iter_single(&bbio->bio, &iter, cur_len);
+		cur += cur_len;
+	}
 	return false;
 }
 
-- 
2.53.0

