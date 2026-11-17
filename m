Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908066;
	b=0klbQM5EGzEifjPtdrm7pegK0m9qJ3SZNiPzfKnNloiykzmwKwTAklWwuQR5lUcAwOy8
	 4dS8O09rlaHAa2U/XuB0DLYir0hob76FOcHKVackHv3yJ2GaCYC5QAIOvvXxillmHexFQ
	 PqRsSN7MUzuMLVYKTzZnLByh5G9QnY/JSFOh+uAHpsl7AwJHzY6LUNVJkdvPPZPSc/Jys
	 mDvT6wnsbGAWrjRPpsQVtOWOg+E4owk3MO5oHLy342DIpTPe3Bfe7/QjJhPUOXv2Q5lO/
	 zdcYrc9+NpJkiNo1XyqnPMOvwTrWAPJwhp77faUhFCauQvH2ICWOKBy7olKj1pNU48w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908066;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VVjEArGpfzLKglvqc3YXGN4z2hsAIb4Ii6LC+8XEfek=;
	b=sRgtdHpxuHwgqW+NjOFFNRLopXlqO/NCHDY2y+k43ho+v/Uy/4JynmtI4WAiPcboIHWz
	 ESAhNqsfxROpuNytjke8ChmEKpx58ZYXldmWW+Bn24NBZe/0uSME6zvInxTklqQsfXiwH
	 7dGKlCUTw0TQzLjgU6gU6c4MytDeN4rEkZW57dzvhwQ2jhm0eBC0EeC31d8cYD2NnxoK/
	 hMPjtNsuPr5LthPcTCPoKuskhhPv9g+VmOcZRnJgRKYuIXWe6PPgm2DWNSiOWiro6j4DM
	 QUeEWt4wPAg80ejm3lB5kimmMR+ytZke/Z+piJd/UhyoY7kprR+k+bq/lfYprL6Hr8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H2rKIAAl;
	arc=none smtp.remote-ip=91.218.175.184
Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CED606A334
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CED606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H2rKIAAl
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=osMdup1XthVBj9dZj7BkFJdDR3+5E/Rv1rSyQcK8Jac=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794908063; v=1; x=1795512863;
 b=H2rKIAAlMQX+xCzh2f7B3coiICfjjHHD74cFy+vvnGy5/4q/lmZmoa4yltUK/6GmZoxcZBKv
 snRvvjpQNA05gJ+5hYvefGvVT4s9VH4pZQdVzDgGWD7HpfwmbVq4UAq3ZEKB4Bo/QR25Cq6dr3M
 QggjyDxujfcWLPz/zqmUAbYM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2236bfef0a0d9fc;
	Tue, 17 Nov 2026 09:34:23 +0000
X-Mizu-Trace-ID: e2236bfef0a0d9fc
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev,
	fvdl@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/3] mm: gup: allow long-term pins of CMA-allocated HugeTLB folios
Date: Tue, 17 Nov 2026 17:33:58 +0800
Message-ID: <295af6601ce79f2c2b3dc4352a3279f0e6ac513e.1794907279.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1794907279.git.zhengqi.arch@bytedance.com>
References: <cover.1794907279.git.zhengqi.arch@bytedance.com>
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

Long-term pinning rejects HugeTLB folios explicitly allocated from CMA,
causing unnecessary migration or pinning failures. These folios already
own their CMA memory and do not need to be migrated out for future CMA
allocations.

Add cma_folio_is_longterm_pinnable() to recognize these allocations
through HPG_cma. Allow them to be pinned even in ZONE_MOVABLE, since
memory blocks overlapping boot-time CMA areas cannot be offlined. Ordinary
movable allocations that borrow CMA memory remain unpinnable.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: stable@vger.kernel.org
Suggested-by: Muchun Song <muchun.song@linux.dev>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/cma.h |  3 +++
 include/linux/mm.h  |  9 ++++++---
 mm/cma.c            | 11 +++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1a..d829fd0355bae 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -21,6 +21,9 @@
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
 
 struct cma;
+struct folio;
+
+bool cma_folio_is_longterm_pinnable(struct folio *folio);
 
 extern unsigned long totalcma_pages;
 extern phys_addr_t cma_get_base(const struct cma *cma);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index daf5c5b567ebc..e71aae8001831 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -38,6 +38,7 @@
 #include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
+#include <linux/cma.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -3015,15 +3016,18 @@ static inline bool is_zero_folio(const struct folio *folio)
 	return is_zero_page(&folio->page);
 }
 
-/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
+/*
+ * MIGRATE_CMA and ZONE_MOVABLE folios cannot normally be long-term pinned.
+ * CMA may allow pinning folios explicitly allocated from its areas.
+ */
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 #ifdef CONFIG_CMA
 	int mt = folio_migratetype(folio);
 
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
-		return false;
+		return cma_folio_is_longterm_pinnable(folio);
 #endif
 	/* The zero page can be "pinned" but gets special handling. */
 	if (is_zero_folio(folio))
@@ -3042,7 +3046,6 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
-
 }
 #else
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
diff --git a/mm/cma.c b/mm/cma.c
index 9ec1d1fd5dff5..fea5d1015319d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -29,6 +29,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/hugetlb.h>
 #include <trace/events/cma.h>
 
 #include "internal.h"
@@ -38,6 +39,16 @@
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned int cma_area_count;
 
+bool cma_folio_is_longterm_pinnable(struct folio *folio)
+{
+	/*
+	 * Explicitly allocated CMA folios own their CMA memory and can be
+	 * pinned even in ZONE_MOVABLE, as CMA memory cannot be offlined.
+	 * For now, only HugeTLB tracks these allocations with a folio flag.
+	 */
+	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
+}
+
 phys_addr_t cma_get_base(const struct cma *cma)
 {
 	WARN_ON_ONCE(cma->nranges != 1);
-- 
2.54.0

