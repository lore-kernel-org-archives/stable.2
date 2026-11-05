Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851699;
	b=rrlmLV9Noj4vH85qkk1P2yRyYT15wRbfMuxixFGp1lZAncDpXf/048z7wiRwNQ/SY40M
	 +LXJs2PQ6YVjvfUItUrswtz6AcmuxLUbgB3Go6u0guV6fVqb+ZwYsbcIpuAl7rGm8i88r
	 BdsXittgn1PSQ9MvL1dHIVWlduchY1ICAXkoz0ypPmIRupMkmy9dBSDu5SAQfgdf7s0Sy
	 BWLlCH+59d0sxvScheY/RksC+ZRLNpNEvH1ZfzewuePrJ4T25TdtOW578AN6w3lQ+dfGD
	 n95B0qfpTTh4bgtZAsLTR0QyDJukhepHU/xnXsCB/jiuJmvOLwhsc28JxiY0rCdqOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851699;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aJetv9gsmmnmnV9q8LEnj+wemQmADoMIaP9jBgFO/tw=;
	b=Vpxf+w57DqzozDxQX69cAW7LMr6wYpa/yahsIg54SM6UMyq1w6lbBQwCk2u7Ih46OcY6
	 qVKUphpdxVFf/JImkqlzOWglcwFFJ57LZi9pwbRMQQ5CIicdir8kIXxO4mqb8r/6A01lx
	 S4gV/NJCsyboGinBAlbwH+uI2gy1TtFMwI1kZBafqotwZyxjFN0nLKbBO3pYC2yV74Fpv
	 J3dqk0Ab/TKlOVsvRxcFlrxoefpu3zXzg0MTCkC+zvp6EeRhTnxBRgWjUaeCf6+kX4qlF
	 DwYDU9XWpHUYdGZRKtUwMqwCknazDmhW/JUjwFXVzF8NLZvJwoW2bzTKRIoBXL+3GPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EXRehdN2;
	arc=none smtp.remote-ip=91.218.175.17
Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B0606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EXRehdN2
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+nhXIamvv3Am8WQ7F+MsP4U9866XHjUQ2s9N3mrZOqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793851696; v=1; x=1794456496;
 b=EXRehdN2llpxEV7m3HcuHX21bBg0TSBlMztshY4G/+TXSdYUGVyDfdDMkb0/r1oAke/nKNOV
 yPvZG/YSztZQ0Zqfwuji69JOy9PpIX9QlUpJ7YJWPfAGRS++aPPW4hD5ezP+2GhtMWv4GrWykpP
 q295sbxL5kxQde23YnYWZoxQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3bb4d45316ac74d8;
	Thu, 05 Nov 2026 04:08:16 +0000
X-Mizu-Trace-ID: 3bb4d45316ac74d8
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] mm: gup: allow long-term pins of CMA-allocated HugeTLB folios
Date: Thu,  5 Nov 2026 12:07:44 +0800
Message-ID: <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793850539.git.zhengqi.arch@bytedance.com>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
unpinnable, causing unnecessary migration or pinning failures.

These folios already own their CMA bitmap ranges, and memory blocks
overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
HPG_cma to be pinned directly, including in ZONE_MOVABLE.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: stable@vger.kernel.org
Suggested-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h | 29 +----------------------------
 mm/gup.c           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2d0b8a4c9974f..75dd40265d3f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct folio *folio)
 	return is_zero_page(&folio->page);
 }
 
-/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
-static inline bool folio_is_longterm_pinnable(struct folio *folio)
-{
-#ifdef CONFIG_CMA
-	int mt = folio_migratetype(folio);
-
-	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
-		return false;
-#endif
-	/* The zero page can be "pinned" but gets special handling. */
-	if (is_zero_folio(folio))
-		return true;
-
-	/* Coherent device memory must always allow eviction. */
-	if (folio_is_device_coherent(folio))
-		return false;
-
-	/*
-	 * Filesystems can only tolerate transient delays to truncate and
-	 * hole-punch operations
-	 */
-	if (folio_is_fsdax(folio))
-		return false;
-
-	/* Otherwise, non-movable zone folios can be pinned. */
-	return !folio_is_zone_movable(folio);
-
-}
+bool folio_is_longterm_pinnable(struct folio *folio);
 #else
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 2b405cce2ca5c..e8503141bb275 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
 
 #ifdef CONFIG_MIGRATION
 
+bool folio_is_longterm_pinnable(struct folio *folio)
+{
+#ifdef CONFIG_CMA
+	int mt = folio_migratetype(folio);
+
+	/* Explicit HugeTLB CMA allocations own their bitmap ranges. */
+	if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
+		return true;
+
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+		return false;
+#endif
+	/* The zero page can be "pinned" but gets special handling. */
+	if (is_zero_folio(folio))
+		return true;
+
+	/* Coherent device memory must always allow eviction. */
+	if (folio_is_device_coherent(folio))
+		return false;
+
+	/*
+	 * Filesystems can only tolerate transient delays to truncate and
+	 * hole-punch operations
+	 */
+	if (folio_is_fsdax(folio))
+		return false;
+
+	/* Otherwise, non-movable zone folios can be pinned. */
+	return !folio_is_zone_movable(folio);
+}
+
 /*
  * An array of either pages or folios ("pofs"). Although it may seem tempting to
  * avoid this complication, by simply interpreting a list of folios as a list of
-- 
2.54.0

