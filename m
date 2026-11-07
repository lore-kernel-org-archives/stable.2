Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047529;
	b=ZyofWqOeiQ4qB1SOP/zYfSXb+7vQYFY9vNW09hPwiPV4781TqE8pMZfSyf18TlLukW6r
	 h82C1uN0pYqggOsxoje28fqR2Ze7dsuvM2N6pwFBnQOPZokVlN5a8UTVB5gWxwGbjXAje
	 2Iwf5O/S2WD/fbs9/m4Jyy/r1YaKQXZJycfOhnTyntagXfbQPR2rKIl1kzN3pKjHxaYpG
	 29oMj4E/L2EIMbM4q32VMhxrZUk+MEx1Lx7oa4iNUethr6Gbk0BFl5GpjWN/YTvIJDS8/
	 9qulcWXa98v6zDwfJ20i+GZqOsYk2TvlI7hidYkLOAHgtmEPAi/3/AJ40pXixezF79w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=H2kEnTvJbzlcXZRilaXPtEkGsbvQmwTaybTs1wmf0iU=;
	b=fFU3TgopNZhTfMC+b/DjIy0McNQIQJU1wTTv8FzrSFXGkemjEdyUfq0UzFtS9IyHLXzJ
	 SrAuZnKm8ZFDub5h2V8HzuConmQAyOkCGlVurAfaSkIUUF2HuG1S6aR+AT+HT+aQeOw43
	 nLAmxkv0YW5sDe8Hx8M/NG4dNWnCLB+p9WFLjqb9uH07D3OrJTsJ3Z49+jp0z4R8A7APO
	 lp8rkuzLhegm0BMKgiipBrJimv/aXg4uapGmVJtuelQuRabndiLgBfbAnxKc+eIntDGW0
	 +hyvE4soMhmgmhCihApuGHXy9dxyYTPXPlKS8PcAxCssSovimbnxoVAWwpeK9gXQxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/HqylUO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DE606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/HqylUO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7A1F0089F;
	Sat,  7 Nov 2026 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047528;
	bh=H2kEnTvJbzlcXZRilaXPtEkGsbvQmwTaybTs1wmf0iU=;
	h=From:To:Cc:Subject:Date;
	b=h/HqylUOkli4Zvqe1ub2Sc7ZqGs8OYWlPDbyoazWOPbwLOYxh9XlnRnbG6rFc+I+z
	 nMxgRwmjw2tsEANM48BBAxmohOAaB3mA2MRTsQSvguJCpG5kpYs4YyXEjsE3VcX8BB
	 9ePYFL1d/OU1FL15ZFLBvQaclRb4awbz/Mek0/XkNF+tTijrMIflRcHTb05sap1Smx
	 lB9XBAOlv2IDYDO2pQHwaVZMiiL6kS5MYQR6jaRPD3yc+XX50xhj691Uv6BMJtqZ6i
	 +oTjN/p8guUTjz5G4FkOsfEQGfTArj+9FHQptyFWIgZADUzP0LZpAbHMAE0gbDje00
	 toAUThwuK6XDg==
From: Sasha Levin <sashal@kernel.org>
To: joe@dama.to,
	akpm@linux-foundation.org,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:06 -0500
Message-ID: <20261107053206-failed-6.6-374f65b14819@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 374f65b1481992eb6b9c6bffd53f3afa5c2e94cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053206-failed-6.6-374f65b14819@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 374f65b1481992eb6b9c6bffd53f3afa5c2e94cf Mon Sep 17 00:00:00 2001
From: Joe Damato <joe@dama.to>
Date: Mon, 31 Aug 2026 10:48:35 -0700
Subject: [PATCH] mm: memcontrol: raise MEMCG_MAX for charges that fail without
 reclaiming

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
---
 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d5ebe83eae3ef..aeaa09e01d70e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2685,10 +2685,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	int ret = 0;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
-		return 0;
+		return ret;
 
 	if (!allow_spinning)
 		/* Avoid the refill and flush of the older stock */
@@ -2799,16 +2800,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
-		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
-
 	/*
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit
@@ -2818,7 +2814,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 
-	return 0;
+out:
+	/*
+	 * Don't forget to raise a MEMCG_MAX event for forced or rejected
+	 * requests.
+	 */
+	if (!raised_max_event)
+		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
+
+	return ret;
 
 done_restock:
 	if (batch > nr_pages)
@@ -2877,7 +2881,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    !(current->flags & PF_MEMALLOC) &&
 	    gfpflags_allow_blocking(gfp_mask))
 		__mem_cgroup_handle_over_high(gfp_mask);
-	return 0;
+	return ret;
 }
 
 static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-- 
2.53.0




