Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046776;
	b=i9GMebS69mR2udGvcrWeYhFeNeKfscV/YabSw6xac66+9qfSaaQs3qQ9Y9JN2MljrdfA
	 iaoIvFYP1YcSetGImA5VsLGzg+k3Amb1y5DlgV1XhNf2iO1qgzqj/2HGQr16KbbCJOR78
	 I77e7Jbyo4UmD/jZ6kOIv1NEFDtjfa4WJw9Hj+VwQjk7fX932j1pN979TrgvgQGGe9vcU
	 +WcOmS8486vgqvte/Ml71rYk+B0tAZVRTQMtXmnnxkFfPSzmotMyn1cmLaDRXxZbl2H5d
	 a1D//Q7/Ac2tP9UdCnjT6tYxYEd5lG7+gVN0QmnGk87l9HIvq+7Osg91kutASn8NJPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AlniOs+cFmaMNKA0Y8N2wEbM9IE9u89GlHsN0v5bJiY=;
	b=RNVLTUPSOEB/uEWOcBIGvtKeRoZeQBoaPCa2ZvlgRucQCIUhtDJcuumtDXoIAXbUuaiF
	 Vfyrf6qt2RikugMAu803qBVDUTWDUD6lZ5xmJEM7PsaP3MgjHdZL4Ds/062LagiQwmedB
	 1ErwtTGM1iZYTX6vKn9TCCzucSROf3H+IRi6HYC1Rl1nQiqFQoJqtvZvOpq7oLh/mLr0a
	 HPp627aJZxlSIrjyBVNWnu8PBCXnJYJ9YnLFLjXAr7p+3lpwKJiCgkizGyYVe4EdHC8Z+
	 53Hzha3BMdKNi8+1oOP3N6ve6ItdX8h6v8T0NK/LgxuuJi/I0GFfc7H1vV6bfpUzFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gifUW1Mf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36C60A2620
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gifUW1Mf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105BD1F0089F;
	Sat,  7 Nov 2026 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046775;
	bh=AlniOs+cFmaMNKA0Y8N2wEbM9IE9u89GlHsN0v5bJiY=;
	h=From:To:Cc:Subject:Date;
	b=gifUW1Mfe/NHJWhfw+/+Sum8+3CnstXforIlDKPWA6aRSETuLl4Jif5gNOdGhnpNP
	 RzocJyjHn5fJF2rIswd1/vwGO/OfIifl2dPrxWfr0BHBySmkw+HqiB/nAEixoskNvb
	 3hRP7DQlkHyc7ziJB1CVFLvGEJi36bnxr/GEhdpvc1V8EWGpKUN9a1bf4wp8NJ7Kf6
	 5RpsxvRbGwXZgqgKkB4QvJ7PnyQ1hHZrEdSM21YBX1qZlUwES3Gu/H+lSV93dmiiUv
	 3zxzijF+QwkWW3j0FOatZeFuA/WNEY5J49l4Z8HsK+xMlrp3YDZi4r/vIAips5FDQz
	 56ubNjeoMbgFA==
From: Sasha Levin <sashal@kernel.org>
To: joe@dama.to,
	akpm@linux-foundation.org,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:33 -0500
Message-ID: <20261107051933-failed-6.12-374f65b14819@kernel.org>
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
git cherry-pick -x 374f65b1481992eb6b9c6bffd53f3afa5c2e94cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051933-failed-6.12-374f65b14819@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




