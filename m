Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330546;
	b=2u0bG8A8LAFejxTtm5y/wnjn3B4tUKJsEAm89nb3iENFKrzdVDFwjKYycV+tsCE2vtRC
	 CbJnDtKxWVHaiyNes9rjyMUTGAqgQZAa3hF0rPfH86ZBr7c8UrOQGv5tSxkBo/JWS/yCI
	 m6XBYhQ2ODGvSUxHXdcJs2FfLS6/LiZANc44Y/zz3kWdkxDvlTwtduZbH7GCeRJl4rNDc
	 sJwI21SOrg7I/vCMf1d9LhKqZiu3DiVrp8PP0hMOJo8suf+gqDE0qmMr9Myl6qNCdTuca
	 pQoetsDt91D4Zu/Ka8ttHp5MhEi5gkutGBE//V06xDGPdKz6qj1+4093akvk7b9WrrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330546;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Wmi8+gU9wSz5TRuIdE6ondwceW9JjgoynshcbqtVNQs=;
	b=BwCu6jLuNc9rSXVDYmdqvEWWrGKZnqhU1ZVdeRtE1Wn7pUuzrkx84AphYEsY5Ki5REvC
	 JlnkXvM4RtploYq2FKdneUQ08mwocYvQXZOH1qpne0ppQnyirv1qNFknDjzvDMxz7g61i
	 kEt2BNqlXhDXq/iH1j9satnW+jntjYnxK/p/vFKYo/P9zgS7o0U/1LNPNI8OMfNjGL4jd
	 segW2gpd7GF/pDf5yOpheqoZxlKdpQhQpiqM3hYDGtXXI1CVgq++d8J/ESexxpb+12w+E
	 yKNepuA7EC9XVi1F8XB0NhJ4m37ecWkQVWM0qtpwlxlTjgnn7FlPQpFbButc9/tB2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Kt7WslS/";
	arc=none smtp.remote-ip=95.215.58.1
Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2B606A331
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 06:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A2B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kt7WslS/
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QDLkr1W5J3m1NZAazgRrXp2vVl+LPZJtkzX6HsnTQ1o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795330542; v=1; x=1795935342;
 b=Kt7WslS/zzIEtHnb4aXVS7SRvSMWnRU+/DtpabAg3+h9bdLeBbDKm5NsyD/TlSGBiE/fed3N
 ObloLFDDCNdNuC8aewQWBsf8v5LX6Ra/sCqajLusgtgLDvwVq0XI1bC6I6+5hOg1EIkaQddtAko
 lCJslW3ZM5Kz0r7QyPvKyCRw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eab61d17154b09f0;
	Sun, 22 Nov 2026 06:55:35 +0000
X-Mizu-Trace-ID: eab61d17154b09f0
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
Subject: [PATCH v2] mm: hugetlb: allocate larger early CMA pages first
Date: Sun, 22 Nov 2026 14:55:26 +0800
Message-ID: <20261122065527.33123-1-qi.zheng@linux.dev>
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
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Muchun Song (ByteDance) <muchun.song@linux.dev>
---
 mm/hugetlb.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a448c5909d36..96b97f012ab49 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4600,8 +4600,25 @@ void __init hugetlb_bootmem_set_nodes(void)
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
+	unsigned int order;
 	struct hstate *h;
 	int i;
 
@@ -4615,9 +4632,19 @@ void __init hugetlb_bootmem_alloc(void)
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
+	order = MAX_FOLIO_ORDER + 1;
+	while ((h = hugetlb_next_early_cma_hstate(order))) {
+		hugetlb_hstate_alloc_pages(h);
+		order = huge_page_order(h);
+	}
 }
 
 /*
-- 
2.54.0

