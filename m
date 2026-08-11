Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8147799B;
	Tue, 11 Aug 2026 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486031; cv=none; b=XcNS4n5CXJ2e4MsjIph649+7nRAFvmd6fEP2gCJBaRsly7bdu2YE5V0/5wAaOIealf9HIkbIzNwImetPIsAU0wmol/1moUiCeEmFM1lm3OTscaLpvhQhLCg9R4MSAQ7ExGrRy3hykn2srhXC13r6fgFKi2YbrUXfiOCzNFMmQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486031; c=relaxed/simple;
	bh=mnr11I4cFLxTfeqwYU7dSru96fzytYLvc2ztp9nv9RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTUDum6IYJ7wh3+qNZ0QpYvqGT/52F7e/k2n6fMKDSFl1OiRntBwOct/gQL3hmg2yD5WY7BsttaRVNS0hOVnhGHzt5wlgwhzNe9i4N+XoXGKBOBRtwdequddD8HeyQAnTPS3KraE7thDQSmzphnUXtlW6W+ipJUlLeK5TzFzhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7lRVh2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7lRVh2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80161F000E9;
	Tue, 11 Aug 2026 22:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786486030;
	bh=pZc3lJcuznYHnJe1pVV119vmLSoLWOLL0tob4dAdTfk=;
	h=From:To:Cc:Subject:Date;
	b=e7lRVh2HAlqDwn2J4QJRyW8NRkKE3pfQW/40I53spD9lQQDbecMTtljyPtSczmiKD
	 +xpGfh+EepW3ssIFuJdMIHnr0TMSw/gZfR08/yGkiKUqktNSIRriQZVMuV2V6gubWj
	 GF/16ArJiAzD0IqRycBG8qCtI5lSjbW24Mo+34yinWppczssCj73CpEAe0KUh3kgUQ
	 TiAc5pcBhqjZ0BHsq4wkf4eZvSEIwaZai9LgEkDCz2+dVMvZal8vnF+VsV6LvLhZob
	 2XQkczxgibRN+gVxT4HdkAAxqwb1swuuaO6aQiL48dFjYoGGkt+VUSA6ibhJCzrLcb
	 THt2I+wV8fQBw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] blk-crypto-fallback: Fix deadlock when encrypting large bio in dm layer
Date: Tue, 11 Aug 2026 15:03:18 -0700
Message-ID: <20260811220318.58331-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Encrypting a large bio with more than BIO_MAX_VECS pages can still
deadlock, even after it was attempted to be fixed by
commit b37fbce460ad ("blk-crypto: optimize bio splitting in
blk_crypto_fallback_encrypt_bio") and commit 3d939695e682 ("blk-crypto:
use mempool_alloc_bulk for encrypted bio page allocation").

This is because __blk_crypto_fallback_encrypt_bio() assumes that the
bounce bios that it submits will eventually complete, unblocking it from
allocating additional bounce bios and pages.  However, dm-inlinecrypt.c
calls __blk_crypto_submit_bio() from within submit_bio() itself.  In
this case, the recursive submit_bio() simply adds the bounce bio to
current->bio_list without actually submitting it yet.  That breaks the
guarantee that forward progress is being made.

To fix this, allocate the bio and bounce pages with GFP_NOWAIT if
current->bio_list is set.  If it fails, punt the encryption of the
remaining part of the bio to a kworker.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Changed in v2:
- Switched to the less efficient approach preferred by Christoph
- Use BIO_EMPTY_LIST

 block/blk-crypto-fallback.c | 80 ++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a5c52ab74b4..ad4b5ca291c5 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -83,6 +83,10 @@ static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
 static struct bio_set enc_bio_set;
 
+static DEFINE_SPINLOCK(enc_rescue_list_lock);
+static struct bio_list enc_rescue_list = BIO_EMPTY_LIST;
+static struct work_struct enc_rescue_work;
+
 /*
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
  * key, but AES-XTS rejects that key, so we use some random bytes instead.
@@ -172,13 +176,26 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 		unsigned int nr_segs, struct page ***pages_ret)
 {
-	unsigned int memflags = memalloc_noio_save();
 	unsigned int nr_allocated;
 	struct page **pages;
 	struct bio *bio;
+	gfp_t gfp_mask;
+
+	/*
+	 * During recursive bio submission (current->bio_list != NULL) any
+	 * submitted bounce bios just get added to current->bio_list; they
+	 * cannot complete and release resources yet.  Therefore, to avoid
+	 * deadlocks, don't wait indefinitely for additional resources.
+	 */
+	if (current->bio_list)
+		gfp_mask = GFP_NOWAIT;
+	else
+		gfp_mask = GFP_NOIO;
 
 	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
-			GFP_NOIO, &enc_bio_set);
+			gfp_mask, &enc_bio_set);
+	if (unlikely(!bio))
+		return NULL; /* GFP_NOWAIT failure.  Fall back to kworker. */
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_private		= bio_src;
@@ -206,12 +223,27 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	 * any non-zero slot already contains a valid allocation.
 	 */
 	memset(pages, 0, sizeof(struct page *) * nr_segs);
-	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
-	if (nr_allocated < nr_segs)
+	nr_allocated = alloc_pages_bulk(gfp_mask, nr_segs, pages);
+	if (unlikely(nr_allocated < nr_segs)) {
+		unsigned int memflags;
+
+		if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
+			/*
+			 * GFP_NOWAIT failure.  Fall back to kworker, even if
+			 * enough pages are already free in the mempool (since
+			 * mempool_alloc_bulk() doesn't have a no-wait mode).
+			 */
+			free_pages_bulk(pages, nr_allocated);
+			bio_put(bio);
+			return NULL;
+		}
+
+		memflags = memalloc_noio_save();
 		mempool_alloc_bulk(blk_crypto_bounce_page_pool,
 				(void **)pages + nr_allocated,
 				nr_segs - nr_allocated);
-	memalloc_noio_restore(memflags);
+		memalloc_noio_restore(memflags);
+	}
 	*pages_ret = pages;
 	return bio;
 }
@@ -239,6 +271,25 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 		iv->dun[i] = cpu_to_le64(dun[i]);
 }
 
+static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio);
+
+/* Encrypt a list of bios whose encryption was punted to a kworker. */
+static void blk_crypto_fallback_encrypt_work_fn(struct work_struct *work)
+{
+	struct bio_list list;
+	struct bio *src_bio;
+
+	WARN_ON_ONCE(current->bio_list);
+
+	spin_lock(&enc_rescue_list_lock);
+	list = enc_rescue_list;
+	bio_list_init(&enc_rescue_list);
+	spin_unlock(&enc_rescue_list_lock);
+
+	while ((src_bio = bio_list_pop(&list)))
+		blk_crypto_fallback_encrypt_bio(src_bio);
+}
+
 static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		struct crypto_sync_skcipher *tfm)
 {
@@ -273,6 +324,23 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 new_bio:
 	nr_enc_pages = min(bio_segments(src_bio), BIO_MAX_VECS);
 	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_enc_pages, &enc_pages);
+	if (unlikely(!enc_bio)) {
+		/*
+		 * Failed to allocate a bounce bio during recursive bio
+		 * submission.  We might be blocked on bios in current->bio_list
+		 * holding mempool elements.  To enable forward progress, punt
+		 * the remaining encryption work for src_bio to a kworker.
+		 *
+		 * The DUN may have been advanced, so make sure to update it.
+		 */
+		WARN_ON_ONCE(!current->bio_list);
+		memcpy(bc->bc_dun, curr_dun, sizeof(curr_dun));
+		spin_lock(&enc_rescue_list_lock);
+		bio_list_add(&enc_rescue_list, src_bio);
+		spin_unlock(&enc_rescue_list_lock);
+		queue_work(blk_crypto_wq, &enc_rescue_work);
+		return;
+	}
 	enc_idx = 0;
 	for (;;) {
 		struct bio_vec src_bv =
@@ -591,6 +659,8 @@ static int blk_crypto_fallback_init(void)
 	if (!bio_fallback_crypt_ctx_pool)
 		goto fail_free_crypt_ctx_cache;
 
+	INIT_WORK(&enc_rescue_work, blk_crypto_fallback_encrypt_work_fn);
+
 	blk_crypto_fallback_inited = true;
 
 	return 0;

base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0

