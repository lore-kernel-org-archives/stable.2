Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703695;
	b=elIRQktfwL5dFBX9OY4zKSyWXLF6M9DMJh9xNCpaEjdib6kY1Ot/W8BG1gGfJ9Mql+CL
	 NH0/HjxtqOeDLJzdIxTY3d4wWT2KcTBBddf6y1hOjoRBaSGkTDxIWgOKzsuuPPgOWPROB
	 ZOjzXOnmm0RjUWtjZTqjYRMxz57Jkz7qwALIxQUYftzhvLuDjzrc4/atQJ0JUXhuM6iJe
	 wFq7Mr2GbFHt3a+BDBOzRGIDTzskj5thENIJkHLCIaJs7R/2Vm1xezgJ8kLDWOyca/1IP
	 da5GdcD/O1SKWAOJhwKYqppsr279S3m/K/rMCE2GmnoiyZvhJZkwfWOD6dgQL3dNMpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s1nWrf+/2XTHmaXfJZ5qYb7SwHV3/DQquWyAM1uceUk=;
	b=hQTOaIYwAB4+NdQI01H+0RYeJtS8oZyxQUFuhk00DbqX8MwiGlMisVfjVxQE2x7UXscZ
	 bBonhoOAb6FiUPUatTL+amvxZJ9Eng3BGzy5HMR7/L7XxNEBjwzXhmfD6EVjgcyEJOU3v
	 j3bIwSS0iyul3AvumgDVZTWHafFJOP6y2rSQdiXwAcIv0/3M+Dv/8X6xbR2Dpbz3aX58d
	 gxzjP0afwh9YoU8feDYk8oNl2dcqGMVc/VCQyUpSrPy7lEUHcMWo295YjpkSSM4ICdtEG
	 iqyhOeNLW8OrcS5JjIjMIryLcKxJ9etDqay2ELMiQARLfJPdVsfU9TngaAa090W6ybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fipCtDRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573F606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fipCtDRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C21F000C4;
	Sun, 15 Nov 2026 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703695;
	bh=s1nWrf+/2XTHmaXfJZ5qYb7SwHV3/DQquWyAM1uceUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fipCtDRDuX3A2ausVsGpKoXS+GpNxL8sx+iukQXPJqAbmHipUCLJV53eHB2LW+TQS
	 DeVlsy7is0q/fTnGVdTdyo2ae42XPm/bmAVlRbXsipgz3W+YGytXt87vpIxEWM4iUB
	 +hg7EApKJFD13aA8mBh7tpsDWGr0PMXRWTTcdAtD3/oFLQ5iF+Y/KnJbta/h9NPEHQ
	 jTNjqXvpwnIkTiu3mfxtO55jjT25h17r0GYIYKOR313JFpMmllDwHDySCEb7gnVsRT
	 OlJ7mYYcP5k9B9C12mz8DVDyjHGtaWWSNfvWySG4Fy6w68/Z0i9uwRbGx1/xgVMj+a
	 /bPwpMVdNeWNQ==
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
Subject: [PATCH 6.6.y] mm: page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES
Date: Sat, 14 Nov 2026 19:48:12 -0500
Message-ID: <20261115004520.605168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201231-failed-6.6-fe21f930d1e6@kernel.org>
References: <20261109201231-failed-6.6-fe21f930d1e6@kernel.org>
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
[ sashal: adjusted context for allocation flag definitions in the internal header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/internal.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ec88688289897..6c8d3a0f67dac 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -897,12 +897,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
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
@@ -915,7 +914,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+#define ALLOC_RESERVES (ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 /* Flags that mean GFP_ATOMIC */
 #define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
-- 
2.53.0

