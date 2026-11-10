Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273741;
	b=eSVeTqy2HgYfC4nDtwiFE3C4K+FzhZ6e0ki528K1QsbL71Q6I9zXymABmSFqZ/d2lEX+
	 /uF9+EWkBmS2omK3AE6AOuQoVcjgkI3gz7R64Fa7JuYBVwstguFZTmga78AQxUSFI3amP
	 KcnZwis2O42x8vUefIpBe+L32eBhHL0BzI3YwoE1zs/iC+eOGevT3x6DChZqsTcbAzrXJ
	 xbpFd0PMC79xRaYreV0jfoi6Girp1lJeIoUfsD05aEMiWGd0z3PyEl9uGmDDJJSedGxr/
	 ennKNes+/VqbgqYpqA50ZhFAyyWFeZygMW7MU/rPr+h842gD4yyRzslN7FU+J1eodQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TynYz+DNhIVgtqrObJ6ezn5eW+mFJ35NIkM8mJvtdxY=;
	b=v4wA3x5/p62b4Jt+czQUA2RyB9duHn0102lhVzyjS3H6eIYC3PacNr8E0xUDkRMkd3dG
	 3oprW/QhQ8JZkVcyAFshaRve2CM91MIkomcBntnA2/MGzzsIqP6WUYCG4436jBaXGwN+U
	 Ch/eXyoCtBbxhwxsx5mcQrkzCZN3eijzAa8kKh2RaciLvAlaRnxhxgJ2JkvV/gi7lV9KE
	 AsW6DXA+UVV7jHbfHzFTXTHNZXIhvzJWYQJUC+9TpE6sf/ipVM7Y/K7amPL9qG1mTZ6un
	 eO6AL7K9X1WNC82/561sVLvXH6jg2Or2nclJViTjL09w00a0x+5w0zgkxVtLIYLHkYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olfB7hNq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92719606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olfB7hNq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9ED1F008A1;
	Tue, 10 Nov 2026 01:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273740;
	bh=TynYz+DNhIVgtqrObJ6ezn5eW+mFJ35NIkM8mJvtdxY=;
	h=From:To:Cc:Subject:Date;
	b=olfB7hNqf18Hm2hTcdfbW/6lPlDid+IiUTjz6SmwEYrrLYeEZaizrQP09ktrfPo5l
	 LZuucQlzgUHshy4GeKUWytB+asTp+1rzGH38/hdSR6EQaofcyT5PqTapCn5pbraCca
	 aARmmoUxugXlmkpqvjmS78SclAOQKC7u/z78GCPiN701WjCkxqvtfgg1O1+im9ZiBr
	 08nWTza9I3F1JQ9q9VQsjBryidz+HWVmNjmph9TK+F5tg2p9t0rswxGyuCxL/fhsvp
	 eiqaoP+JWlfjvTJCuZo5FJfRttflGHfUvRK0kX5nfusCHXQTf/65ycqjf4/Dk+i/Pp
	 hpKHGj+eHXZTg==
From: Sasha Levin <sashal@kernel.org>
To: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	balbirs@nvidia.com,
	vbabka@kernel.org,
	willy@infradead.org,
	dipiets@amazon.it,
	hch@lst.de,
	dgc@kernel.org,
	matt@readmodwrite.com,
	mgorman@techsingularity.net,
	mhocko@suse.com,
	surenb@google.com,
	brendan.jackman@linux.dev,
	ziy@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: page_alloc: do not give all non-blocking requests reserve access" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:22:17 -0500
Message-ID: <20261109202217-failed-5.15-6ee3d87b9408@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6ee3d87b940848aaed5d4e8d005c5f674bf2637a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202217-failed-5.15-6ee3d87b9408@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6ee3d87b940848aaed5d4e8d005c5f674bf2637a Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 28 Oct 2026 13:15:53 -0400
Subject: [PATCH] mm: page_alloc: do not give all non-blocking requests reserve
 access

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
---
 mm/page_alloc.c | 4 +++-
 mm/page_alloc.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2b28553002175..de0b3acf3e50a 100644
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
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index e238ee91ed245..9c3c2830acb0d 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -60,6 +60,9 @@
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
+/* Flags that mean GFP_ATOMIC */
+#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*
-- 
2.53.0




