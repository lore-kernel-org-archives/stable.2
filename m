Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503759;
	b=hq6OyPCLvw/bw7HZXTur5soNvE7jwttvA+TiHzwABbqektU8xweadinyo/1RXCgDRFzl
	 3Y1/EQvTlTPX+MgncLcTXH+4fuGiZJ1W3YE+jN9LGeJZzU8V65jJb8YpK+1KjMua3e0l0
	 EqZv8PpqLIBOIFXv2wCaqZbqUb877Z0T498x3P8sg8iRPmLkGRvr+IPNtLKtzxCC2rCKs
	 pk3Okr44p2WHIU5/SZ1Xjb3Fs7pdftLC5KeaAgcDBcKZbkQHJPT40R8lJG2WQJJKf18A1
	 Fhrm9QprAyCmyey/wUgg5ZtN5/wmA7/hLHyybzq5mtMsffNhkRNTEvCYinfkR3UDOyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503759;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YrQKWHVkSfoTy6LzaCoo5XjdQE9DxwlwMVFy7Z78e4I=;
	b=yxUYXI+5QixmYGxwCocPt2VdMIFkzTCRiFgM19HHUydcq9X/2Y+4bUKONKTN4yFmhV6T
	 q5k4VoJdD1aZH4/j5F6Wi38TaBOpPZ/VlCR83TV6Al6aVzmJgZVOj7RXOmEEjcp8I3dK8
	 +CsD2FoqUxIgbiof9VgvNpoY1i1Er3aM2U/tNgcuyO+ypLcBbtNuKSqG626BBef+Z5iHG
	 CAO1pOXT3XXOBU2R8gCH6/v0peqDqBMb5DO/bvIx+behIJBjZnAmtQUUJNbdbvJwyTXaE
	 sF7/QyF465EbTzT69sI87AVwE18WIxOMRPCwDo+kYBu8offwBd3PTyZARM1fI36/4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/bgRBzh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66302606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/bgRBzh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F31F000C4;
	Thu, 12 Nov 2026 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503758;
	bh=YrQKWHVkSfoTy6LzaCoo5XjdQE9DxwlwMVFy7Z78e4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/bgRBzhRbfHpwgR5ydDD8P/uYIDEOQTsaJ5FGwaNrM1IE8Sm7Uv4UKoJTvHoMNkD
	 5hi5n6LfCLKMfAuw/NZuA5kxBe0HtFBZGr9VqqXZC1ACquoZvx1eTECexFjjHk9eUB
	 W5CzYX66Cb6CWj9s4lg4zgJli7Yh++SpNwhRogmU+Di5XQQNoyLdGHgtIXcjNrff3a
	 kPLmpZDmn+4Sa+Ypj66AuKWUHIY2r7q7XOXLe/mAhmpe3FQhCG3uTuseIcUm2YQNI0
	 nda1p16E0cYefydip5p44qlHps2A9F2Aq+HhvEqtWEosGHA7LXT32Q7fgXzycAW1UM
	 Hpc7MPocnjUVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
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
Subject: [PATCH 6.18.y] mm: page_alloc: do not give all non-blocking requests reserve access
Date: Thu, 12 Nov 2026 12:15:55 -0500
Message-ID: <20261112171543.3069410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200416-failed-6.18-6ee3d87b9408@kernel.org>
References: <20261109200416-failed-6.18-6ee3d87b9408@kernel.org>
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

[ Upstream commit 6ee3d87b940848aaed5d4e8d005c5f674bf2637a ]

Patch series "mm: page_alloc: fix reserve access for non-blocking
requests", v2.

Two fixes for how non-blocking allocations interact with the highatomic
reserve.  There are prerequisites for Salvatore's "mm/page_alloc: avoid
direct reclaim and compaction for costly __GFP_NORETRY allocations" [0].

Patch 1 narrows which requests may physically take highatomic pages,
patch 2 narrows which requests may count them in their watermark check.

Both are prerequisites for Salvatore's patch: it clears
__GFP_DIRECT_RECLAIM for costly __GFP_NORETRY requests, which turns every
large page cache folio allocation that reaches the slowpath into a
non-blocking one.  Without patch 1, those requests may fall back to the
highatomic freelists reserved for atomic requests.  Without patch 2, they
count the free highatomic pages in their watermark check while being
served from regular memory, so they can consume regular high-order blocks
below the min watermark by the size of the reserve.  GFP_NOWAIT requests
hit both paths today, so these are existing problems worthy of their own
stable backports; but Salvatore's patch would widen them significantly.

Patch 2 reproduction: a GFP_NOWAIT burst under memory pressure can drain
regular free memory to zero while the highatomic reserve sits idle.
Measured on a 32G box with an anonymous working set, swap, and a full 290M
reserve, three synthetic bursts drove the 28G Normal zone's regular free
memory to 28M, 0.8M and 0.6M against a 60M min watermark.  Swapout failed
its swap table allocation inside reclaim, reclaim scanned 13M pages to
free 200k, and page faults stalled for tens to hundreds of milliseconds.
With the fix the burst stops at the min watermark and nothing else
happens.  This was found in review and reproduced synthetically; it has
not been observed in production.

GFP_ATOMIC order-0 requests have a milder version of the same problem:
They are entitled to the reserve but are served regular memory first, so
the fix there has to change the watermark check and the freelist order
together.  Salvatore's change doesn't interact with this, though; fixing
that is left for a separate patch.

This patch (of 2):

281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
highatomic reserves") accidentally gave all non-blocking allocation
requests access to highatomic reserves, which includes GFP_NOWAIT and
other sites clearing __GFP_DIRECT_RECLAIM.

While this improved atomic request success rate, it's unintentionally
broad and can actually worsen highatomic requests by squandering the
reserves on requests that don't need it.

There are concurrent efforts to clear __GFP_DIRECT_RECLAIM altogether
for costly order __GFP_NORETRY requests, which would then also fall
into this exemption and deplete reserves even faster.

What GFP_ATOMIC has over the others is __GFP_HIGH, which
alloc_flags_slowpath() translates to ALLOC_MIN_RESERVE.

Narrow the exemption to contexts that have both ALLOC_NON_BLOCK |
ALLOC_MIN_RESERVE.

Link: https://lore.kernel.org/20261001082152.2879289-1-dipiets@amazon.it [0]
Link: https://lore.kernel.org/linux-mm/arFBWvzXPYrKuIYi@cmpxchg.org/ [1]
Link: https://lore.kernel.org/linux-mm/20261001082152.2879289-1-dipiets@amazon.it/ [2]
Link: https://lore.kernel.org/20261028171719.2043421-1-hannes@cmpxchg.org
Link: https://lore.kernel.org/20261028171719.2043421-2-hannes@cmpxchg.org
Fixes: 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
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
[ sashal: placed ALLOC_MASK_ATOMIC in the existing internal header because the dedicated allocator header is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/internal.h   | 3 +++
 mm/page_alloc.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index e0adafc45c8c3..e36c46e865956 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1315,6 +1315,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flags that mean GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2685e570bf7de..bce50449902cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3241,7 +3241,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * reserves as failing now is worse than failing a
 			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+			if (!page &&
+			    ((alloc_flags & ALLOC_OOM) ||
+			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
-- 
2.53.0

