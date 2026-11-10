Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331253;
	b=mEYqJtfXEqPIszN4We4ivEUm0Ht6qIdTlKtVomF7JrvJMfaIhrqenaJN9eokw+kXuAqv
	 xWM18RD8Bqv6Qr95HNQsWhSaOWsa63bnrygMJ2oAYJ+NSejhS+S0CABvqLkUkaexzqcXU
	 C8Se4wLjXZijCj9N2eoSe6tn4ob9o21izD9FasVHgD55f7YTFA2TFwrkH0gKM5ccnJrLW
	 rf5kopk5Y4A9ifB3fo9vHzAEHe+/WWrf031ZV7f8JkTseG5EuQJ3cWokn2EZU/cUvyDpO
	 6fAJMZ7Wgoek7yiGAPfjXHFHyDuMTcG9Qly82YW37EDnSgCVG15ESqni+MBWegzlClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C87OChDp7G2+aJozreR1hNtaqpBVNZw1zN6hZH+bwZg=;
	b=LPQ6/yZ1VggHcmV8gdRJv9p9NK5bEEVdWnB+hPEuanQil6t3FIiNJK8ZbSU40cHc/Xvs
	 hYmtjLg39q6SoSJDiHS3/f1Szsbf7KShLlP3vWueURGlHhklOWRqDewNBD8MxcJRwUx8p
	 cSQrTygv5hyPpTj1VTpF+MDZ6KTxfz/lpOfD7JH8kJ8f6ORDvHLGB3rsV7Ytr4b7MQXdn
	 0242Ej++zjszEcbPVScpHMa12E9g199tpZPQ/LvOExxtG46Dfjh5BAEfn2cG9avg6HooJ
	 CLKB40XBFnT1Dma+n4iW4t0ztnf0sc/lpA40xt9jrCap7H/tZkbdY+JOw/nbtkPgJ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMCLCPgq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF21606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMCLCPgq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD91F0089F;
	Tue, 10 Nov 2026 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331253;
	bh=C87OChDp7G2+aJozreR1hNtaqpBVNZw1zN6hZH+bwZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eMCLCPgq2cE7bWrXsUCLde8sV+233j0sVPVlTWq0quxmsJTM9TgxpR0qC38M16nrt
	 nMFLrWBQ1Ign7ZMNXoLKd/wR8PTGQBJp/jM0UM+bn92ofK5FY/emPAsSWC+flsZZpG
	 7fWv3CcEuskakV56yX6l/sNfwKc8EzFdm7htSdQ5aDOrK56B77iH6tKGi6dAapL1oC
	 Kq/IxwU5Rsf+cV/B9BoRhR8PYLribyXzSswVAilyjpRokdXBG1lVnt7OljdXy4PutJ
	 EA870tTBtSx5IwZE6qIBgImxKJM1FaVOO60aF4HYC1E95tSf6xAZ/7FEXT6MNTPglN
	 B9pw73jgiGhgw==
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
Subject: [PATCH 6.12.y] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming
Date: Tue, 10 Nov 2026 12:20:51 -0500
Message-ID: <20261110172030.2733216-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051933-failed-6.12-374f65b14819@kernel.org>
References: <20261107051933-failed-6.12-374f65b14819@kernel.org>
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
[ sashal: Replaced __memcg_memory_event(..., allow_spinning) with the existing memcg_memory_event() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d1caa4faf69f..46769bce0603a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2182,10 +2182,11 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2297,16 +2298,11 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2316,7 +2312,15 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2375,7 +2379,7 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask))
 		mem_cgroup_handle_over_high(gfp_mask);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.53.0

