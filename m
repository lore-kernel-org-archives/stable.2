Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048291;
	b=bLHT5WYrNwyAD35oZls5cHXLGg/DtngleJiXo/6a/60X3gQaj454oHxve4ml7Vw2l9pa
	 m4OMLZ0qAJdRwRO9gRzkD2kyhN7c3dXcsfSrvcMkrJfuqPe96VFZEVs66ADADgAhDKE/8
	 4BH03jd1BKFbGUW5KkH7CgrWvbgCknLslI5waTP3hdrhJFv4iQM2gCD42yQTfgqZLpzuX
	 u9xC1tgZ6xDdUehrpPwfnK/TqgzdBV8dhgMml5ryenHDRajQ/na7q04bWepD/x8e+qsci
	 dvR0TXiPTsMPJfBXvNUJaUgVQkp7rj3f6r2o0F85ts8YBrYv8gtTccdUUT1/V5azvZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LvuOFYQEx/i2PkfGeOEEyICaoXsx9kjDe3ZH2YfjCfk=;
	b=v/jjq5Jt+x2cL8myoLrDN7N9WW2MN1xy2S4zG03sBdbrMkVA10h1qzRZK7UIXJOeFjXx
	 CRF6gQnEXS5SlgtlSMEtiH4aRqXdSXbnEULezCZ7hL4SzQqEGzOiRmJnpC0D+Sh8IwRwc
	 dBOSfOxRbs6JzswQxXN1b1xFbnkrvCQX6OA5bC6SvbD8FgtO7oxjUpvaST8L5rKcjLgQa
	 HDNsaSgudvh0wMvhmy9Da9JPlRhH9VIqPm2JGVddvsYKCRALyMWoGY51Z49xO0e49Hjkd
	 dAGctYD3oaF88WgKgmofXN/7DJp6iSdgQOhRbuY6S0AWLXPd5UaCtvYt1gCeJqFo6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxlEvS4q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6114606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxlEvS4q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B44E1F0089F;
	Sat,  7 Nov 2026 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048290;
	bh=LvuOFYQEx/i2PkfGeOEEyICaoXsx9kjDe3ZH2YfjCfk=;
	h=From:To:Cc:Subject:Date;
	b=RxlEvS4qCPc0r5oppPrmHsBWWv777KPUzaNjxef+ry78NwNkN+jnsr1Xv/q+dggu4
	 03y2HjLzbhbBrBNMT/rQTeau7CRZRpVp30R0LjiKvH2zkK8J4BWXS4ASeN0Y1GyVdL
	 eM+uzm7ayJsOyWDo2nc5bdhy4iClJAwCBtnoPZP5BdzNJIR0PO0uN6OJEdUoohYTpv
	 x5axeDKquF5jRc8pU0cJG82krjKgbqpzp8W3xVJOxSpA1sad97bX69ATMa+uWYzNXB
	 RRSh0LipR2eBiL2UjJ11jZjQjPRLeeUzKCGO+EfRkpw91J5DqF+HehGZwLZtVjaYvA
	 FhBzlT5A2mdkA==
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
Subject: FAILED: patch "[PATCH] mm/page_isolation: fix UBSAN shift-out-of-bounds warning" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:48 -0500
Message-ID: <20261107054448-failed-6.1-eba0e6297edd@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x eba0e6297edd60a85bc96ff5cfb734d066af62dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054448-failed-6.1-eba0e6297edd@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




