Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503996;
	b=0nswEYvL2EFWcmGd6HKLgwKqU9McmeybEOtTO2bz4eVzmJNZpu1BX6IGA6r2589STnOH
	 qcwNA09wfr5GAEpAajpjydLGxYcekCGx49iIwMFUMSzvgNp9CnSX+Ps/qvsFItnLJnjyC
	 1ZrZtzkLQa6L+2vC9DeESRXdq15eVUfPHD835Is3xVfhxVcYJGnIiL36BEFPKcBgWYUh0
	 l2CbJ9j9YP8W6lwfj4UlBZud3BuajG5lLvSXrGOUNtY1j5D1tjReu7onmxpDZGKKjeDXq
	 3BIMzT8P5eQBQe6IAWlAvjVcTBTSTo7g0J7F3pkz9QEWF0X1P2WSBzmUYGA5uVZITlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503996;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yM+umQBBUJ+t8QYydtb0nZre+3Y0T5Yk4Bmmx5vdxz8=;
	b=KkInr1iBx1WBfYUSZXHZxzgMnuQJQ5gVVY3xo/aDb1Kyxxuyz+HOX4uKdwgTdvVsoGY/
	 8vIGBHOZmshyWw3Lw0J+sVpeBGhHV6bON88HBVbKHcs77ziCeT0OpGbQb4o8j7JjZhtCq
	 NLNRFD/zl2T3xi3FDAZGNhDlMfbi67bmgKPY/FOSJufSyqfpUtpaoIYFzgvj5GDwe01sf
	 as39ebVtQbqz6Qm7RMVksB9lnkx0By/S83bGMo8oau6bhCipRR0baOGfcKuDAy9Y4f4Yo
	 1CsM2hZnIDZpSG6Zo4ZaN6lY55ReQjckbORJV16zfxH79gKSWl3n+ZbUjAk7620tAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGS5N0pl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C063606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGS5N0pl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5931F000C7;
	Thu, 12 Nov 2026 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503996;
	bh=yM+umQBBUJ+t8QYydtb0nZre+3Y0T5Yk4Bmmx5vdxz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGS5N0plOX1VaCM9+noAA1GwlB2JGg/PfeIdXWlXjvaUwXCbkxHzPrfypQtZp+lSn
	 ru/ld1Yg1q2nqnpP2B7P/4gO+K0m08nJMotwG8gWUHj8ldtXgpdHdjGr1QAPtmy1j1
	 AI+FpT2nJO5jU6K49ljlNqf451PLYW9S9FG9L0WRAzo3+fw86rKCCD2eHpXHWgeskt
	 deXyt642uhltjcf43/hQ/c0EP3hJMzMh7Ooos9YHkNGWQpOrqlTfXLa019b0HpVQ+h
	 2xl/ZWTSA6TBb5+JM0kfXoTQ60uOWSiBDdOr6uJR9vt8UxshHe9pow15LsMnxbqlX2
	 WEN9bhyYynj0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chanwon Park <flyinrm@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/page_alloc: let the highest memory node recover from hopeless state
Date: Thu, 12 Nov 2026 12:19:53 -0500
Message-ID: <20261112171936.3071020-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200358-failed-6.18-83367658a010@kernel.org>
References: <20261109200358-failed-6.18-83367658a010@kernel.org>
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

From: "Gregory Price (Meta)" <gourry@gourry.net>

[ Upstream commit 83367658a01087375ede31ae343c99da03f72ac8 ]

free_frozen_page_commit() clears a hopeless node's kswapd failures once
its zone recovers above the high watermark, but only if another memory
node exists for allocations to fall back to.

The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
with a higher id.  The highest-numbered memory node therefore never
recovers on this path, and its kswapd stays disabled until reclaim on that
node makes progress and balances it, or demotion is re-enabled.

In many cases, direct reclaim many never fully run against a lower node
(CXL/kmem), and that means its kswapd can end up full disabled in rare
situations.

To reproduce, fill the highest memory node with bound, non-THP anonymous
memory and no swap until kswapd gives up, then free it: /proc/zoneinfo
keeps showing node_unreclaimable 1 for that node.  A lower node recovers.

Count the memory nodes instead.  Adding first_memory_node != nid to the
existing test would also work, but a count says directly what the check
means: some other memory node exists.

Link: https://lore.kernel.org/20261019184850.3427905-1-gourry@gourry.net
Fixes: e7a5f249e6db ("mm: re-enable kswapd when memory pressure subsides or demotion is toggled")
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chanwon Park <flyinrm@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: Retained direct atomic accesses to kswapd_failures because the upstream helpers are unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2685e570bf7de..f13168bcddf5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2938,7 +2938,7 @@ static void free_frozen_page_commit(struct zone *zone,
 		 * kswapd work again by resetting kswapd_failures.
 		 */
 		if (atomic_read(&pgdat->kswapd_failures) >= MAX_RECLAIM_RETRIES &&
-		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
+		    num_node_state(N_MEMORY) > 1)
 			atomic_set(&pgdat->kswapd_failures, 0);
 	}
 }
-- 
2.53.0

