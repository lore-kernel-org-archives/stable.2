Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF642902C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926276; cv=none; b=R1UYEZ7nCYDJXY6z7OaFYfM4899/Gt3DPBxXEHLZ0N2ga486oS8tSp+9tGkTscYuP7N98MKaM5cZK70T1NyYSFWvFf+ABcqaW1od+G3QyDP8Gm3diM3hNFzlJX0yWxPbnivKhNF57XiOYqwwHZ0sclG9NcXN+NkXVzWbUdybcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926276; c=relaxed/simple;
	bh=ZFBbFTMC7wSj1pMVI+p+Wl7hxRwcDsJIRVtqqT1sS68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxRg+Q1dfjZN2j669MdVr1fjpHZEZ8xDqmJDO1R8tBnB8L397tez3S+hiXcE8Uj/2YJNyXVTYIq08QdbxOp17d9s4mHTEuGDDAahCN18K6JqTe82dFCKT1XVHG9D/wIbi0DaZ/sGgMCmiotQceC5l8PSoeur/Opps3jjZCttx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxTWC1CS; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxTWC1CS"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347866278b6so2778727eec.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790926274; x=1791531074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsLYGjShPtiiH52PUv85LU1cMxKjqepVYNFiRNQ0vZw=;
        b=dxTWC1CSngbzat/ZtfD0ttYViQIp/WL7VhCMxysGTPiUF/CbOsOezyMSbjMhB9qOp6
         Z1lJcx5/yJ7F6wSUnkg/+Kj+c96yAJoLCNmmU/uhjbelS2vH+bnXhLVHVlxf/NiC8PqZ
         sPB05Bkcze//qGFCym3tqpM2kYkYAQFYRCoCxN1rJKgMvbuk5ao4VrR4nfb0WbOpImk+
         Un1i1GFUh1ANaF63fFkv2EFUO3Ocy584lSkEEHwlnUhknSf/zStuJPwutTESyBORwTvb
         cR+e/iA4YRUZZsFV7lR0zvsoxWdMlInx4YoY3+KniTqOQO41BVqJKeCbuk3E2IAcxbIz
         KjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926274; x=1791531074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsLYGjShPtiiH52PUv85LU1cMxKjqepVYNFiRNQ0vZw=;
        b=T5gxPvuW5M6Vq8p4bdPnfO2yLkRdWU2IM8vpaDOMzjoMfwb+OcGDICy2bH/syXVb1M
         KIauzD+SGKLVj4LOD2SEVS76aqSm9DSxNYRzxIBefx8mGzBmJDhTEjfHVEwKieRocTjc
         2oasuJrK5YdKvU9d2deaOX2E+rxJ7u0TKJxRNOmuHia88yIWdjvvQ8OzQPgg5RtzjG/O
         rQpMp8LL4x76k5oOzdKz4d7dR4GV/ieP1mlK5mN94kyEhNMtup8f9YtV1mu+tw2szKR1
         ycohjZvbXRFvFIBM0p+kLfKv+X+YSqhn514ZYk79UYAWC707fQ2y4irhNr2bFqFVc8Dm
         nsug==
X-Forwarded-Encrypted: i=1; AKwUvBxwLfKy7fDqUHYcQQlHDH4xnfGJBZuq+VyCwlNhuUgqQhEBf77HgmvtIulNu3YbAPA7g4j5tsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLr5z/z/PhrHX6t4MDw0cRah5Sutay1NQNTHnhqwJL3RWuZ8zis
	K6vR+RUCI1AXea4D0hCxlMjPEjo1kQ9YEK5gJu7fpzxxdl7+V+bhEjMQ
X-Gm-Gg: AYBFou2tHa1Vh6N0tIf8VLtUF2m4sRqfDLrKrVx8jvcErtukJRv2KDngJqGwRjhj/0u
	YzgyOWuiZAWL0VyShc26BHA1nbsWfd3WqLQNDboL5+t7BGQsRQZqZ+mcwtkMzFfFCL/xEYCeYJv
	nj2me/F8DYJsNODeSVaIfAEKXMnTXbtvNhU98x8OqaGZQCF/WZQGj9VgQugsjrq14bjgFhJ7iqz
	BkzANW2netoJ9ZHtK24bZnU+Z9Kx2oHUct2dFOZkbCklyZn3gR6Zzhy7h7fbsN+FirngzyHafHn
	afwKAtHxNEqeB7HqrsGVpFbzRMagJ3kmGMagOLfzvcqN7ttc9fl7zEOKHRR7qGGtBfQpwBEnRTS
	gnqp8WXeVFU7E/5qNIXl6tR35oPtCTZRRm4UrhXWxWRwmZdHdRGr+sN+KLLp+OW4GUTys4HT1lR
	HmD4XrNflytOi5ie02eDs3VtUATRIYBJ/J4QojYqYQDIj4nUCAHKTC/IsepBUxO+m//izbc5I+8
	yCXizLUtsd2VUPhpjg2ZWZRZJFN/t31LWFdazQVRRpOHbz+jtgNdS0yy0Z6OcYgMrb8ck9Hptwl
	acDPqW2yUtR684SvKVEb90pqWwSubUCyLTozwvqT2HnbnoEVoxbTsikqOag=
X-Received: by 2002:a05:7301:1a11:b0:327:c036:1c7a with SMTP id 5a478bee46e88-34f15077dcfmr1779187eec.10.1790926272837;
        Fri, 02 Oct 2026 00:31:12 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fdb478sm3912341eec.22.2026.10.02.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:31:12 -0700 (PDT)
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
Subject: [PATCH] drm/i915: look up shmem folios by index for writeback
Date: Fri,  2 Oct 2026 15:31:07 +0800
Message-ID: <20261002073107.2209644-1-matthias.goergens@gmail.com>
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

Go back to walking the object by index, with the folio API.  Mapped
folios are still skipped.  Unlike the old loop, do not wait for a folio
lock, since this also runs from the OOM notifier; a locked folio is left
to reclaim.  shmem_write_folio() returns with the folio unlocked except
for AOP_WRITEPAGE_ACTIVATE, so unlock it only in that case.  It may
also split a large folio, so read the folio size only after writing, to
find the next index.

I came across this while measuring an earlier patch of mine to this
loop, which changed nothing because the loop never visits a folio.
This patch was measured without Intel hardware, with a test-only mock
selftest in a QEMU guest with swap.  Dirty, unpinned objects of 1 to
256 MiB, with and without THP, went through i915_gem_shrink() with
I915_SHRINK_WRITEBACK.  Before this patch, no page was written in any
case; with it, every page that was not mmapped was.  The contents read
back intact after swap-in, and the mock selftests give the same results
as before.  This has not been tested on hardware.

Fixes: 776a853a43c9 ("i915: Use writeback_iter()")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This replaces my two earlier patches to this loop, which can be dropped:
the loop they change never visits a folio.

https://lore.kernel.org/all/20260915062924.2410550-1-matthias.goergens@gmail.com/
https://lore.kernel.org/all/20260914105606.3997649-1-matthias.goergens@gmail.com/

In 6.18.y and 7.2.y the call is shmem_writeout(folio, NULL, NULL)
instead of shmem_write_folio(folio), with the same return convention.

In review of 776a853a43c9, Christoph asked for this loop to move behind
a shmem API instead of living in drivers, and Matthew agreed:

https://lore.kernel.org/all/Z--XtaM7Z3zbjzAu@infradead.org/
https://lore.kernel.org/all/Z-_hQwNeiOnNYJVp@casper.infradead.org/

I kept this fix inside i915 so that it is one patch for stable.

The test harness is not part of the patch; I can post it if that helps.
Testing on Intel hardware under memory pressure would be very welcome.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 56 ++++++++++++++++++-----
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index ef9440166295..54424e434f3b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -304,28 +304,60 @@ shmem_truncate(struct drm_i915_gem_object *obj)
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
+	pgoff_t nr_pages = size >> PAGE_SHIFT;
+	pgoff_t index = 0;
 
 	/*
+	 * shmem marks folios dirty with noop_dirty_folio(), which does not
+	 * set PAGECACHE_TAG_DIRTY, so writeback_iter() would find none of
+	 * them.  Look up each folio of the object by index and test its
+	 * dirty flag.
+	 *
 	 * Leave mmapings intact (GTT will have been revoked on unbinding,
 	 * leaving only CPU mmapings around) and add those folios to the LRU
 	 * instead of invoking writeback so they are aged and paged out
 	 * as normal.
 	 */
-	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
-		if (folio_mapped(folio))
-			folio_redirty_for_writepage(&wbc, folio);
+	while (index < nr_pages) {
+		struct folio *folio;
+
+		/*
+		 * Skip folios that are absent or locked: this runs from the
+		 * shrinker and the OOM notifier, so do not wait for a lock.
+		 */
+		folio = __filemap_get_folio(mapping, index,
+					    FGP_LOCK | FGP_NOWAIT, 0);
+		if (IS_ERR(folio)) {
+			index++;
+			continue;
+		}
+
+		index = folio->index;
+		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio))
+			shmem_writeback_folio(folio);
 		else
-			error = shmem_write_folio(folio);
+			folio_unlock(folio);
+
+		/* Writing may have split the folio, so read its size only now. */
+		index += folio_nr_pages(folio);
+		folio_put(folio);
 	}
 }
 

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.56.0

