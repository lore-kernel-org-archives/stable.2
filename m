Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373352;
	b=5GJVg5PouLQO8bDtaLxIQ1zC04TuTZIja8NTvFfuegU5ekrwrxHNyByraxT8uGF9A999
	 cpSbUVJWyrvrgXTqBAyyZEPz2rs4KLtFnh7YnlXX1NxJxEE1Tfrwuo1q8o2Tk0ASf7Fnp
	 gATWhFT3QrHGN3V+vIYetLz83soLepn8E/C8OG2PmUctJHIuA6qeMqihrWPzfhCGE0v/q
	 ma256Aanby8r+Vx+8uzI1F4G7ckC9QZNLjlFVis7dz44dehfd7CZ/e8IvsZDB0swxq4r/
	 zlAxJWq3qhP09bq5dcRylFh68EfWcBst0FdcmuWI/mW1fvCrH5oiSOXd+QvHKBUZXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xAN0+OX6Km5v6TVnSWZRB4+appvexYeDMiCzj+pXBgA=;
	b=XYqt/EGLSUDrgv7KNDfoeFFtEaS30LTd+mZ+Oz3R0ubKmjBwBjFQ3QTQhlBQh6HPrDNd
	 PkRnwWYYzgjG6iRN/90K3clF3s3MnvYON9Kids4+DJIL9aw8PAdZG0MeUpRSpiYtrUpRY
	 Emybu4SWBPB+rYvwr8z0Nxw4l+01UHlqkjtDrLrwWYLYVpTtcW6eIIklHllFMEXElax8O
	 YN+vOiM+5hCZwxUj3uoP3nRpcFnblHi9TUXBlzigJz7w3s4GLMV5affMW1XNcW4LM8mz+
	 9fhC3VE5MABUJ0ZmcpzNPgAxbyww9HFMNhjxm1yF/9f1H4S7+whYDIR5YFqEg6sZDEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDBHmqKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B7606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDBHmqKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069FA1F0089F;
	Wed, 11 Nov 2026 05:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373351;
	bh=xAN0+OX6Km5v6TVnSWZRB4+appvexYeDMiCzj+pXBgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDBHmqKBOFiDi4tHfj0yo51hO7aoSZ1UtDqazqRJQk3ryDfDlKFp/77FJfgycTIbf
	 QAc4fTyEagC30Puds7yHeSlL8EEjevTRbcKwOW3Mo7Rkl/6hOJDfzUn7PA3M5eziMO
	 cwqpjRuM5iRzj/GXOGz85gbTUgk6ZITRv2uEyfIiBNyBkghHRmNfqfmc99oEcQ7S0j
	 xhEczqF25vmUs/at3QgK+gjGWmpMC4aznA/6jKnq3p+2h8aW4yWhNcoeHKOCf9qu0t
	 JNcFIiM14h5i3RFwvbRfS2e52lVaIqJDJaBqSLvQWlxUFDkc6y9hS94eY6n22k8XWs
	 3cvTIr7hKRe2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Xi <xiqi2@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/page_isolation: fix UBSAN shift-out-of-bounds warning
Date: Wed, 11 Nov 2026 00:02:28 -0500
Message-ID: <20261111050201.1215761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054448-failed-6.1-eba0e6297edd@kernel.org>
References: <20261107054448-failed-6.1-eba0e6297edd@kernel.org>
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

From: Qi Xi <xiqi2@huawei.com>

[ Upstream commit eba0e6297edd60a85bc96ff5cfb734d066af62dd ]

Patch series "mm/page_isolation: fix UBSAN shift-out-of-bounds in
isolate_single_pageblock", v3.

Patch 1 fixes a UBSAN shift-out-of-bounds warning in the PageBuddy branch
of isolate_single_pageblock() triggered by concurrent buddy allocation.

Patch 2 addresses the same class of issue in the PageCompound branch,
where racy compound_order() and compound_head() reads could lead to
out-of-range shifts or incorrect page skipping.

This patch (of 2):

A contig-range allocation racing with buddy allocation on the adjacent
pageblock can trigger:

 UBSAN: shift-out-of-bounds in mm/page_isolation.c:393:15
 shift exponent -749042176 is negative
 Call trace:
  isolate_single_pageblock
  start_isolate_page_range
  alloc_contig_frozen_range_noprof
  alloc_contig_range_noprof

isolate_single_pageblock() first calls set_migratetype_isolate() with
zone->lock held, which marks the pageblock MIGRATE_ISOLATE and moves any
free page straddling the boundary out of the way.  Once the lock is
dropped, it scans the MAX_ORDER_NR_PAGES-aligned window [start_pfn,
boundary_pfn) locklessly, only to skip the free pages already handled
above and to detect in-use pages straddling the boundary.  Since this
scan only reads page state to decide how far to skip and returns -EBUSY
on a straddling in-use page, it does not take the lock.

The window also covers the adjacent pageblock, whose free pages stay on
the normal movable/CMA freelist and can be allocated concurrently.  So
after the scan observes PageBuddy(page), another CPU can allocate the
page, leaving a stale value in page->private that makes "1 << order" shift
out of range.

Use buddy_order_unsafe() with READ_ONCE to read the order, and validate
it is within MAX_PAGE_ORDER before shifting to prevent UBSAN warnings.

Since pageblock_isolate_and_move_free_pages() already handles free pages
straddling boundary_pfn under zone->lock, bail out with -EBUSY instead
of VM_WARN_ON_ONCE() when a PageBuddy page appears to cross the boundary
during the lockless scan.

Link: https://lore.kernel.org/20260825120549.966271-2-xiqi2@huawei.com
Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Signed-off-by: Qi Xi <xiqi2@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: <stable@vger.kernel.org>
[ sashal: adapted the order check to use MAX_ORDER while preserving existing boundary-split handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_isolation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 47fbc1696466f..bf098a6d863c0 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -372,7 +372,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		 * always be in the range.
 		 */
 		if (PageBuddy(page)) {
-			int order = buddy_order(page);
+			unsigned int order = buddy_order_unsafe(page);
+
+			/* buddy_order_unsafe() is racy. Validate the order before shifting. */
+			if (order > MAX_ORDER)
+				goto failed;
 
 			if (pfn + (1UL << order) > boundary_pfn) {
 				/* free page changed before split, check it again */
-- 
2.53.0

