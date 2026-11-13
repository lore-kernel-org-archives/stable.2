Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578705;
	b=lmCzhQXTTmie9fCHihhlYbMy9OsrFQaGDS7gvgX+Eet7CKnPLPjTgJAAvjQkIjdrcttG
	 +lu13wZ4MziyoAoJZI2W5cYYYy7t4+isMIMgCqj/+bXDnsOMrI+mGN8J5fbOTa0f/yLuv
	 WjFgdYzCULplVUMjPuyQBoiDg5ZEZhLzJHVXuspJe+cnGdruU0G4WIwLKGFyAJ9TcXnqE
	 JsuyabNuV/KE22++QdySb+ehvw03kWWodY38TTxJ1Wh5Dop/dtHWK0dyB7n78fJ5x/UL5
	 jS5HHnBUOYBeAHJQS55GZmY2oZZT4TOJF2vJwxYGJ/8HHBFj8NR8v/acY21UdVWbEGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rgtC+MoJNnXZBN9FNIlIzDfili+qFndh4iDRFeSTEoY=;
	b=S4ax9Zy/5iG6DdbcFYicGze5PTGD3MrE+4wo68VZ+OxTODwAOhHRBWzGjjhwRpw6JE9m
	 Gw3xCVaM/DHYMODIukOSHrhRDA/doyt5GpZCqMeoRp41aTmlvrxbFxmSoXyvsUAyqlml6
	 qu5kYA7XM1FJu0o1cT4a5NL/yHZCEWGJQvU2IXewx3bQniNCK06/drrX5Yt7SsoY+Vj2l
	 RKltIwPHWLpE87L6xK6jPFnLB0ts9X49UrmYLYwIQfcm7udEVjtWohiN1RMmpnWzovVNp
	 IMYm4Hxb7VBLs7ohIf+PFOnAd0hK4JOst//bdliRZxtkEDLbFlpPoJHwm4rxsJEYncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQrLz6VJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B63606A334
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQrLz6VJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C6B1F000C6;
	Fri, 13 Nov 2026 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578705;
	bh=rgtC+MoJNnXZBN9FNIlIzDfili+qFndh4iDRFeSTEoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQrLz6VJDGWgbqb9eQzcNlkDtjJ9MjX7Jhee7VYU0edi35vS0PgYqj7pSBerxnZMA
	 o4KrNTlTYwkvFVlGeekfRPf8upWNlRhDqsZCx0XhRXGolmXa03HmkCxmAfKxh3kjjn
	 ABBH42NN+QBmkL4rR3DxwLpSRALvPKc2qdTl1sgJfm4SdPrd3/+brSLkd5j5qcVCH4
	 Jyen16ueDRgHoPG4NmnMSCfJM8GL3HLaH9jfme6IJVL1ezxpgvxA22c/QHZ/7R2Nwf
	 CuLFBqYwlaUheP7zNic8ci9IsLkZy7F6AxwxG1oZ+r3hoEtGgY78632JFW5KIglyrd
	 7nSJc82O/V2DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/5] btrfs: use a shared helper to calculate data checksum for a bio
Date: Fri, 13 Nov 2026 09:04:59 -0500
Message-ID: <20261113135926.1497314-3-sashal@kernel.org>
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

[ Upstream commit 64978a4eced2b8f769cdfc27d68c6710e9c92627 ]

Since we are already calculating data checksum using bio interface,
extract the generation part into btrfs_csum_one_bio_block(), and use that
to replace the paddrs[] array based solution in csum_one_bio().

This will reduce 128 bytes on-stack memory usage for csum_one_bio().

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: d00b85308abe ("btrfs: raid56: do not verify the content if there is no data checksum")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h |  2 ++
 fs/btrfs/file-item.c   | 19 +++++------------
 fs/btrfs/inode.c       | 46 +++++++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 171f96bdb8aa7..e137a99151bd0 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -515,6 +515,8 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
 			   const u8 * const csum_expected);
 bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio, const struct bvec_iter *orig_iter,
 			    struct btrfs_device *dev);
+void btrfs_csum_one_bio_block(struct btrfs_fs_info *fs_info, struct bio *bio,
+			      const struct bvec_iter *orig_iter, u8 *csum);
 noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index cf50fd623f41a..581ca5653be93 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -801,25 +801,16 @@ static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums = bbio->sums;
-	struct bvec_iter iter = *src;
-	phys_addr_t paddr;
+	struct bvec_iter iter;
 	const u32 blocksize = fs_info->sectorsize;
-	const u32 step = min(blocksize, PAGE_SIZE);
-	const u32 nr_steps = blocksize / step;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-	u32 offset = 0;
 	int index = 0;
 
-	btrfs_bio_for_each_block(paddr, bio, &iter, step) {
-		paddrs[(offset / step) % nr_steps] = paddr;
-		offset += step;
+	for (iter = *src; iter.bi_size; bio_advance_iter(&bbio->bio, &iter, blocksize)) {
+		btrfs_csum_one_bio_block(fs_info, &bbio->bio, &iter,
+					 sums->sums + index);
 
-		if (IS_ALIGNED(offset, blocksize)) {
-			btrfs_calculate_block_csum_pages(fs_info, paddrs, sums->sums + index);
-			index += fs_info->csum_size;
-		}
+		index += fs_info->csum_size;
 	}
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f842884722081..c8479ffc8d1df 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3546,6 +3546,32 @@ int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8
 	return 0;
 }
 
+/* Generate data checksum for a single fs block, pointed to by @orig_iter. */
+void btrfs_csum_one_bio_block(struct btrfs_fs_info *fs_info, struct bio *bio,
+			      const struct bvec_iter *orig_iter, u8 *csum)
+{
+	struct btrfs_csum_ctx cctx;
+	struct bvec_iter iter = *orig_iter;
+	const u32 blocksize = fs_info->sectorsize;
+	u32 cur = 0;
+
+	btrfs_csum_init(&cctx, fs_info->csum_type);
+	while (cur < blocksize) {
+		struct page *page = bio_iter_page(bio, iter);
+		const u32 pg_off = bio_iter_offset(bio, iter);
+		const u32 cur_len = min(bio_iter_len(bio, iter), blocksize - cur);
+		void *kaddr;
+
+		kaddr = kmap_local_page(page) + pg_off;
+		btrfs_csum_update(&cctx, kaddr, cur_len);
+		kunmap_local(kaddr);
+
+		bio_advance_iter_single(bio, &iter, cur_len);
+		cur += cur_len;
+	}
+	btrfs_csum_final(&cctx, csum);
+}
+
 /*
  * Verify the checksum of a single data sector, which can be scattered at
  * different noncontiguous pages.
@@ -3566,7 +3592,6 @@ bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio,
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bvec_iter iter = *orig_iter;
-	struct btrfs_csum_ctx cctx;
 	const u32 blocksize = fs_info->sectorsize;
 	const u32 bio_offset = (iter.bi_sector - bbio->saved_iter.bi_sector) << SECTOR_SHIFT;
 	u64 file_offset = bbio->file_offset + bio_offset;
@@ -3591,22 +3616,7 @@ bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio,
 
 	csum_expected = bbio->csum + (bio_offset >> fs_info->sectorsize_bits) *
 				fs_info->csum_size;
-	btrfs_csum_init(&cctx, fs_info->csum_type);
-	while (cur < blocksize) {
-		struct page *page = bio_iter_page(&bbio->bio, iter);
-		const u32 pg_off = bio_iter_offset(&bbio->bio, iter);
-		const u32 cur_len = min(bio_iter_len(&bbio->bio, iter), blocksize - cur);
-		void *kaddr;
-
-		kaddr = kmap_local_page(page) + pg_off;
-		btrfs_csum_update(&cctx, kaddr, cur_len);
-		kunmap_local(kaddr);
-
-		bio_advance_iter_single(&bbio->bio, &iter, cur_len);
-		cur += cur_len;
-	}
-	btrfs_csum_final(&cctx, csum);
-
+	btrfs_csum_one_bio_block(fs_info, &bbio->bio, orig_iter, csum);
 	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
 		goto zeroit;
 	return true;
@@ -3616,8 +3626,6 @@ bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio,
 				    bbio->mirror_num);
 	if (dev)
 		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	cur = 0;
-	iter = *orig_iter;
 	while (cur < blocksize) {
 		struct page *page = bio_iter_page(&bbio->bio, iter);
 		const u32 pg_off = bio_iter_offset(&bbio->bio, iter);
-- 
2.53.0

