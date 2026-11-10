Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332097;
	b=rgOa/k3uJbPztwNVmjFF8WopuqBUca4dlEN/1Ky6j5DKF4MJtQY8+5rOshCEJeAhujcV
	 JP/cz1JdEn/QZlcVY0Q0Ys4tJoOP2Cb2n8yphKE5hzFOOB6sqi7EmANSubBH6FF3poAJs
	 ut+yAdpwUpHQGxRdJbculFLlTfv8BBaLX5XSXLTSbOgF2krx1EMyw9wsiTIn0dNIOYGW4
	 XEWNUcrLPOWh4vN4/Buoz0IeXdDSRq/HOfa5Zf752MZb5A5+Rj8ZOytQcgOM46Htck7qU
	 r0Kml950EZ04bPOYR3aejxvwRDYrg0dWOdrdbNyCHW7WvHEQSi8ID0eH5L0VhyWDsrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JWo5pWbFJLi4qIao/hNNkxNAqX+0WD8WTA/NothC2p0=;
	b=AbTgJcnjPqHu3q93WZCPbMl1GUMQ/PgDWo6ocJpjr//dFcXH9RKG0A69rRB94EHe9zpl
	 hXX3Zeb1mvkwX9G2c+erOcqk+GkIbQSQ742UdtmteqjHMfAfXkLs8i08pn95xgqQh0+tC
	 AjWiLI2zN1kmVDXsfpF9/sImDf130cAVV4emIRZgEvl1yECGKSxPi4H8DMD/7obwVLFcJ
	 FIQisZfY6b7wCsRKEiZSZwDnNNkmAjfYbop/I7x3N6Q4W33KYTEkkk9OHUA65iI0qafMw
	 pNfdb5SqDGOJr8ck04n/R8JrglzzxugtUXvIMlv5zznTjEE/TuVkaEDRw9haT6t4SXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jiq7yEFD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89D606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jiq7yEFD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45781F008A4;
	Tue, 10 Nov 2026 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332096;
	bh=JWo5pWbFJLi4qIao/hNNkxNAqX+0WD8WTA/NothC2p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jiq7yEFDKYTR+t1OAS4cNy8fp45qmz9VpqJ1SGWj1x/zLGXYOEpHmpa5DSuHz1X9u
	 UImquQuNITyrxi1FNajSMSYZf4m+08UfwoNB0gbtzQDfNmSlEjqgTxB0Lxd8iRBCng
	 /qTdouP2bmEv2HcK0rRpaHrguHu+axiH5+rTT1vXvLInK3+YW8Lb8zFbzi2LkIfKzP
	 p9KarNXp9tPjDp/wBOI8Rbt+UY0p57S62Ex2u4pKViyHMZNK2KnaCK5qdavE3Uo9Yc
	 zWncKHwi5wSJF3iB1xR171RPucP72nXUH+QE/Ju/Cuf5ZX2y9HUDaRX42yXi3DgZBW
	 B/1/k+SsuJItQ==
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
Subject: [PATCH 6.1.y] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming
Date: Tue, 10 Nov 2026 12:34:53 -0500
Message-ID: <20261110173346.2982447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054451-failed-6.1-374f65b14819@kernel.org>
References: <20261107054451-failed-6.1-374f65b14819@kernel.org>
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
[ sashal: adapted __memcg_memory_event() calls to memcg_memory_event() without the allow_spinning argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 478c153749139..4a841e2a4853c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2640,10 +2640,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2755,16 +2756,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2774,7 +2770,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2827,7 +2831,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    gfpflags_allow_blocking(gfp_mask)) {
 		mem_cgroup_handle_over_high(gfp_mask);
 	}
-	return 0;
+	return ret;
 }
 
 static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-- 
2.53.0

