Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046765;
	b=vhhRWADksiygg8a+rA74gxMclDlaZhkvzrkLEBBgmhrlBTZxFaZOKoguuqQecwibfzw6
	 uryPK6m8O9e1wC2D/ysHAhbVJngYjMHN4HlfsvkxgaPk1B48jLBf7oXF9+AeN+iO6JHi8
	 Irc3ZUPxZ3drvU1VGkLkwWt/uiDe2irSacwsW2NzDjpnCbAKkJ7op9EQyB68lgH7RO3rM
	 O/4ilNGNTGBGWLGo2VW1VQwGL01oaA3CMO1o+Aa/o1S9jYFj8Qptil3FfifybHHg04AJU
	 jBWxGwKU0e62RhY7PjyFJ2WgSSVKmseeWY5P5Lhv+DbNzqbwsDpFICj1HdI1IV/nlZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gI9AuU4FBtFGcA0OFWut6SSqvjFOG9vJjv3ZjFsEUHE=;
	b=fZlXwMX/FjdAb8mKqGwqso9Wh9HyCUSei7YAlpljy75QRguIldkFcmdcTLGhdayyW0u4
	 6xsMUtdQy3wUw6OCRvCYEGLtgF4fdLC/hHhxit8YSpXWTOmEJYLxzqxijw0qKB8zidZDn
	 5O2HddTdO8uNhh9LVlRg7ricaVVCIvD9V+9L2W9omgJWmvfg2WDgZ6RphUKI2LtbNyNOn
	 C5tf5oB/zxSB0uf2nnnFcv9XGPlbBUu27Fc3VIQRDGVgzCPHE+R1/J4fnw9IADOuIzegM
	 HPBkVVLRmc/+rbcLAX3dFqzLXWkD3/vNAzTs9O6nAp0DWdLxbV3yGlZZ/Cz2+P1lyCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeVIpj80;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76440606D82B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeVIpj80
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5391F0089F;
	Sat,  7 Nov 2026 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046765;
	bh=gI9AuU4FBtFGcA0OFWut6SSqvjFOG9vJjv3ZjFsEUHE=;
	h=From:To:Cc:Subject:Date;
	b=VeVIpj80LBZmMsOC2/1Mp3jFF1KcqCoROoLKbYFFxJxANdghwO7dSu3TvkyNtypTs
	 DkMhc/I3p/PKGsx4PgmGYQF1kXudQk/awziNFlYkIRFytOO8/m3aR6B0jetqUowZPa
	 Hr3fW7/K5ZO/SJpYfwJ87A+H559fTsqEoMUkXgTxm3l7ab2iTXujeCT3PiXfClJEjk
	 gJYy7BmOlyh50k8NQkKfLFzfaZg2r7B8wv3ytngcP/ux2mjkgwgD1Nw3EOY1ZenweM
	 J3NF3HbUjpDNE4G5loubjbsznwGdpTtt8Xc/IFfdYUzHSjV7SrZ5MTzCyq2FDPTBiZ
	 vb1/AKVA3+N/A==
From: Sasha Levin <sashal@kernel.org>
To: xiqi2@huawei.com,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	wangkefeng.wang@huawei.com,
	mhocko@suse.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	vbabka@kernel.org,
	brendan.jackman@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_isolation: fix UBSAN shift-out-of-bounds warning" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:23 -0500
Message-ID: <20261107051923-failed-6.12-eba0e6297edd@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eba0e6297edd60a85bc96ff5cfb734d066af62dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051923-failed-6.12-eba0e6297edd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eba0e6297edd60a85bc96ff5cfb734d066af62dd Mon Sep 17 00:00:00 2001
From: Qi Xi <xiqi2@huawei.com>
Date: Tue, 25 Aug 2026 20:05:48 +0800
Subject: [PATCH] mm/page_isolation: fix UBSAN shift-out-of-bounds warning

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
---
 mm/page_isolation.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e5dfc7bf49446..e4ee998c00f3b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -388,13 +388,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn,
 		}
 
 		if (PageBuddy(page)) {
-			int order = buddy_order(page);
+			unsigned int order = buddy_order_unsafe(page);
 
-			/* pageblock_isolate_and_move_free_pages() handled this */
-			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
-
-			pfn += 1UL << order;
-			continue;
+			/* buddy_order_unsafe() is racy. Validate the order before shifting. */
+			if (order <= MAX_PAGE_ORDER &&
+				/*
+				 * pageblock_isolate_and_move_free_pages() splits
+				 * cross-boundary PageBuddy, verify it.
+				 */
+			    pfn + (1UL << order) <= boundary_pfn) {
+				pfn += 1UL << order;
+				continue;
+			}
+			goto failed;
 		}
 
 		/*
-- 
2.53.0




