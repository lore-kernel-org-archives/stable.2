Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.250
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047477;
	b=B6I2+uA/NZoza+E/AQk0OI9GW6kEduObyCsPc1sp7k2dfjOryot6WuGItO17M2H6IByU
	 pTiXZ7h8AoQyo4n1mZJtRIWr/aqO/6BtciRghD+J+8evNWA+mpJHQtS4wDJfb99HAWq2/
	 wfcttI7Uyt9wRu3FRcf9nm4FnQUK7/10h13fUocLBPVU3wsLSz+9h4Ib+d/ML/Hhe7p4I
	 UMSuQzWYZpEeIYMHzbUXAW8HrJ4/8M3mPeY9bMMSoPsWjaJrwvNPqFN+/TlBAjulm48Zo
	 DRwWyAX+AfjPnuV+3JnGBvKQIGmo0kqDP0EfRtklY0e5maWLlAG4dDQU0QGq05aDIgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047477;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rpCUv8SpWlf4Vxz+l8m++vebqQBTHUXPNB3+3E0LTf0=;
	b=Wf4LLF1WoU6xTsjO2Y7VZX7QfHoghPEvsgXLZQMbmHYsVIKLh97ABSFKVlZLStdIQApb
	 G3w8Hyjyj2W6of0RdA0Z1khDXApzKnkHgUq/o4jWzWEDzP/NnPPa3WXZG5EVwGFM0f3Dy
	 XWARgA/dFYs55ucWxipE9q0K0epQQbVepIHqaeHuS0x8qUu7oN5yPcSvnjH7hvKy/yt5r
	 8fUbyQtnxEiJjsq2jliBuplP1w5gYnCwMGl+xBXNz9G4gx3lUp1cL2V8k3XBcS32vVUK7
	 Kc4B9Po05eugSMiPxY2K+5GZxBKyuu+wd2LIEO9p/XiSnIt7gb5PEsL8X3kFziilvlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goH6zX3k;
	arc=none smtp.remote-ip=91.218.175.250
Received: from mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC1606D818
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFC1606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goH6zX3k
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=M2NYD96+5Wc5vXUg80X/Ev4VTK5SZphvkdZaEd0yv3E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794047474; v=1; x=1794652274;
 b=goH6zX3kJULkGcSUTnu3iKuMNYYxmeK0jgaWApvpqaS7x10Lk93m6/LAmu+iGsuRwtQxgPVR
 mFIVBKn10uh1X5nrNqtEY0xlApw4fX6uXZYl2wlC7r34ktrGHmtlWVMDl73XfmS4ZpSkDNhQot6
 X6j/ha0BlJUM9KPInURyp70g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f6c06557ed320a8a;
	Sat, 07 Nov 2026 10:31:14 +0000
X-Mizu-Trace-ID: f6c06557ed320a8a
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
Subject: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated HugeTLB folios
Date: Sat,  7 Nov 2026 18:30:46 +0800
Message-ID: <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794046188.git.zhengqi.arch@bytedance.com>
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
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
index 2b405cce2ca5c..f41701c603500 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
 
 #ifdef CONFIG_MIGRATION
 
+bool folio_is_longterm_pinnable(struct folio *folio)
+{
+#ifdef CONFIG_CMA
+	int mt = folio_migratetype(folio);
+
+	/* These HugeTLB folios own the CMA memory, so they can be long-term pinned. */
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

