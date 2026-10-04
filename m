Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AA190462
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107316; cv=none; b=KyH5VmkyBaMcKknInhGPnnQsK7BMXmhExkzP/Gm+DEpTtAHalW1/5O1iM4f5MuHqRrV/OsB4JO9M5SeJXTx06Cyg76LEmvLGUanPBFdrqkzswwUHPY+ChXeiEADBK28+YR96htrCC3Xkjqka2ttWp4RYYiXDWyl+a6gPRXgQ4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107316; c=relaxed/simple;
	bh=CswC78lXz1dzqRZXt3vONvAE+iE7J82ekn9D2HnfSro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pW/8dSdNjXTctmnC4X+AQkHoGQwus3bGmewKmUlWmwQBwlXLrHB3yHjIeeKg6YsBAZTjDg+jtJAUfiBbW7TcUfvK+671DFwnhU2SN7aKB9zT/rXG5ZatvB0Hsro16uhfoy1iQ0x9JzpB/q+DrIMp+MJvMk61qbju4Kp0o5KT6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9I1avs1; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9I1avs1"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1230020eec.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791107312; x=1791712112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/M/uzbIn435hHdgJL6sjcq8jBzkdOxqOZH69iw0GIc=;
        b=a9I1avs1FwylhUv249MHvn1IsEzVB048ZNaGbiz+KniqiF/CMbuHEnckFxi/BQWSE0
         JAB39wzw02aJ7+DtReqzOaknTeDmG9S0PqcNo2D5OYnZnK4ZoAD8OaIfGHFSfwXM5o4K
         A092RRRdwCYmdMeGAZhGFzUMecfHnSMPgywFKs1WmsKIkw3Fv78M/2xLux4yvoJKG3e1
         4guEkNKtleqySFtE3Y7lk9DVLOKiH8eTy1OBfJMNeMHC26roTcgXexWUyLw0z1UToKxT
         aS/lfeDjEhDagv12EbHtF1GNOmsM49Adn7j79fX54CP5+NdCYVc/i2LZTEXnUOrwEkcq
         R7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791107312; x=1791712112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G/M/uzbIn435hHdgJL6sjcq8jBzkdOxqOZH69iw0GIc=;
        b=EkXiu58heBcaNZieLqCSMyk9jbBwNlAO9HntKU9NYj/F4GQq8ZASdpPiyXiB5/o3vy
         xlSywckKMVtvO7PluNBJYtOUQOQaRxiJd9MU6pmPWHxUW/qEVUoLfT0ODiDdmSqn8gCA
         OS7vTLy2eGEeJJdR2tkpseQQEe4/Rx0oQyWUTRMKqcGmtc5xfIKa4NKJnd9/NQPm8qKI
         JyS02tyuzTVQH/KhQyK6Gy+3d8KBq7+niecDPUZJ71fgo1ECfmcS28ausZPyDQy7lnoM
         lO/EXqQwxCYbT6RBPSl/TfuW2SQs0+mRDx0WCFgwaPmah20JE/qwgDCYICFbZRArP4+Y
         CiRw==
X-Forwarded-Encrypted: i=1; AKwUvBzH/9X8pIUxyVNw3TCaYBqfbiT42sicia+CXRf7rcCJ/ej9dMrcPiWAeSJQZ1ctNPToysiwduU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdtdvfY0kWRKf/iAUDbM6S7C0uMf1ky9ldr8zhizAxhlQHfeLM
	gxDdA58cUccyo1DgF+4iiMxxTSEJYAkx5k9gD7oHl43XIRVwP1HNNpM1
X-Gm-Gg: AYBFou22DEdLy7P9tY7YB+inci5BN168gNggL4n/JoRR6K6M1aJyob3CDfxpz9TB03L
	5s4nvW4qShKtMvqkK41pBCX3EwTeAaIWL9N6vYt5G5viu4wl/nBT4OZ3PFX/p/Cwnzu4fqOQczi
	rtLQPeoRVq74vv+3NRar2ElZ9LiP4qTn47PmfUBvMNZLxg2HofE0ZOkwWNLHVIoqiC85hTw2OE5
	wrdRNN6TY9Cua489wY/mNu1L54w+1Fi0SGKvcCsZwh9cIXL8jxUCtVh/YoU/N5P/aySGc7nmdeB
	43xFz/ORbLauRBP5ZOdDqQ7WnPXfMKsBQfu1ThQP3Pbw5c6Qs4Kh+8+HFaL9mvm8rO66cwYziuz
	MzZRe0O1XhJyOlQfCInUuzvO0/kjWdVp/ARMDCOZ5FXnSpXu8HiDNmrfNVord0CFG6/AaDBTcI3
	vT7Em3Wj2DiJxgYhBl10tzAVX/AliW2d80ybNRMY4fsc2cti/nKKGE1LCyqZhnm3g2LJs1cb437
	9Z9x1ZHNHkOTrw7quA9FNtV2ZAMlBHzcLmxPxTxuW7ivnCb5slcMGLbS1ZlYa25AkGkaZh0/K8M
	8BIrdSVZwgusn0iZnsEamNDj387sWyv037NlQBY81XZr1+TJ2yyQdERR1CA=
X-Received: by 2002:a05:693c:87d5:10b0:34b:e2cf:43b6 with SMTP id 5a478bee46e88-34f14f2b9edmr9396416eec.2.1791107311900;
        Sun, 04 Oct 2026 02:48:31 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127136b8esm3623589eec.6.2026.10.04.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:48:31 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915: look up shmem folios by index for writeback
Date: Sun,  4 Oct 2026 17:48:27 +0800
Message-ID: <20261004094827.174193-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 776a853a43c9 ("i915: Use writeback_iter()"),
__shmem_writeback() starts writeback on no folios at all.  In
WB_SYNC_NONE mode writeback_iter() only returns folios tagged
PAGECACHE_TAG_DIRTY, and shmem never sets that tag: it dirties folios
with noop_dirty_folio(), because shmem relies on LRU-based swap writeout
rather than on the dirty tag (see the comment in __folio_mark_dirty() in
mm/page-writeback.c).  The loop before that commit looked pages up by
index and tested the page dirty flag, so it did write.

This affects the shrinker's I915_SHRINK_WRITEBACK pass and the i915 TTM
backend, which both call __shmem_writeback().  The pages stay dirty and
on the LRU, so reclaim still swaps them out later; what is lost is the
early writeback.

Go back to looking up the folios of the object by index, in batches
with filemap_get_folios(), and reschedule between batches, as
writeback_iter() does.  Mapped folios are still skipped.  Unlike the old
loop, do not wait for a folio lock, since this also runs from the OOM
notifier; a locked folio is left to reclaim.  shmem_write_folio()
returns with the folio unlocked except for AOP_WRITEPAGE_ACTIVATE, so
unlock it only in that case.  It may also split a large folio and leave
the rest of it dirty, so look the rest up again.

I came across this while measuring an earlier patch of mine to this
loop, which changed nothing because the loop never visits a folio.
This patch was measured without Intel hardware, with a test-only mock
selftest in a QEMU guest with swap.  Dirty, unpinned objects of 1 to
256 MiB, with and without THP, went through i915_gem_shrink() with
I915_SHRINK_WRITEBACK.  Before this patch, no page was written in any
case; with it, every page that was not mmapped was, also when swap-out
split the large folios.  The contents read back intact after swap-in,
and the mock selftests give the same results as before.  This has not
been tested on hardware.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
v1: https://lore.kernel.org/all/20261002073107.2209644-1-matthias.goergens@gmail.com/

Changes in v2:
- Look the folios up in batches with filemap_get_folios() and call
  cond_resched() between batches, instead of one __filemap_get_folio()
  call per index with no rescheduling, which Sashiko pointed out:
  https://lore.kernel.org/all/20261002091439.59C611F00899@smtp.kernel.org/
  Measured with the same test-only harness in the same guest, v1 against
  v2: on a fully populated 1 GiB object, the longest time the walk ran
  without reaching cond_resched() went from about 85 ms to under 0.1 ms;
  on a 3 GiB object (786432 pages) with 1% of its pages present and the
  rest holes or swapped out, one call made 255 filemap_get_folios()
  calls instead of 786432 __filemap_get_folio() calls.  A run of swap
  entries is still stepped over inside a single filemap_get_folios()
  call: about 2 ms for a fully swapped-out 3 GiB object.  I did not split
  the range further, since every page of the object was in memory until
  just before this runs, so holes and swap entries are the exception.
- A batch is looked up ahead of the writes, so if writing splits a
  large folio, look the rest of it up again (v1 got this by reading the
  folio size after the write).

This replaces my two earlier patches to this loop, which can be dropped:
the loop they change never visits a folio.

https://lore.kernel.org/all/20260915062924.2410550-1-matthias.goergens@gmail.com/
https://lore.kernel.org/all/20260914105606.3997649-1-matthias.goergens@gmail.com/

In 6.18.y and 7.2.y, the maintained stable trees that have
776a853a43c9, the call is shmem_writeout(folio, NULL, NULL) instead of
shmem_write_folio(folio), with the same return convention.

In review of 776a853a43c9, Christoph asked for this loop to move behind
a shmem API instead of living in drivers, and Matthew agreed:

https://lore.kernel.org/all/Z--XtaM7Z3zbjzAu@infradead.org/
https://lore.kernel.org/all/Z-_hQwNeiOnNYJVp@casper.infradead.org/

I kept this fix inside i915 so that it is one patch for stable.

The test harness is not part of the patch; I can post it if that helps.
Testing on Intel hardware under memory pressure would be very welcome.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 70 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..d2077b823b1b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -304,28 +304,72 @@ shmem_truncate(struct drm_i915_gem_object *obj)
 	return 0;
 }
 
+/* Start writing a locked folio to swap.  It is unlocked on return. */
+static void shmem_writeback_folio(struct folio *folio)
+{
+	int ret;
+
+	folio_set_reclaim(folio);
+	ret = shmem_write_folio(folio);
+	if (!folio_test_writeback(folio))
+		folio_clear_reclaim(folio);
+
+	/* shmem_write_folio() unlocks the folio unless it returns this. */
+	if (ret == AOP_WRITEPAGE_ACTIVATE)
+		folio_unlock(folio);
+}
+
 void __shmem_writeback(size_t size, struct address_space *mapping)
 {
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = SWAP_CLUSTER_MAX,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-	};
-	struct folio *folio = NULL;
-	int error = 0;
+	pgoff_t last = (size >> PAGE_SHIFT) - 1;	/* last page, inclusive */
+	struct folio_batch fbatch;
+	pgoff_t index = 0;
+	unsigned int i;
 
 	/*
+	 * shmem marks folios dirty with noop_dirty_folio(), which does not
+	 * set PAGECACHE_TAG_DIRTY, so writeback_iter() would find none of
+	 * them.  Look up the folios of the object in batches and write out
+	 * the dirty ones.
+	 *
 	 * Leave mmapings intact (GTT will have been revoked on unbinding,
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
 	 */
-	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
-			folio_redirty_for_writepage(&wbc, folio);
-		else
-			error = shmem_write_folio(folio);
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &index, last, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+			long nr_pages = folio_nr_pages(folio);
+
+			/*
+			 * Leave locked folios to reclaim: this runs from the
+			 * shrinker and the OOM notifier, so do not wait for a
+			 * lock.
+			 */
+			if (!folio_trylock(folio))
+				continue;
+
+			if (folio->mapping != mapping || folio_mapped(folio) ||
+			    !folio_clear_dirty_for_io(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
+			shmem_writeback_folio(folio);
+
+			/*
+			 * Writing may have split the folio and left the rest
+			 * of it dirty; look the rest up again.
+			 */
+			if (folio_nr_pages(folio) != nr_pages) {
+				index = folio_next_index(folio);
+				break;
+			}
+		}
+		folio_batch_release(&fbatch);
+		cond_resched();
 	}
 }
 

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.56.0

