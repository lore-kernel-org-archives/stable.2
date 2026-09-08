Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BC53A886
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870008; cv=none; b=amxnfQe0XJJLmDk+FJYgM5ka1Xl6Zj1Vxox5yzW0r0rAIrKuu4m/CUeEGLjvNUg32MLsfiFAFQQbJKxqAazJEVWQkNm1j/zt1cegyYs0DV/X0rmNM9iWXXqAb4wf9NkWycSGRGS/dBbGetCpf/0RgzSi5LwbIxIOS97F8o/KO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870008; c=relaxed/simple;
	bh=qI+tDyn4Ly0X32HixX8ltxResRfPQwbhM8nROhQXFJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+kDkU6x+9FTQZ1XOQGBhhrNQ44QmC2vpp5alt73OErIlgQktuh42HosnK6++etIYk+CZqxjqZMFXhvNpyRa6PpsKXuyOorQ0csZcpHdW3vkGLUcF5uo5+a26AKO0OHggqupXZegETWe3RX/cVFNZyitSEJvirrTLGdC/z/GSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32Gi/rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32Gi/rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4291F00ADF;
	Tue,  8 Sep 2026 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870003;
	bh=cTHN/l+whfZB72To7sAfqxHNlU6uz7oko+Hkk+TySZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D32Gi/rA8P6oR3ey7XGNp7w4x0HxSp8XqxcB+IscZIYDFA2V9dEOk2p45AxRxiDLy
	 JZTZwx4ey9YlzXIu1GBnBXhUCy1+HGmEJocnANZ6yfL+9dghCLVdAQMG9jeujA8Bua
	 aPKdqDPCcz5df07kFZT6DYuojZc4l62vjgMxdKG2WsJ2NB0FRPFmWTYBiuLBvlOlGW
	 WrJHdNJBCYkbgRPcV9v/0dFEMItP6NNzlijfkO8BPAolhuV9HyZuUMUihEFT75UU60
	 LX6UXEq/5J5wsdjig0PqFCmkbeDx3MN9SwoqVbSOxMWLehWCM8LmKaQhvyIaUVi1Fq
	 QUMmMU7SM4sUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] block: validate user space vectors during extraction
Date: Tue,  8 Sep 2026 08:19:55 -0400
Message-ID: <20260908121955.2049107-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908121955.2049107-1-sashal@kernel.org>
References: <2026090313-revolver-python-ce1a@gregkh>
 <20260908121955.2049107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 14b007e178811db72fbb1ebb3535160db6ec1e6a ]

The bio-based drivers don't necessarily check the alignment split, and
stacking block drivers don't always handle a misalignment detected after
submitting the bio. Validate user vectors against the device's
dma_alignment as the bio is built from the iov_iter, rejecting
misaligned early with -EINVAL.

Cc: stable@vger.kernel.org
Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
Fixes: 7eac33186957 ("iomap: simplify direct io validity check")
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://patch.msgid.link/20260720201057.1862857-6-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c          | 56 +++++++++++++++++++++++++++++++++++++++++---
 block/blk-map.c      |  2 +-
 block/fops.c         |  2 +-
 fs/iomap/direct-io.c |  1 +
 include/linux/bio.h  |  2 +-
 include/linux/uio.h  | 10 +++++++-
 lib/iov_iter.c       |  9 ++++++-
 7 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 56eae6ef6ec07..9d5cc882ca90e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1199,10 +1199,45 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_KERNEL
+static inline bool bio_iov_bvec_aligned(const struct bio *bio,
+					unsigned mem_align_mask)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	/*
+	 * Correct callers never break the alignment requirements, so this
+	 * exhaustive check is only paid for in debug builds.
+	 */
+	for_each_mp_bvec(bv, bio->bi_io_vec, iter, bio->bi_iter)
+		if ((bv.bv_offset | bv.bv_len) & mem_align_mask)
+			return false;
+	return true;
+}
+#else
+static inline bool bio_iov_bvec_aligned(const struct bio *bio,
+					unsigned mem_align_mask)
+{
+	/*
+	 * We forward the bio_vec as-is, so ITER_BVEC callers must provide
+	 * segments already aligned to the device's DMA alignment. The only
+	 * unchecked user-controllable offset that reaches here is an io_uring
+	 * registered buffer where just the first segment can be unaligned
+	 * (the rest is virtually contiguous), so checking only that one is
+	 * sufficient to know if the entire vector is valid.
+	 */
+	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
+							mem_align_mask);
+}
+#endif
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
+ * @mem_align_mask: the mask the source address and length must be aligned to,
+ *	0 for no requirement
  * @len_align_mask: the mask to align the total size to, 0 for any length
  *
  * This takes either an iterator pointing to user memory, or one pointing to
@@ -1221,7 +1256,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
  * is returned only if 0 pages could be pinned.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
-			   unsigned len_align_mask)
+			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
 
@@ -1230,6 +1265,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (iov_iter_is_bvec(iter)) {
 		bio_iov_bvec_set(bio, iter);
+
+		if (!bio_iov_bvec_aligned(bio, mem_align_mask))
+			return -EINVAL;
+
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
 	}
@@ -1244,8 +1283,19 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 				BIO_MAX_SIZE - bio->bi_iter.bi_size,
-				&bio->bi_vcnt, bio->bi_max_vecs, flags);
+				&bio->bi_vcnt, bio->bi_max_vecs,
+				mem_align_mask, flags);
 		if (ret <= 0) {
+			/*
+			 * A misaligned vector fails the whole I/O.  Release any
+			 * pages pinned by earlier iterations before returning
+			 * since this bio won't be submitted to release them.
+			 */
+			if (ret == -EINVAL) {
+				bio_release_pages(bio, false);
+				bio_clear_flag(bio, BIO_PAGE_PINNED);
+				bio->bi_vcnt = 0;
+			}
 			if (!bio->bi_vcnt)
 				return ret;
 			break;
@@ -1338,7 +1388,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
 		ssize_t ret;
 
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
-				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
+				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0, 0);
 		if (ret <= 0) {
 			if (!bio->bi_vcnt)
 				return ret;
diff --git a/block/blk-map.c b/block/blk-map.c
index 60faf036fb6e4..1cf7165d49149 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -287,7 +287,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	 * No alignment requirements on our part to support arbitrary
 	 * passthrough commands.
 	 */
-	ret = bio_iov_iter_get_pages(bio, iter, 0);
+	ret = bio_iov_iter_get_pages(bio, iter, 0, 0);
 	if (ret)
 		goto out_put;
 	ret = blk_rq_append_bio(rq, bio);
diff --git a/block/fops.c b/block/fops.c
index 5e3db9fead77c..ba9ac3372fd90 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -46,7 +46,7 @@ static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
 static inline int blkdev_iov_iter_get_pages(struct bio *bio,
 		struct iov_iter *iter, struct block_device *bdev)
 {
-	return bio_iov_iter_get_pages(bio, iter,
+	return bio_iov_iter_get_pages(bio, iter, bdev_dma_alignment(bdev),
 			bdev_logical_block_size(bdev) - 1);
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6c7293c3ba592..2f10b15d27a5d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -369,6 +369,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+					     bdev_dma_alignment(bio->bi_bdev),
 					     alignment - 1);
 	if (unlikely(ret))
 		goto out_put_bio;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 627973d7ed3a7..fd75ceba60777 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -470,7 +470,7 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
 
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
-		unsigned len_align_mask);
+		unsigned mem_align_mask, unsigned len_align_mask);
 
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e32..fe2e985d74d24 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -389,9 +389,17 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 			       size_t maxsize, unsigned int maxpages,
 			       iov_iter_extraction_t extraction_flags,
 			       size_t *offset0);
+/*
+ * Block-layer consumers (e.g. bio_iov_iter_get_pages()) require that the
+ * segments of an ITER_BVEC iterator are already aligned to the target device's
+ * DMA alignment, and forward them as-is.  In-kernel users that build their own
+ * bvecs must not create sub-aligned segments; iov_iter_extract_bvecs() enforces
+ * the same for the segments it extracts via @mem_align_mask.
+ */
 ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		size_t max_size, unsigned short *nr_vecs,
-		unsigned short max_vecs, iov_iter_extraction_t extraction_flags);
+		unsigned short max_vecs, unsigned mem_align_mask,
+		iov_iter_extraction_t extraction_flags);
 
 /**
  * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 53dcd9649d59a..b8782f5e7dbbf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1874,6 +1874,8 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * @max_size:	maximum size to extract from @iter
  * @nr_vecs:	number of vectors in @bv (on in and output)
  * @max_vecs:	maximum vectors in @bv, including those filled before calling
+ * @mem_align_mask:	reject with -EINVAL if the source address or
+ *		length is not aligned to this mask
  * @extraction_flags: flags to qualify request
  *
  * Like iov_iter_extract_pages(), but returns physically contiguous ranges
@@ -1885,14 +1887,19 @@ static unsigned int get_contig_folio_len(struct page **pages,
  */
 ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		size_t max_size, unsigned short *nr_vecs,
-		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
+		unsigned short max_vecs, unsigned mem_align_mask,
+		iov_iter_extraction_t extraction_flags)
 {
+	unsigned long start = (unsigned long)iter_iov_addr(iter);
 	unsigned short entries_left = max_vecs - *nr_vecs;
 	unsigned short nr_pages, i = 0;
 	size_t left, offset, len;
 	struct page **pages;
 	ssize_t size;
 
+	if ((start | iter_iov_len(iter)) & mem_align_mask)
+		return -EINVAL;
+
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
 	 * possible so that we can start filling biovecs from the beginning
-- 
2.53.0

