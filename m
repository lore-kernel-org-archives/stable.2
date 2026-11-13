Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578706;
	b=RJtcBVcA7ZpuWzj+EVsNmgC2aVsaaJgMEm5Y8XMub+3oF4sZgIQEvCE/u9t75pavMnBb
	 OBAyABbUsvIPgl7UBglQeZmjvXmQRver+I9BVVNL7d6NUcpwnLKQqvOBgePNgjUT7Bk6A
	 sMtTLIYFxslLiw0tFqVb5eZ44Jv2Gs1KUoucujw0+q0+eyy5IZLSE7aK67xThPizsusNB
	 q6WgkggFnS+SOkrmP2Idnk8E6bO/s7igG4YMVTsmHpm0gdsf+uc1QCVnOKuw31tMkEi/O
	 VwkvNUC/Z4cas20bBFUVqzoB9JPES/5TKm3p3NrYG4MoGLOzslZ5QNusSkjtmB9CNIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578706;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bvDGu4eLx558QWXY7LIosyqveS684oIZWcXs7IT/w4A=;
	b=E7QfiyFCHPIYHHLa2KHmUcBDq+rWLwBlEYFAB1Xbc92GLAYC1YYLGJbb8+xSxA+59gf4
	 cc7VGXYodEAo4+TTN94ELtgiJPndRjSV+dpKIEx7qfIqd8MnYsJcxRhoOrd+GwxU14nqS
	 t7NVsHKK0iCbOfez5eZScDqMkhW3Gk6jx+n1ws2cpzhWrysnrwBpy3uQ5dgH9qJT1Qzsz
	 t7nes2LUvK0Dy9DSV5wi730lJKWVEuVgpkxB5ggDAfL1o0aApY2eDNI8zRAmTSjzQ4lk5
	 WcMs9hnOo5SXpn0xJisd7r05BAy/PfRME9NDrXl1DqQXI/D5rajaSkpKxF+OIbncYvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxuFctw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3F606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxuFctw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740311F000C4;
	Fri, 13 Nov 2026 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578706;
	bh=bvDGu4eLx558QWXY7LIosyqveS684oIZWcXs7IT/w4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxuFctw5PjavnA6cANn6CoDY2V6eZAbswqQb+E6869nXfmhd9hB9gUXw8JxpFqVlb
	 +5efPibwkBvDFLNkQaMhv31Odi9B0iu6FDl0XRmKSpX07agE+LpLuqtNAA8cw7GmBj
	 +bbbdXjbWSyMx5el9+kr/kkv/BPobE6skFMuzt5ufoCld6LxJNvWoTxxaOa5enOL7L
	 FL016NT58i8dGTNTOOKv6hkslWFZISXdbEBIMAtW+ZsnWtMlGC/g0lyx/UzZx3eAOU
	 RDwj0N+IYwPzvP/7PROqz0xwYlrPtJWJQ8tEGalNqqb7Y+1ZZo8U+FQ6V9hu+Azcxe
	 oqTJBb+MoHFLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 4/5] btrfs: remove on-stack paddrs[] array usage
Date: Fri, 13 Nov 2026 09:05:00 -0500
Message-ID: <20261113135926.1497314-4-sashal@kernel.org>
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

[ Upstream commit f41f4dcddea1b9eb41fc3a5491b2a8dd1f7c21ff ]

Since the bs > ps support, we have to handle cases where a data block is
inside several discontiguous pages.

Thus we need a local paddrs[] array to assemble a data block for bs > ps
cases.

However to handle all possible bs/ps combinations, we have to declare
such array using the max block size vs page size, no matter the current
block size and page size.

This adds 128 bytes on-stack memory usage for several call sites, and
also introduced several duplicated helpers to calculate checksum for a
data block:

- btrfs_calculate_block_csum_folio()
- btrfs_calculate_block_csum_pages()
- btrfs_check_block_csum()

The differences are mostly in how the data is passed.
The first one accepts a contiguous paddr range.
The second one accepts an array of paddrs[].
The last one is just a simple wrapper of the first one.

However the most common interface to iterate a data block is through
bio, and we have already converted most callers to use the bio based
interface, e.g. btrfs_bio_data_csum_ok() and btrfs_csum_one_bio_block().

Convert the remaining two call sites to address the remaining paddrs[]
usage:

- btrfs_calculate_block_csum_pages() inside verify_bio_data_sectors()
  This can be switched to btrfs_csum_one_bio_block().

  This removes the 128 bytes on-stack memory usage.

- btrfs_calculate_block_csum_pages() inside verify_one_sector()
  This call site doesn't use on-stack memory for paddrs[], but reuses
  the existing btrfs_raid_bio::bio_paddrs[] or
  btrfs_raid_bio::stripe_paddrs[].

  So implement a local version called calculate_block_csum_paddrs().

Now there is no fixed on-stack paddrs[] usage anymore.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: d00b85308abe ("btrfs: raid56: do not verify the content if there is no data checksum")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h |  6 ----
 fs/btrfs/inode.c       | 75 ------------------------------------------
 fs/btrfs/raid56.c      | 46 +++++++++++++++-----------
 3 files changed, 27 insertions(+), 100 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e137a99151bd0..89e5e9c0c904f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -507,12 +507,6 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 				      inode->root->fs_info->block_max_order);
 }
 
-void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
-				      const phys_addr_t paddr, u8 *dest);
-void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
-				      const phys_addr_t paddrs[], u8 *dest);
-int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
-			   const u8 * const csum_expected);
 bool btrfs_bio_data_csum_ok(struct btrfs_bio *bbio, const struct bvec_iter *orig_iter,
 			    struct btrfs_device *dev);
 void btrfs_csum_one_bio_block(struct btrfs_fs_info *fs_info, struct bio *bio,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c8479ffc8d1df..c2a720f74d56d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3471,81 +3471,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 	return btrfs_finish_one_ordered(ordered);
 }
 
-/*
- * Calculate the checksum of an fs block at physical memory address @paddr,
- * and save the result to @dest.
- *
- * The folio containing @paddr must be large enough to contain a full fs block.
- */
-void btrfs_calculate_block_csum_folio(struct btrfs_fs_info *fs_info,
-				      const phys_addr_t paddr, u8 *dest)
-{
-	struct folio *folio = page_folio(phys_to_page(paddr));
-	const u32 blocksize = fs_info->sectorsize;
-	const u32 step = min(blocksize, PAGE_SIZE);
-	const u32 nr_steps = blocksize / step;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-
-	/* The full block must be inside the folio. */
-	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
-
-	for (int i = 0; i < nr_steps; i++) {
-		u32 pindex = offset_in_folio(folio, paddr + i * step) >> PAGE_SHIFT;
-
-		/*
-		 * For bs <= ps cases, we will only run the loop once, so the offset
-		 * inside the page will only added to paddrs[0].
-		 *
-		 * For bs > ps cases, the block must be page aligned, thus offset
-		 * inside the page will always be 0.
-		 */
-		paddrs[i] = page_to_phys(folio_page(folio, pindex)) + offset_in_page(paddr);
-	}
-	return btrfs_calculate_block_csum_pages(fs_info, paddrs, dest);
-}
-
-/*
- * Calculate the checksum of a fs block backed by multiple noncontiguous pages
- * at @paddrs[] and save the result to @dest.
- *
- * The folio containing @paddr must be large enough to contain a full fs block.
- */
-void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
-				      const phys_addr_t paddrs[], u8 *dest)
-{
-	const u32 blocksize = fs_info->sectorsize;
-	const u32 step = min(blocksize, PAGE_SIZE);
-	const u32 nr_steps = blocksize / step;
-	struct btrfs_csum_ctx csum;
-
-	btrfs_csum_init(&csum, fs_info->csum_type);
-	for (int i = 0; i < nr_steps; i++) {
-		const phys_addr_t paddr = paddrs[i];
-		void *kaddr;
-
-		ASSERT(offset_in_page(paddr) + step <= PAGE_SIZE);
-		kaddr = kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
-		btrfs_csum_update(&csum, kaddr, step);
-		kunmap_local(kaddr);
-	}
-	btrfs_csum_final(&csum, dest);
-}
-
-/*
- * Verify the checksum for a single sector without any extra action that depend
- * on the type of I/O.
- *
- * @kaddr must be a properly kmapped address.
- */
-int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
-			   const u8 * const csum_expected)
-{
-	btrfs_calculate_block_csum_folio(fs_info, paddr, csum);
-	if (unlikely(memcmp(csum, csum_expected, fs_info->csum_size) != 0))
-		return -EIO;
-	return 0;
-}
-
 /* Generate data checksum for a single fs block, pointed to by @orig_iter. */
 void btrfs_csum_one_bio_block(struct btrfs_fs_info *fs_info, struct bio *bio,
 			      const struct bvec_iter *orig_iter, u8 *csum)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1ee52a9dcee36..a5d0ef09d92ab 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1652,12 +1652,7 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 				    struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
-	const u32 nr_steps = rbio->sector_nsteps;
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
-	u32 offset = 0;
-	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
-	phys_addr_t paddr;
 
 	/* No data csum for the whole stripe, no need to verify. */
 	if (!rbio->csum_bitmap || !rbio->csum_buf)
@@ -1667,28 +1662,20 @@ static void verify_bio_data_sectors(struct btrfs_raid_bio *rbio,
 	if (total_sector_nr >= rbio->nr_data * rbio->stripe_nsectors)
 		return;
 
-	btrfs_bio_for_each_block_all(paddr, bio, step) {
+	for (struct bvec_iter iter = init_bvec_iter_for_bio(bio);
+	     iter.bi_size;
+	     bio_advance_iter(bio, &iter, fs_info->sectorsize), total_sector_nr++) {
 		u8 csum_buf[BTRFS_CSUM_SIZE];
 		u8 *expected_csum;
 
-		paddrs[(offset / step) % nr_steps] = paddr;
-		offset += step;
-
-		/* Not yet covering the full fs block, continue to the next step. */
-		if (!IS_ALIGNED(offset, fs_info->sectorsize))
-			continue;
-
 		/* No csum for this sector, skip to the next sector. */
-		if (!test_bit(total_sector_nr, rbio->csum_bitmap)) {
-			total_sector_nr++;
+		if (!test_bit(total_sector_nr, rbio->csum_bitmap))
 			continue;
-		}
 
 		expected_csum = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
-		btrfs_calculate_block_csum_pages(fs_info, paddrs, csum_buf);
+		btrfs_csum_one_bio_block(fs_info, bio, &iter, csum_buf);
 		if (unlikely(memcmp(csum_buf, expected_csum, fs_info->csum_size) != 0))
 			set_bit(total_sector_nr, rbio->error_bitmap);
-		total_sector_nr++;
 	}
 }
 
@@ -1879,6 +1866,27 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	start_async_work(rbio, rmw_rbio_work);
 }
 
+static void calculate_block_csum_paddrs(struct btrfs_fs_info *fs_info,
+					const phys_addr_t paddrs[], u8 *dest)
+{
+	const u32 blocksize = fs_info->sectorsize;
+	const u32 step = min(blocksize, PAGE_SIZE);
+	const u32 nr_steps = blocksize / step;
+	struct btrfs_csum_ctx csum;
+
+	btrfs_csum_init(&csum, fs_info->csum_type);
+	for (int i = 0; i < nr_steps; i++) {
+		const phys_addr_t paddr = paddrs[i];
+		void *kaddr;
+
+		ASSERT(offset_in_page(paddr) + step <= PAGE_SIZE);
+		kaddr = kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
+		btrfs_csum_update(&csum, kaddr, step);
+		kunmap_local(kaddr);
+	}
+	btrfs_csum_final(&csum, dest);
+}
+
 static int verify_one_sector(struct btrfs_raid_bio *rbio,
 			     int stripe_nr, int sector_nr)
 {
@@ -1906,7 +1914,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	csum_expected = rbio->csum_buf +
 			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
 			fs_info->csum_size;
-	btrfs_calculate_block_csum_pages(fs_info, paddrs, csum_buf);
+	calculate_block_csum_paddrs(fs_info, paddrs, csum_buf);
 	if (unlikely(memcmp(csum_buf, csum_expected, fs_info->csum_size) != 0))
 		return -EIO;
 	return 0;
-- 
2.53.0

