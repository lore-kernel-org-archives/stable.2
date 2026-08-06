Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC6499F17;
	Thu,  6 Aug 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054279; cv=none; b=eVlbY0+9t3PO48m53ljwjQqfJP9zw7thSvYo+9hTJrgxMrlBfGI3jClk2aHpNhDhLs8lruVvJS8GhLDjilD4l5TnLXQwvLBPcER4+MR2tt5/gyn7rQgjvDvVIWYft9io7IIf+7zhrRj05AAQJThIMHTxDE301krJA3kGb+NfihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054279; c=relaxed/simple;
	bh=ggaa+gmfFIkkiVFF/Ob2FccLorGTeOk5Ry8DwgzH8zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKPIg/MVxcZNGb4ZcQHJyFZxwp68o8tVEBWbnb7podZd94aYHSpNhQ1cfo2Gkq1RSTXaXG3xJycicXh5V5sKg5LynEfmIWETvtHkvBBibGnNDCQxK0nI47wIb0sHRdZDNtaRd8pLEAMw/75l8nJcKAXNdcPmjwp2+XJ5QaqLNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZnkpvn1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZnkpvn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B176A1F00AC4;
	Thu,  6 Aug 2026 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054278;
	bh=yVWHI8/1skgVJ+ec3VtXE3a9tnGijqupyiNVrxJ5Ktc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZnkpvn1X+qHxyThxrT/hCl2xVOfGsW4qmXXMGptuyE/AxJjzpUgj76i8VP+wzB0z
	 nXumiFq0ofUB9MyuvAY1Y1aizHcNpfhLXuXChs+SzFNq9KNdmVwWn8/Vtnr0Tdq0LU
	 MAOddrsRNYV/StfTjNx2UzR37UsjXEc9L/zdo2Tiw/2oGPnFUM5GBExVFhdT9ZLYxY
	 u0Yq1QJyn0wwfKmklFKf04t+64x1yyeEEJIeNf+KtNvY5b1p2tPh1rQijX1ze1N+SY
	 JhgJbi9ie21Ir098or+VjcDv2eKVUYmlUt3ltidFWMs8x3ceOt3ihrrABZjodaYY+6
	 +KOg6rnbMhhUA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] blk-crypto-fallback: Fix deadlock when encrypting large bio in dm layer
Date: Thu,  6 Aug 2026 15:10:31 -0700
Message-ID: <20260806221031.79050-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806221031.79050-1-ebiggers@kernel.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
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
 block/blk-crypto-fallback.c | 70 ++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index bda913c39381..973399011d5a 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -83,6 +83,10 @@ static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
 static struct bio_set enc_bio_set;
 
+static DEFINE_SPINLOCK(enc_rescue_list_lock);
+static struct bio_list enc_rescue_list;
+static struct work_struct enc_rescue_work;
+
 /*
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
  * key, but AES-XTS rejects that key, so we use some random bytes instead.
@@ -175,9 +179,23 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
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
+			       gfp_mask, &enc_bio_set);
+	if (unlikely(!bio))
+		return NULL;
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_private		= bio_src;
@@ -205,11 +223,15 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	 * any non-zero slot already contains a valid allocation.
 	 */
 	memset(pages, 0, sizeof(struct page *) * nr_segs);
-	nr_allocated = alloc_pages_bulk(GFP_NOIO, nr_segs, pages);
-	if (nr_allocated < nr_segs)
-		mempool_alloc_bulk(blk_crypto_bounce_page_pool,
+	nr_allocated = alloc_pages_bulk(gfp_mask, nr_segs, pages);
+	if (unlikely(nr_allocated < nr_segs) &&
+	    !mempool_alloc_bulk(blk_crypto_bounce_page_pool,
 				(void **)pages + nr_allocated,
-				nr_segs - nr_allocated, GFP_NOIO);
+				nr_segs - nr_allocated, gfp_mask)) {
+		free_pages_bulk(pages, nr_allocated);
+		bio_put(bio);
+		return NULL;
+	}
 	*pages_ret = pages;
 	return bio;
 }
@@ -237,6 +259,25 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
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
@@ -271,6 +312,23 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
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
@@ -589,6 +647,8 @@ static int blk_crypto_fallback_init(void)
 	if (!bio_fallback_crypt_ctx_pool)
 		goto fail_free_crypt_ctx_cache;
 
+	INIT_WORK(&enc_rescue_work, blk_crypto_fallback_encrypt_work_fn);
+
 	blk_crypto_fallback_inited = true;
 
 	return 0;
-- 
2.55.0

