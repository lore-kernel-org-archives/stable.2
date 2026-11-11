Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379661;
	b=orKJ8uE6ETFi29e0nGmg+oGkQ3aL7jvdJpTMqQolahBFFyQZXohbvZ5WwKPcqu1KBhm5
	 KgLW52Gnk0s2RImXvVRTQ9MWrECH9B0cy5QsolE/7iAjO2e7uoTBfNOUMAlRm0FRFR8DZ
	 U4tzkXrlpmiTtNC9DD0WXLA9cCzIuaRsm2nBAUWMBtHK2xUfyJB/8e1FPpYvXO3iuC8ip
	 qAse4fnpRRbcs4G9LE25zWgSndBAh95dbrKeLc3nQnMIoDsNMwxuQVP7q3biQatzvAR00
	 JbK050OCPWAtp9MDoiGKEicans8MD6XTr3/YV08za3N1EFnoFu+rEkn+wmZry5cc+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379661;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qywovdRbToMGzmjoli0y7eSQdslGzewck1NjQbLchao=;
	b=iGhCw0X1m3PFaN43cs+HIgyKrRc//01D9AWpz15sul7bVf8e/uVuXiixiWdNp6R1wPg1
	 LAjSK2wPdTjkYzU0D0I9yisN5DnkWxTvPHi8/cO1B7hGO39RH/nLXYGvFVVdUkyhZ+hr8
	 H/+nvQJrBTUp/jaUSUrnpr1GHWTOTTEgCSO/Vaaneu9Kh3uC47LV+YX7RTBeYO1ECmPtq
	 TJBLXQsiCyaZYCT57RCVopyoEqSy849ETLy4bxKRrwl2rAaDGOQw+SkL2znJ2axcwT8wV
	 9aDiParDNMh1bc7Gz+VW5JscLRHaQnfU6wtdS6B9LP7otJDmivtEhjtXUhT9r+nXhog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XJcML6AK;
	arc=none smtp.remote-ip=95.215.58.91
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5DF606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5DF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XJcML6AK
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MlDtQZENV6yVDOEvaF4niEP2XzPBjBwAlns6mA8+YjI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794379658; v=1; x=1794984458;
 b=XJcML6AK9AqE09UAUb7a8ZvOxFUy1m7U4HsxWfw+sEdTNBGqQI11ivE6BHxRFEUVWWmIUpPi
 MNgp/XVG0MSpyEoaVTBC8/AJD/NoT5HrfKKIxsP5LGW1dm175pze2meDLVbCpXAfcLAqRXIVAB+
 J6V0REYE1K5gS+TEtQlXBoE0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7154aaffd6544fb;
	Wed, 11 Nov 2026 06:47:38 +0000
X-Mizu-Trace-ID: d7154aaffd6544fb
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
Subject: [PATCH v4 2/3] mm: gup: allow long-term pins of CMA-allocated HugeTLB folios
Date: Wed, 11 Nov 2026 14:46:51 +0800
Message-ID: <503c9f6d869e3206c6fd591de962c3d619b73825.1794379433.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794379433.git.zhengqi.arch@bytedance.com>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
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
index b0da9be413098..47d1d96bfc7fd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2954,35 +2954,8 @@ static inline bool is_zero_folio(const struct folio *folio)
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
index ebbfee09b7278..fdafc5a1b78ed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2219,6 +2219,37 @@ struct page *get_dump_page(unsigned long addr, int *locked)
 
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

