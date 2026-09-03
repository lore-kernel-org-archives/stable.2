Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C103FA5FD
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444390; cv=none; b=syCFXBNBhyqS/cHK3sGgVNxVe6xcgGLSYYGhz5CL1I78DD1U3kTcvzdmFi3XKzATDoMMpY+WVuUo7OC+HW2N+EZVm90HIriAw9/vAG6GjsxuvOKLO3xtAxDCmXU7lK9iaor0AAHRD4Y3AemzFKvqoDKDCpQnt2YuV9ye8qsGpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444390; c=relaxed/simple;
	bh=b8kIKtU3TSkSl/rDwNQxSMCL/dWdwb9rAhug1B2GHq0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bn5XLZgh5H5FkQ2G7b/5HlBVLTi5V2/ilWjwY9H8RPQto0H84VC5mj6/20OaZDxxglh7cFVSLoROkV8aRKoN1ZdmKGoL0Ny0XXlO7NMww+7DzwkYnM5hhd45q1dMVpJ04zJt2S7cMJaZ1ynMwkEMPRKkKpQExawkdObVfqkN4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oeCb60I3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oeCb60I3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A593D1F00A3A;
	Thu,  3 Sep 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444380;
	bh=ueJMXn+kSulPPcGpmh8+JHZsfTWcfZR08cf7f6ES8K4=;
	h=Subject:To:Cc:From:Date;
	b=oeCb60I3u1dxhRHrGlmy8VQyiMl/VZO5Wf7dMTqeQ0hE6dfHsAGu8S7uAaWr9zc3v
	 AoS+MzaTn7Kiv7d8VoI8pBRIefUNOMRzMqz5EtHt9Gwq6pJ0UDgDDQ/deFotQSfhrO
	 Ib2WLr6Bvov0cgtwi+HjWUigMA6pIHcCX3Q+xdHY=
Subject: FAILED: patch "[PATCH] block: validate user space vectors during extraction" failed to apply to 6.18-stable tree
To: kbusch@kernel.org,axboe@kernel.dk,hare@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:46:13 +0200
Message-ID: <2026090313-revolver-python-ce1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 14b007e178811db72fbb1ebb3535160db6ec1e6a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090313-revolver-python-ce1a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14b007e178811db72fbb1ebb3535160db6ec1e6a Mon Sep 17 00:00:00 2001
From: Keith Busch <kbusch@kernel.org>
Date: Mon, 20 Jul 2026 13:10:57 -0700
Subject: [PATCH] block: validate user space vectors during extraction

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

diff --git a/block/bio.c b/block/bio.c
index 6a2f6fc3413e..5018a6fc2f36 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1221,10 +1221,45 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
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
@@ -1243,7 +1278,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
  * is returned only if 0 pages could be pinned.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
-			   unsigned len_align_mask)
+			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
 
@@ -1252,6 +1287,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (iov_iter_is_bvec(iter)) {
 		bio_iov_bvec_set(bio, iter);
+
+		if (!bio_iov_bvec_aligned(bio, mem_align_mask))
+			return -EINVAL;
+
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
 	}
@@ -1266,8 +1305,19 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
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
@@ -1380,7 +1430,7 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
 
 	do {
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
-				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
+				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0, 0);
 		if (ret <= 0) {
 			if (!bio->bi_vcnt)
 				goto out_folio_put;
diff --git a/block/blk-map.c b/block/blk-map.c
index d1d6bbe0ecf1..615d29bb840e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -274,7 +274,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	 * No alignment requirements on our part to support arbitrary
 	 * passthrough commands.
 	 */
-	ret = bio_iov_iter_get_pages(bio, iter, 0);
+	ret = bio_iov_iter_get_pages(bio, iter, 0, 0);
 	if (ret)
 		goto out_put;
 	ret = blk_rq_append_bio(rq, bio);
diff --git a/block/fops.c b/block/fops.c
index 0098a90a956e..e519d7f43b31 100644
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
index e2cd5f92babe..01daed391856 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -358,6 +358,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 				iomap_max_bio_size(&iter->iomap), alignment);
 	else
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+					     bdev_dma_alignment(bio->bi_bdev),
 					     alignment - 1);
 	if (unlikely(ret))
 		goto out_put_bio;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..ce34ea49ef35 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -477,7 +477,7 @@ int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
 
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
-		unsigned len_align_mask);
+		unsigned mem_align_mask, unsigned len_align_mask);
 
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..fe2e985d74d2 100644
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
index c2484551a4e8..34a52e9ba9e1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1904,6 +1904,8 @@ static unsigned int get_contig_folio_len(struct page **pages,
  * @max_size:	maximum size to extract from @iter
  * @nr_vecs:	number of vectors in @bv (on in and output)
  * @max_vecs:	maximum vectors in @bv, including those filled before calling
+ * @mem_align_mask:	reject with -EINVAL if the source address or
+ *		length is not aligned to this mask
  * @extraction_flags: flags to qualify request
  *
  * Like iov_iter_extract_pages(), but returns physically contiguous ranges
@@ -1915,14 +1917,19 @@ static unsigned int get_contig_folio_len(struct page **pages,
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

