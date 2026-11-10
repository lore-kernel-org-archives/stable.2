Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331842;
	b=WMDLvzMIrja9JzxtanXQjoMpWK91ArgXxibbsANijbrlB4PCQh0tS0mCaSRSwdMRPCC2
	 VwLKHp4TRIPNj+DDqs/zrM8zBhy6g/4k6+BoQrljPdx2o9XfPfuWp3ortfLJ5jNOsdjnS
	 3A8CYGoYQZjM527lUb0DjiryjRM73H2sIfrqX7VGV5yENOVnB7Tva+bq8lvc5bTK2otHY
	 UJHS7Rxox7DEGXSSAcRyeka+P3djK63SqdHfjKgCOgWzzhFN3FvQzjNo+63NiJUxgJbfN
	 cCDQQAnM6F7staSNJS4V1FvKBSc3HwCsXxv9XPj2RQTrP3VXdkho1HIGEODZjVqdNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kWPMc5MkO6fyRKvhyV3mY4b213zNGSf1COAbedk/OiE=;
	b=5Ltt4whDnqKeHM1xEUXX49Px4WKOd6f4lmpccX1kn/771jBgPwlJ1h1iqHxj309LxP0C
	 0IWcM9u/zyReY42XfZ4U6y2dIUUyAu9J3vUzGCrP9Yf5V38WhHDI347gMkNvNWgHdV6iA
	 077fW/Rah6NZZNkBmOW5NpGe9mgqaf3CmpfD0W1IjA7TvHoD6UEtBDTq24LUlw58BaO4E
	 ExKy5b4svN354Yzxevj04ousdqqPYVAz81smL75Bi/CArag7xgYWC4tgC/L+x/WwuwmOl
	 gnfPJZRw2z60jATUp3s95/g/IUwpUcEIUGQo3nGAZvkaP2/9oQ/x3fGoTr/UHZ0PFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSHi9iZU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC875606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSHi9iZU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CCE1F0089F;
	Tue, 10 Nov 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331841;
	bh=kWPMc5MkO6fyRKvhyV3mY4b213zNGSf1COAbedk/OiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PSHi9iZUFVcaxSnaJmWgAQc83WnLBIdpvhAWH7tO+FGboY0i3kDTOXyYoNart4TSj
	 GMYeW2tXXWXZh67SB1oFJZaXRP/X5b2QH9RXlKxSmDRBP2whOswFoLn4MbeJRfe3k/
	 4C9LoYydsHFH46dE/7EhRtP1K94cB0DAJvHkTp9X5ur26lMOSx+wkWAhKWN3fsjuCK
	 I3bZLCyWwvVBgZArlahzTZusoHro9osGDrjUl3488xppYFmPvWDUKxYlHXdUjtK46c
	 7W8JHQz2cXKc8iqBo8QbjL8PxASSF4TUC5SgxXd1RsTd0OmEMT//lnRmVaUK4oWWL+
	 iYnTWoIUan3PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Damato <joe@dama.to>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming
Date: Tue, 10 Nov 2026 12:30:38 -0500
Message-ID: <20261110173025.2913165-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053206-failed-6.6-374f65b14819@kernel.org>
References: <20261107053206-failed-6.6-374f65b14819@kernel.org>
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

From: Joe Damato <joe@dama.to>

[ Upstream commit 374f65b1481992eb6b9c6bffd53f3afa5c2e94cf ]

Charges that exceed memory.max and return through the nomem label can
raise no event and simply return -ENOMEM.

A non-blocking charge can hit the limit, get rejected, but is not visible
in memory.events.

This was noticed in a production setting where bpf_mem_alloc() attempted
to refill its per-cpu freelists, which triggered a non-blocking charge
while at the limit.

Commit d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for
enforced allocations") added raised_max_event to cover charges that are
force charged without ever reaching reclaim, but charges that are rejected
outright were left out.  Getting an allocation failure without the
corresponding MEMCG_MAX event is unexpected and makes debugging and
monitoring harder.

Raise the event on the way out for rejected charges as well, by routing
the -ENOMEM return through the same exit path that already covers forced
charges.  The existing behavior of raising a MEMCG_MAX event on every
charge/reclaim/retry iteration is left unchanged.

Tested with a module that performs accounted GFP_NOWAIT page allocations
from a task in a cgroup at its memory.max, and measures the resulting
memory.events:max delta.  Without this patch the rejected charges raise no
event at all; with it the delta matches the number of rejected charges
exactly.  A GFP_KERNEL|__GFP_NORETRY control, which reaches reclaim,
raises the same two events per failed charge before and after, confirming
the existing charge/reclaim/retry accounting is unchanged.

Link: https://lore.kernel.org/20260831174836.3102406-1-joe@dama.to
Fixes: d6e103a757fa ("mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations")
Signed-off-by: Joe Damato <joe@dama.to>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
[ sashal: Changed __memcg_memory_event(..., allow_spinning) to memcg_memory_event(...) to match the existing API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 852fa93efe1be..34920b31e456c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2682,10 +2682,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
+	int ret = 0;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
-		return 0;
+		return ret;
 
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
@@ -2797,16 +2798,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * put the burden of reclaim on regular allocation requests
 	 * and let these go through as privileged allocations.
 	 */
-	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
-		return -ENOMEM;
+	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH))) {
+		ret = -ENOMEM;
+		goto out;
+	}
 force:
-	/*
-	 * If the allocation has to be enforced, don't forget to raise
-	 * a MEMCG_MAX event.
-	 */
-	if (!raised_max_event)
-		memcg_memory_event(mem_over_limit, MEMCG_MAX);
-
 	/*
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit
@@ -2816,7 +2812,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 
-	return 0;
+out:
+	/*
+	 * Don't forget to raise a MEMCG_MAX event for forced or rejected
+	 * requests.
+	 */
+	if (!raised_max_event)
+		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+
+	return ret;
 
 done_restock:
 	if (batch > nr_pages)
@@ -2869,7 +2873,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    gfpflags_allow_blocking(gfp_mask)) {
 		mem_cgroup_handle_over_high(gfp_mask);
 	}
-	return 0;
+	return ret;
 }
 
 static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-- 
2.53.0

