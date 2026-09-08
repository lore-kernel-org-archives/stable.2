Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769B3AB272
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870006; cv=none; b=pwf1TQgDCPaDFX9E1g0WyimkHxHWiVwiH9T5KjQdXCnnckPtHHHzcWlomVSzh46k2yBxC7OHArQWWH+PCc60bP+ohu+spvIQQZSPzg+5OM6asX6o+xFEIxcMmOjiV3YNg33KwSAxHZksPYsGDQ/DU+besTfHEY9JCxJRRY2u8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870006; c=relaxed/simple;
	bh=47iMBOpjbZWyGHMhczxzyw4dtVc3bmai0/9tjcfpcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtCNWhz8zXiL3aL41cBPasfClfXnZGuAc2deW0TLY6rufT2BVmINMCKP93csgjXFiQmuGKAOpCbqbSc/p/2mCuxP345S9k4ZqrpPwcqfanOe3M0eN48ys4TeibRRct7fdhmv7k/j0pUPQFc/qNUIrzSK/3IQWaWqAJL+ZcsyuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqPViMs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqPViMs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26E1F00A3F;
	Tue,  8 Sep 2026 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870001;
	bh=3GG9IAaR9rYJKEPmqKIXDW9/MZyMSTYY4Sf/4DvpD+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HqPViMs2uUL5gkmPob4SlpgaJgeRerfhgf2vLp3+ugtK1I13kSOorhxTLsKHNSqML
	 9ZeUT7g7/aJ6rgf4zdnkCFqM2iZwAyqQ9/+8SILD3cwJtUUc2eAFOHVCZrKOIm6suA
	 goYocKHs5qKsxuv364HwCgYt+seYrzWzEvT/mWVnmKOYbO1+6dG6ZmWd/NKREZoS35
	 fl2DEt7IZe/Rx1BiDwbRK8cbEoJqmtyOOvJqW0+G41KK1lyFif/GCgZygjBJw1+dOx
	 jRxv349FlNiEvLeFKOmTptaHU2VkTWLjNBlgwN/bcyErJAY5WD5yV6A47w4JrbUmvi
	 PtRG5Fo/lIkOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] iomap: split out the per-bio logic from iomap_dio_bio_iter
Date: Tue,  8 Sep 2026 08:19:53 -0400
Message-ID: <20260908121955.2049107-4-sashal@kernel.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 2631c94602297090febd8f93d6f96d9d2045466d ]

Factor out a separate helper that builds and submits a single bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c               |   2 +-
 fs/iomap/direct-io.c      | 157 ++++++++++++++++++++++----------------
 include/linux/blk_types.h |   3 +-
 include/linux/iomap.h     |   9 +++
 4 files changed, 104 insertions(+), 67 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 600f110e5c0dc..56eae6ef6ec07 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1243,7 +1243,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		ssize_t ret;
 
 		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
-				UINT_MAX - bio->bi_iter.bi_size,
+				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				&bio->bi_vcnt, bio->bi_max_vecs, flags);
 		if (ret <= 0) {
 			if (!bio->bi_vcnt)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6ea14d07dc618..2dc3c26cf870e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -233,32 +233,48 @@ static void iomap_dio_done(struct iomap_dio *dio)
 void iomap_dio_bio_end_io(struct bio *bio)
 {
 	struct iomap_dio *dio = bio->bi_private;
+	bool should_bounce = (dio->flags & IOMAP_DIO_BOUNCE);
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 
 	if (bio->bi_status)
 		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
 
-	if (atomic_dec_and_test(&dio->ref))
-		iomap_dio_done(dio);
-
-	if (should_dirty) {
+	if (should_bounce) {
+		bio_iov_iter_unbounce(bio, !!dio->error, should_dirty);
+		bio_put(bio);
+	} else if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
 		bio_put(bio);
 	}
+
+	if (atomic_dec_and_test(&dio->ref))
+		iomap_dio_done(dio);
 }
 EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
 
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 {
 	struct iomap_dio *dio = ioend->io_bio.bi_private;
+	bool should_bounce = (dio->flags & IOMAP_DIO_BOUNCE);
 	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
 	u32 vec_count = ioend->io_bio.bi_vcnt;
 
 	if (ioend->io_error)
 		iomap_dio_set_error(dio, ioend->io_error);
 
+	if (should_bounce) {
+		bio_iov_iter_unbounce(&ioend->io_bio, !!dio->error,
+				should_dirty);
+		bio_put(&ioend->io_bio);
+	} else if (should_dirty) {
+		bio_check_pages_dirty(&ioend->io_bio);
+	} else {
+		bio_release_pages(&ioend->io_bio, false);
+		bio_put(&ioend->io_bio);
+	}
+
 	if (atomic_dec_and_test(&dio->ref)) {
 		/*
 		 * Try to avoid another context switch for the completion given
@@ -276,13 +292,6 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
 		iomap_dio_done(dio);
 	}
 
-	if (should_dirty) {
-		bio_check_pages_dirty(&ioend->io_bio);
-	} else {
-		bio_release_pages(&ioend->io_bio, false);
-		bio_put(&ioend->io_bio);
-	}
-
 	/*
 	 * Return the number of bvecs completed as even direct I/O completions
 	 * do significant per-folio work and we'll still want to give up the
@@ -334,6 +343,65 @@ static inline bool iomap_dio_can_use_fua(const struct iomap *iomap,
 	return !bdev_write_cache(iomap->bdev) || bdev_fua(iomap->bdev);
 }
 
+static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
+		struct iomap_dio *dio, loff_t pos, unsigned int alignment,
+		blk_opf_t op)
+{
+	unsigned int nr_vecs;
+	struct bio *bio;
+	ssize_t ret;
+
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		nr_vecs = bio_iov_bounce_nr_vecs(dio->submit.iter, op);
+	else
+		nr_vecs = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
+
+	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs, op);
+	fscrypt_set_bio_crypt_ctx(bio, iter->inode,
+			pos >> iter->inode->i_blkbits, GFP_KERNEL);
+	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
+	bio->bi_write_hint = iter->inode->i_write_hint;
+	bio->bi_ioprio = dio->iocb->ki_ioprio;
+	bio->bi_private = dio;
+	bio->bi_end_io = iomap_dio_bio_end_io;
+
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
+	else
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+					     alignment - 1);
+	if (unlikely(ret))
+		goto out_put_bio;
+	ret = bio->bi_iter.bi_size;
+
+	/*
+	 * An atomic write bio must cover the complete length.  If it doesn't,
+	 * error out.
+	 */
+	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
+		ret = -EINVAL;
+		goto out_put_bio;
+	}
+
+	if (dio->flags & IOMAP_DIO_WRITE)
+		task_io_account_write(ret);
+	else if ((dio->flags & IOMAP_DIO_DIRTY) &&
+		 !(dio->flags & IOMAP_DIO_BOUNCE))
+		bio_set_pages_dirty(bio);
+
+	/*
+	 * We can only poll for single bio I/Os.
+	 */
+	if (iov_iter_count(dio->submit.iter))
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
+	iomap_dio_submit_bio(iter, dio, bio, pos);
+	return ret;
+
+out_put_bio:
+	bio_put(bio);
+	return ret;
+}
+
 static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -342,13 +410,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf = REQ_SYNC | REQ_IDLE;
-	struct bio *bio;
 	bool need_zeroout = false;
-	int ret = 0;
 	u64 copied = 0;
 	size_t orig_count;
+	unsigned int alignment;
+	ssize_t ret = 0;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
+	alignment = bdev_logical_block_size(iomap->bdev);
+	if ((pos | length) & (alignment - 1))
 		return -EINVAL;
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
@@ -427,68 +496,27 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	}
 
 	do {
-		size_t n;
-
 		/*
 		 * If completions already occurred and reported errors, give up now and
 		 * don't bother submitting more bios.
 		 */
-		if (unlikely(data_race(dio->error))) {
-			ret = 0;
+		if (unlikely(data_race(dio->error)))
 			goto out;
-		}
 
-		bio = iomap_dio_alloc_bio(iter, dio,
-				bio_iov_vecs_to_alloc(dio->submit.iter,
-						BIO_MAX_VECS), bio_opf);
-		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
-					  GFP_KERNEL);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = inode->i_write_hint;
-		bio->bi_ioprio = dio->iocb->ki_ioprio;
-		bio->bi_private = dio;
-		bio->bi_end_io = iomap_dio_bio_end_io;
-
-		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
-				bdev_logical_block_size(iomap->bdev) - 1);
-		if (unlikely(ret)) {
+		ret = iomap_dio_bio_iter_one(iter, dio, pos, alignment, bio_opf);
+		if (unlikely(ret < 0)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
 			 * through to the sub-block tail zeroing here, otherwise
 			 * this short IO may expose stale data in the tail of
 			 * the block we haven't written data to.
 			 */
-			bio_put(bio);
-			goto zero_tail;
-		}
-
-		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
-			/*
-			 * An atomic write bio must cover the complete length,
-			 * which it doesn't, so error. We may need to zero out
-			 * the tail (complete FS block), similar to when
-			 * bio_iov_iter_get_pages() returns an error, above.
-			 */
-			ret = -EINVAL;
-			bio_put(bio);
-			goto zero_tail;
+			break;
 		}
-		if (dio->flags & IOMAP_DIO_WRITE)
-			task_io_account_write(n);
-		else if (dio->flags & IOMAP_DIO_DIRTY)
-			bio_set_pages_dirty(bio);
-
-		dio->size += n;
-		copied += n;
-
-		/*
-		 * We can only poll for single bio I/Os.
-		 */
-		if (iov_iter_count(dio->submit.iter))
-			dio->iocb->ki_flags &= ~IOCB_HIPRI;
-		iomap_dio_submit_bio(iter, dio, bio, pos);
-		pos += n;
+		dio->size += ret;
+		copied += ret;
+		pos += ret;
+		ret = 0;
 	} while (iov_iter_count(dio->submit.iter));
 
 	/*
@@ -497,7 +525,6 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	 * the block tail in the latter case, we can expose stale data via mmap
 	 * reads of the EOF block.
 	 */
-zero_tail:
 	if (need_zeroout ||
 	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
 		/* zero out from the end of the write to the end of the block */
@@ -644,7 +671,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = 0;
+	dio->flags = dio_flags & IOMAP_DIO_BOUNCE;
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4e2e3aed32f5f..fca0dfcd5a522 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -269,7 +269,8 @@ struct bio {
 };
 
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
-#define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
+#define BIO_MAX_SIZE		UINT_MAX
+#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> SECTOR_SHIFT)
 
 static inline struct bio_vec *bio_inline_vecs(struct bio *bio)
 {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8c..c536e659970b2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -518,6 +518,15 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Bounce buffer instead of using zero copy access.
+ *
+ * This is needed if the device needs stable data to checksum or generate
+ * parity.  The file system must hook into the I/O submission and offload
+ * completions to user context for reads when this is set.
+ */
+#define IOMAP_DIO_BOUNCE		(1 << 4)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.53.0

