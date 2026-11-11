Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373066;
	b=dLMDHPSlLXEphaRuXxZX1bLp7oY0+eYlOrYak0iSVQvFILyTIfNf/CIe0ARqU2uQb5xX
	 7lXveYdT8znudL3B1IZ3CCcua2mKzPyfMfRRu1uPKoO4MDun2XW53sCv84yWkZuZTFJPD
	 seAZysidgN0olGF298iYGCMOnS2giBb6YrRcQKlYuIVLgq4NRkyBRT6rU4nUTll0OhdQI
	 nz86+YSZdSik5yTacC3Q0+huAYUg7jv9JIwze0CMQwj82bPeMJGLbEwG6PfMvMx46WxMy
	 Bthz7s1rNVpEiOD4w4PCoZMk2nyMSfHyh3NgS+yAaIMU9qRd/Q2XYfqHKeh69GOFymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1ki4FHtI1U901X3ssFU8L0UAAeOZOiljS+tp+J/7y3k=;
	b=SHgT9VDVP6dARcnbU6yvxP0bm9RmCpOMV3YzkbWGRQ9sxpQglyXI/+4C5gAVabqJbAKC
	 XPMNSKQr81xOf4wpC+L3dEHtZCmFqRddPKnSrniW8skB4ICgKNWowKAzgPzqRjZeuA9ww
	 GPBQ/waCRL+MYsSnqK1GT8AaEo77xHCTe207N1s2J/KDfmlFR0bjYud8cF86O20BBGY20
	 3eqCCg3TgsvMjPKJ/OX7s1ZZn0q/CivdT++jurNggoE1lTZKWJKnpY5PiOrWj3FfLqs0K
	 eP5W0flwh02Lb5CbwGMCf7ktPY3x1VjiOM0+n/1R9F2ybxZEI/8OFdhbi5NUXSk5FOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YouGiyo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAC606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YouGiyo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DC21F0093C;
	Wed, 11 Nov 2026 04:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373065;
	bh=1ki4FHtI1U901X3ssFU8L0UAAeOZOiljS+tp+J/7y3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YouGiyo/cZzyaw5f8USbg+z+3DiJfi1iJdjVUCtbqEWvNiCAGI6K6PCf9zE1MQryi
	 LB1L6tEGwrBNJXwF4TZMEWPFWtbHbUPPDm7Luvaky7Q+7IT0dLdCeiD1ldBTRRp0lx
	 kQIVFzrL+S7ZjiecwmsutsNjJ45c1LZRvmupX1ODs732R5h+4IPIj63Bbpwniw9C0M
	 6RmX3Zp/0NbktjO3H0ACMoMA9dO+b5gXm1dUvysvH/sfuWqnKAbSyOm4bajmfG5UR6
	 blYYpaLCqeqxjJgflMkm47ADEQ+LTdYEGYGHXPkx/Jt0xKJp+joKyF5xkR8pquUDSy
	 egzkThQXh2I/A==
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
Subject: [PATCH 6.6.y] mm/page_isolation: fix UBSAN shift-out-of-bounds warning
Date: Tue, 10 Nov 2026 23:57:42 -0500
Message-ID: <20261111045531.1185132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053157-failed-6.6-eba0e6297edd@kernel.org>
References: <20261107053157-failed-6.6-eba0e6297edd@kernel.org>
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
[ sashal: Retained split_free_page() with retry handling for blocks crossing pageblock boundaries instead of rejecting them. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_isolation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bcf99ba747a05..5b98147a13507 100644
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

