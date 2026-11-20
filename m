Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160866;
	b=1ne0QNf7uCIUAihr9vSsIsY4faBR3ei7lXgicqyl83emo69heOtloLmboHpFwVbjWAUD
	 VnBjQre9w54xt1tplR4dFDCpBtjsJvwCzPFTl43Q3bFJwsBpJ49gcRNr0npvC2Eu2GFDg
	 AqQo8hcP5CZkqMPxSiOAKkeLvp7w3XIIozKd6seKMTociDWRBK7B+iYqmhGhlYWLp/XMF
	 f+zkXxYa22fljV+9U27scM9DoQmPjfjBqYGu6FZwF8Gryik/VdHIO9EZt0ZkBjQAxjSpS
	 VW2TR7YpwP0YvPX0eux4ZrnpuOU1HCzI1tDHbSgS64MOkCEpOBl5M0qFqsmMZeZ7JOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160866;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/y1qXQ06BKv4Qawqii9E8uutLP6R4HWSV0iDf6FGFuI=;
	b=GIgAXDaEusTW2aA0nzfEMMFMnMqN65UhVufpd8521uHnFk+fM2/uVb57zTV9dSCqYi5d
	 DMMrdSPpjNbA3unba5KtPReee+DwAoe+KFcSUa7uOsvh0PkWwN7sVHy0DqllQk2WOUnQ1
	 QTIFhs0JHpAI5qhMTwTHROBIdsUipJRoVxmqerBtcG3bNluqSGsxD6kjZJngMkUyvYf9P
	 nHy4ZoCTn9Jii4iiv2Nvr+iagCJGNc3aoE4RqzQPETm6wv6yiVL6MV0g+VUkVCgKEOagM
	 EJg4eoL5Q7qTOOS6SyYzAvmRgGzO7hQOwUrhEKf1rp/kN6GVFj2N+0RGEaVr/cDWhQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ek4Q8C0V;
	arc=none smtp.remote-ip=91.218.175.7
Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CED606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ek4Q8C0V
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6vVXslyHXg7KTNISx0U4V6507R5r4hQfQTf1zEh+K4c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795160864; v=1; x=1795765664;
 b=Ek4Q8C0VwK7Wzmjg8QZgr4LA67nhKYQi0tIMWKDSuozuQ2nhjWYld1275sfpe203q6gf0rM7
 vgnM+kTkFU/tIvY4epWnL3OfSmmi9hgjeNYlKtTV9nPCbIrQNRRQhS1iULFRqI99IP6DcO83V5w
 XajCBgblgpEY96r8/LVX1mcs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cb2d6027f8dda27;
	Fri, 20 Nov 2026 07:47:43 +0000
X-Mizu-Trace-ID: 1cb2d6027f8dda27
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	fvdl@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: hugetlb: allocate larger early CMA pages first
Date: Fri, 20 Nov 2026 15:47:01 +0800
Message-ID: <20261120074701.48298-1-qi.zheng@linux.dev>
X-Mailer: git-send-email 2.48.1
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

With hugetlb_cma_only=1, early HugeTLB CMA allocations follow hstate
registration order, which can depend on the order of hugepagesz= and
default_hugepagesz= parameters. cma_reserve_early() advances early_pfn by
the requested size without aligning the start of each allocation.

On arm64 with 4 KiB base pages, 32 MiB and 1 GiB pages share a CMA pool
aligned to 1 GiB. In a 2 GiB CMA range starting at 4 GiB, allocating a
32 MiB page followed by a 1 GiB page places the latter at 4 GiB + 32 MiB,
violating its required 1 GiB physical alignment.

Simply rounding early_pfn up before the 1 GiB allocation would leave a
992 MiB gap and advance the cursor to 6 GiB. cma_activate_area() marks the
entire prefix below early_pfn as allocated and only frees pageblocks after
it. The gap would remain reserved with its bitmap bits set, and releasing
the two HugeTLB folios would not reclaim it, permanently losing 992 MiB
of usable CMA capacity. An alignment-only fix would therefore also need
to track and reclaim such gaps.

The same alignment issue can affect non-LPAR PowerPC64 hash MMU systems
supporting 16 MiB and 16 GiB pages, with 64 KiB base pages and
CONFIG_ARCH_FORCE_MAX_ORDER=7. The 16 MiB size then has order 8 and is
also gigantic, sharing the 16 GiB-aligned CMA pool.

Allocate early CMA hstates in descending order. Each range starts aligned
to the largest supported size, so this preserves alignment for subsequent
smaller allocations without creating gaps.

Fixes: d2d786714080 ("mm/hugetlb: enable bootmem allocation from CMA areas")
Cc: stable@vger.kernel.org
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a448c5909d36..d69a9532ad5ef 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4600,6 +4600,22 @@ void __init hugetlb_bootmem_set_nodes(void)
 		node_set(nid, hugetlb_bootmem_nodes);
 }
 
+/* Return the largest early-CMA hstate below the given order. */
+static struct hstate *__init hugetlb_next_early_cma_hstate(unsigned int order)
+{
+	struct hstate *h, *next = NULL;
+
+	for_each_hstate(h) {
+		if (!hugetlb_early_cma(h) || huge_page_order(h) >= order)
+			continue;
+
+		if (!next || huge_page_order(h) > huge_page_order(next))
+			next = h;
+	}
+
+	return next;
+}
+
 void __init hugetlb_bootmem_alloc(void)
 {
 	struct hstate *h;
@@ -4615,9 +4631,19 @@ void __init hugetlb_bootmem_alloc(void)
 	for_each_hstate(h) {
 		h->next_nid_to_alloc = first_online_node;
 
-		if (hstate_is_gigantic(h))
+		if (hstate_is_gigantic(h) && !hugetlb_early_cma(h))
 			hugetlb_hstate_alloc_pages(h);
 	}
+
+	/*
+	 * CMA ranges are aligned to the largest supported size. Allocate larger
+	 * sizes first to keep the early reservation cursor aligned without gaps.
+	 */
+	h = hugetlb_next_early_cma_hstate(MAX_FOLIO_ORDER + 1);
+	while (h) {
+		hugetlb_hstate_alloc_pages(h);
+		h = hugetlb_next_early_cma_hstate(huge_page_order(h));
+	}
 }
 
 /*
-- 
2.54.0

