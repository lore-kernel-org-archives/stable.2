Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851711;
	b=WuQvOhZGm+zd23Nl/gpCSF2qp6O+4z4ltuRsJyd/sW0iVPQg5QA3jT0O6ZdKR1y3aEEy
	 J6OgPqcTzz7DqbX7SGlv9P4JgHCORNrD1MMFQQCwZz8IJBlBf3aqImE7fi2FB1YybC1Xi
	 ooa4nc1OokvP63GiQYSDmKn8CWYNfy3+9KSLyFo7wvxj/30Mvz78gYMivRmhjImHwAWTJ
	 4u/CfM476ifAPlW9QerXUBJFv2dS22asdSrNNYxdLDWSNGLSmxJYeZVvQk+ueMT0Gzv1L
	 Q74+j36IYMsiEyBFWCLDbIZTfGAaQ73CaWEPX8j1n6HZMoUsYmBiF5iDnWtu/uyLNZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851711;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hxAdYOiZMDWVnhrVJerUgUeo3FuklgjtpnZJkBnaqj0=;
	b=VwXnxJXkHZ03gDETVQHwMqT5GIzXKhv+mGvK5FLJWqMkqrBClmGOJfwBHMUTNjJR7hyZ
	 ugxA/Hc7QrzeHHn9jxDk3hEnD2UbfWoXBDtjynnO2fC7TaV5PnFDnawxLbvSFTgSN5eHA
	 hwVxd72vFpL1tXPi7e0WoNApExOoKvopXdm0xeMkkeNZHYFuRTDbEOvu5I59ZbOi3n9KT
	 hlYm+8T4MLy9aCA+gt0+Gh1h0BX80rRkh+hsqqBe+VXnvkFIduPVMPPkSsfnv0sc18xmg
	 i1WIDwQ1Z8XuQ/qEY6j6WW2ECK7SzYTHXTvuWkosVxhnVErkSXqkjjRCJZIe66f4MRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RUDGX5v7;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02071606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02071606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RUDGX5v7
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4zR6GuXHlYIEiJeN1rNCRlmHY2SNfG3wyJTdYXq1hOg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793851708; v=1; x=1794456508;
 b=RUDGX5v78X1j40xqFE1muXfgcFojzyNxW8vviBxIFY9jVQ7/B74hJWUZKU0PPNicHuBmqF1W
 hkn0V+3VAdchOTtdJ2RAT3njv5eed/swXVGlb58FHPqIzibbAAvXZ/As297LqhZIxHTgcfk13eD
 q5o0pTXAf6TYvlPSm9lkfgis=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 39f390051dfdd29d;
	Thu, 05 Nov 2026 04:08:28 +0000
X-Mizu-Trace-ID: 39f390051dfdd29d
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com,
	lance.yang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] mm: hugetlb: fix cpuset violations in gigantic surplus allocations
Date: Thu,  5 Nov 2026 12:07:46 +0800
Message-ID: <046fd77e49ee8bb35e3bcc4104b9275d2e72ea5e.1793850539.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793850539.git.zhengqi.arch@bytedance.com>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
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

CMA and the contiguous allocator trust a supplied nodemask without
checking the current cpuset. Gigantic surplus allocations can therefore
use nodes forbidden to the faulting thread.

For example, moving a non-leader thread to another cgroup v1 cpuset
updates its mems_allowed without rebinding the shared VMA policy:

  CPU0 (cpuset attach)             CPU1 (thread T)
  -------------------             ---------------
  T->mems_allowed = {0}
  /* Skip mpol_rebind_mm()
     for a non-leader. */
                                  /* VMA MPOL_BIND remains {0,1}. */
                                  hugetlb_cma_alloc_frozen_folio()
                                    /* node0 fails; node1 succeeds. */

Intersect the allocation mask with the current cpuset, preserving
MPOL_BIND and MPOL_PREFERRED_MANY fallback rules. Retry only failed
allocations when the cpuset changes.

Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
Cc: stable@vger.kernel.org
Reported-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/hugetlb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6fba92b0f6749..09b64f7c11dd2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2181,22 +2181,33 @@ struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, struct mempolicy_interpreted *mpoli)
 {
 	struct folio *folio = NULL;
-	nodemask_t *nodemask = mpoli->nodemask;
+	nodemask_t alloc_nodemask;
+	unsigned int cpuset_mems_cookie;
+
+retry:
+	cpuset_mems_cookie = read_mems_allowed_begin();
+	alloc_nodemask = cpuset_current_mems_allowed;
+	if (mpoli->mode == MPOL_BIND && mpoli->nodemask &&
+	    nodes_intersects(*mpoli->nodemask, alloc_nodemask))
+		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
 
 	if (mpoli->mode == MPOL_PREFERRED_MANY) {
 		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
+		nodes_and(alloc_nodemask, alloc_nodemask, *mpoli->nodemask);
 		folio = alloc_surplus_hugetlb_folio(h, gfp, mpoli->nid,
-						    nodemask);
+						    &alloc_nodemask);
 
-		/* Fallback to all nodes if page==NULL */
-		nodemask = NULL;
+		/* Fallback to all nodes allowed by the current cpuset */
+		alloc_nodemask = cpuset_current_mems_allowed;
 	}
 
-	if (!folio) {
+	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, mpoli->nid,
-						    nodemask);
-	}
+						    &alloc_nodemask);
+
+	if (!folio && unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+		goto retry;
 
 	return folio;
 }
-- 
2.54.0

