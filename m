Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705526;
	b=o82vTbr/+R74zSbL7M8bxGmB+bKOQIrTmX2DdnfzlBob44XvoW1QmyZdzHTNt7Lawml0
	 0oY3jfcA2W4Sj14hYVKLUnAiCIAH+hqgK6rHkg2w9OKdDak26wPntFK6wEIWSeP73nHkg
	 zs4dZjivp1u9vLVh/IusUYz8inZHgzAmz07X2J7p82zcTldy2K7rFz8jjTIlY+WMa4GU5
	 tP3BMQyOlEtJhU2miRXXge2WF9m50xBNGR9pURUjl6BIznolhJbrdeNtpqe9GLbVvJwHL
	 p9j5H5m+F1t4Jb6XoiuSp/A4/9/9nb/Tvkzjlo+EfKx8kM2+heMcBq4+/8aS75X1RWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HAABiq2PmBC/aR93zM0EQlExMzfPywWrtGAryutsYvs=;
	b=wMaP1A82SVetWtr3RKSNAadkwTk1WZwVqIl9TN/epnLoT23KbjpzRwDb9Veap2BUEL7h
	 UF0TC29COJh/iZ7IJrHSlj3I534NoTkRYqll/kyYjAKXm62AShTaPp3U3gs5ZMpZbAAKm
	 35wsR3/uefvpjXOI213kEeQWMQOV1F8GDyXJA0WQzhQ+pR4pQZRVs4F5CSa/IUfX8j+eb
	 8tDLc3h0EV0MpQ39E/npSNFSObvZRAoecXB0gX+xwFoSbKQJVTljXZkdoU6145vxHaW+q
	 CO+qATiOXIHtMX7uNf80F1Yy6tCfWRVcCn3shL6Mzg47+6pmzhlMM57UAj5C5k9L86Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF7Fnciq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4A606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF7Fnciq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76BF1F000C5;
	Sun, 15 Nov 2026 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794705526;
	bh=HAABiq2PmBC/aR93zM0EQlExMzfPywWrtGAryutsYvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NF7FnciqDJG8cKWRh+1TJX7QtmDQj5iKWXBOtls7etKxRzlR9l8rmt7NZy/L7Fdjh
	 1/NyFQb6RbLOeE6athngzUPFuiHhc2lU+JhTRhJyK0jLg86TjjYXw4DsEEqGt5eLoE
	 3nCKKj+orzuR7RCxBn/mF3LtmNXyxb9Xu5fs1r8Be3Y3tK5Wq+bB3pFapvaBZG9lZV
	 OYqCz/fHdQohlf9nIKPnKAwtitg5poiIei9fW2Pyw+78do42maT14fGh9L+6h97W3u
	 ehv0ZG8BXXKc+7W2uSqPyQkm3HoFTXVN8xf3DKKiasIzZaSR7YvTO+GPcwZGoDJ4Rz
	 xjbBUT0GFezbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	Christoph Hellwig <hch@lst.de>,
	Dave Chinner <dgc@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES
Date: Sat, 14 Nov 2026 20:18:43 -0500
Message-ID: <20261115011434.626719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201723-failed-6.1-fe21f930d1e6@kernel.org>
References: <20261109201723-failed-6.1-fe21f930d1e6@kernel.org>
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

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit fe21f930d1e64d121191673076fc4ebe79fc82d5 ]

1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
non-blocking allocations accesses reserves") stopped handing out reserve
access for ALLOC_NON_BLOCK on its own: the extra 25% below the min
watermark is now only granted on top of ALLOC_MIN_RESERVE.  But the flag
was left in ALLOC_RESERVES, which produces something odd:

With the ALLOC_RESERVES match, __zone_watermark_unusable_free() doesn't
subtract the free highatomic pages for them.  So in the slowpath, they get
to consume regular blocks below the min watermark by the number of free
highatomic pages.  The highatomic reserve is capped at 1% of the zone,
which on any decently sized machine is a multiple of the min watermark:
GFP_NOWAIT can drain regular memory to zero.

The user-visible result is brutal hiccups during bursts of GFP_NOWAIT
allocations under memory pressure.  This was found in review and
reproduced with a synthetic burst, not observed in production, but the
sequence of events is a realistic one: On a 32G box with an anonymous
working set, swap, and a filled 290M highatomic reserve, a GFP_NOWAIT
burst drove regular free memory in the 28G Normal zone (min=60M) to 28M,
0.8M and 0.6M in three runs.  Swapout failed to allocate its swap table,
reclaim scanned 13M pages to reclaim 200k, page faults stalled for tens to
hundreds of milliseconds.  The machine survives it, but not by design:
direct reclaimers eventually fail and start unreserving highatomic blocks,
until the allocation succeeds or the reserve is gone and the OOM killer
runs.  That reserve exists for high-order atomic allocations; here it is
destroyed to bail out a GFP_NOWAIT consumer that was never entitled to the
memory.

Remove ALLOC_NON_BLOCK from ALLOC_RESERVES.  With that, the GFP_NOWAIT
burst is stopped short at the min watermark.  No direct reclaim, no
stalls, no failed allocations, and the highatomic reserve stays intact for
the requests it exists for.

__zone_watermark_ok() is unaffected, since everything it keys on
ALLOC_NON_BLOCK is already nested under ALLOC_MIN_RESERVE.  Update the
flag comments accordingly: ALLOC_NON_BLOCK just means the caller can't
block; the reserve math belongs with ALLOC_MIN_RESERVE.

GFP_ATOMIC order-0 requests have a milder version of the same problem.
Through ALLOC_MIN_RESERVE they also count the free highatomic pages in
their watermark check, but rmqueue_buddy() serves them regular pages first
and only falls back to the reserve once those are gone.  They can still
push regular free memory to 37.5% of min minus the free highatomic pages
before the reserve is touched.  Unlike GFP_NOWAIT they are entitled to the
reserve, so this needs the watermark check and the freelist order reworked
together, and is left to a separate patch.

Link: https://lore.kernel.org/20261028171719.2043421-3-hannes@cmpxchg.org
Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Salvatore Dipietro <dipiets@amazon.it>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dgc@kernel.org>
Cc: Matt Fleming <matt@readmodwrite.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
[ sashal: adjusted context for allocation flags defined in the internal header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/internal.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1c1b37bd4226d..3e3e231c65016 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -777,12 +777,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
-				       * to 25% of the min watermark or
-				       * 62.5% if __GFP_HIGH is set.
-				       */
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. */
 #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
-				       * of the min watermark.
+				       * of the min watermark, or 62.5% if
+				       * the caller cannot block either
+				       * (ALLOC_NON_BLOCK).
 				       */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
@@ -795,7 +794,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+#define ALLOC_RESERVES (ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 /* Flags that mean GFP_ATOMIC */
 #define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
-- 
2.53.0

