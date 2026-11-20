Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144144;
	b=nGm5wTUF8hFvfEb3znCixoOHBi3rnjnEKCzI2gVoWyIYo9vpLkQQ4JgNS98apSI+EgQD
	 70EByKV56EddRJ/B3gkBj8S1Hid3h970BAg2yHmHX6bFaqmmh/HW1gcrlU74a0rUhDIG9
	 ZoNTWtkClYjILRF0O/9y64/s+OKFS41r3WNjpm33f2D9jeWVqroTbE8eg5HTcmASfJHwY
	 Y7IExpWts1EF4jG8TrxKRhiiE3TFjjsaIDJ/H9+107EbElOiAs07NdpWvzBjLISpPYOVm
	 mW3yjHijxG5sD9ck8bTZ8bYfEwvu1idQyv3FyEmpeWWJUYhQqd71QmnsH0TGrVhRxCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=/112yjBAo8sXSHLcvPzkfLFWjOImiCNaaXmM2UuGMJg=;
	b=DLdOm9lvAMOWR1QXm+ag+RjjQsIhNTs+yeCqXmzXLx5BLl1Fmbh/1E5Xz+2O0NPIFzaN
	 dOzmqntprL8+grlzIL1mCXQ2uHdBWNKNtA6z7lSkiVYh+VNrWmMxNUPK1FsmunryHohgo
	 IsJXS2IxNky7ikXPtup5XEwHGu7R5gHo1HKv/NzyM+dldTBLWx2BVTaFXF+Jt9AW+tU7g
	 b/R47C4WWqtckGTuGCJxMcd7hVu3CZ/o0XaWlf5nVOXtKdtBBRi0ZS+iQdk5dMs8USbV2
	 /8jq3AtD27zpGkmco4kDboRzOl1UBAWC1DvG843ZD+cieqg70gh+9iAj14QaL8kO6Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--surenb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZgjLC0N2;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D25606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4D25606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZgjLC0N2
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-382af5cfc58so1231231eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 19:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795144142; x=1795748942; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/112yjBAo8sXSHLcvPzkfLFWjOImiCNaaXmM2UuGMJg=;
        b=ZgjLC0N2cX8mbur+a/E5dd/5PsrPcFDapSXT/9RoGrK7fiPStg3r2NkDN5nC+wJlQF
         f6LcV52Forpf9Hjsex3FMiFgC+SrdgTGr/BckwV5LwjTPHNgapxHRQNy5i2a+JNtZUkA
         pdAYThwibbwUhyzkmt65IYY4HbcTAsvqd7ntCCQRA3OdhW82OzkZVgRnkpyYef46Ri4D
         p1EMT0SL1qlKwwCmpF+kyYj5S6jq+Pt6e7o0sq5KYik7IXQNegdPuPj/QK+UzrKx1raU
         ntkZXv4FLogjbk7d+3usRv4iomezFeGGMCNiSt7bEIac/q8Dk/3q2gvYveIg8Cb4JUSm
         yz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795144142; x=1795748942;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/112yjBAo8sXSHLcvPzkfLFWjOImiCNaaXmM2UuGMJg=;
        b=tKxS9KOvm41dc1/6LQ8lD5d321e3d83HWfMDJud4H3/k6UTxaurltzjjlNDpOOw1Hf
         CI/A1bmO20qmJ0G5waYSKV/Uwdl9eMvo90MTrfyyBVyL/Qnbki1NfX/8toBM+ckzR7KY
         1JeiaAybdOxe6c/hc1eGOuZKA5YO4xF6ojW+dC7fYXkY5UnXcMd4SFfL2nksSosI2g78
         EmDNzXEcXO2w3+SP5wTNwbujUmdky7Cq6gxbjG+Xwg8cWJZizo3NcwSA88lK2x7XBCh0
         7YNmm8GO93qDG0XXZ8Gvd3dlcsY9k3/ePOuniMDi3fVSErEltEWoEy83D7r4s0eHIXFM
         wxuQ==
X-Gm-Message-State: APuU4Z/jksAX87+iRRTzq9KJ0eIlUKZvbxWVzchk4JxgKDWLySdkdsPB
	w8ihBsNcPKWIgllnn0Hx6k4uQdQl1Phjt/Sa9zX0bHt4sij47zcnAsA59/Jt2Q0mdHUHYbPlyGT
	LBT+AI24BiL2ErEUbEGoNZKmDP/KgHYAm6IaV8Kr2HFH4Yo6WAQTgWKL6lPQm0cIXfTtAcughNq
	hP26ghJCCQIyW6BkCcm+99UlKiN95hwGGEfnHt
X-Received: from dybqy9.prod.google.com ([2002:a05:7300:d709:b0:381:e4bb:7fb7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd86:b0:351:2958:1740
 with SMTP id 5a478bee46e88-3856fb641famr1451772eec.37.1795144141481; Thu, 19
 Nov 2026 19:09:01 -0800 (PST)
Date: Thu, 19 Nov 2026 19:08:33 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120030833.3188636-1-surenb@google.com>
Subject: [PATCH 7.3.y] mm/slub: refill prefilled sheaves from the barn
From: Suren Baghdasaryan <surenb@google.com>
To: stable@vger.kernel.org, david@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Hao Li <hao.li@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hao Li <hao.li@linux.dev>

commit 1b87ea06a34b213e45e3e0c4effd5043f15046ed upstream.

Currently, when the prefill API refills a non-full sheaf, it takes the
objects from partial slabs and never from the full sheaves in the barn,
so once the barn's full list becomes saturated, it stays saturated.

For objects freed via kfree_rcu(), every RCU sheaf then has to be
flushed to slabs because the barn's full list has no room.

To fix this, let the sheaf refill from the barn first, and introduce a
partial sheaf in the barn, which holds the leftover objects [1].

Only the prefill path needs the partial sheaf. The generic allocation
path (__pcs_replace_empty_main()) exchanges an empty sheaf for a full
one from the barn, so nothing is left over. The prefill path refills a
sheaf that is not necessarily empty, so taking objects from the barn
usually leaves leftovers, and the partial sheaf is where they are
kept. refill_sheaf() only takes objects from partial slabs and never
involves the partial sheaf.

The sheaf is refilled by copying objects from the partial sheaf, and
then from a full sheaf taken from the barn if it is still not full. A
sheaf that objects were copied from stays in the barn as the partial
sheaf if it still holds objects, or goes on the empty list if it is
empty. The sheaf being refilled is never replaced.

The gain comes from two sides: every full sheaf taken out makes room on
the barn's full list for a future RCU sheaf, and refilling from the
barn is cheaper than refilling from partial slabs under list_lock.

Note that putting the sheaf with the leftover objects on the full list
instead would not work: it would occupy room on the full list, so the
list would stay saturated and rcu_free_sheaf() would still keep
flushing.

An earlier version of this patch swapped sheaves instead, to minimize
the memcpy overhead. As Harry Yoo pointed out [2], replacing the
caller's sheaf loses cache affinity, filling it directly is more
straightforward, and testing showed no measurable difference between
the two approaches, so the approach he suggested is used.

Tested with will-it-scale mmap1 (192 processes, one-minute runs) on the
maple_node cache.

throughput: 27778727 -> 34500556 (+24.2%)

metric                       baseline           patched        change
=====================================================================
alloc_fastpath                 54,124            56,696        +4.75%
alloc_slab                  7,100,651           159,739       -97.75%
barn_get                          849       194,460,392    +22904539.81%
barn_get_fail                       2               217    +10750.00%
barn_put                          851       182,306,701    +21422544.07%
barn_put_fail             260,400,484       145,522,675       -44.12%
cmpxchg_double_fail         1,029,204           334,228       -67.53%
free_add_partial          326,694,687       181,935,790       -44.31%
free_fastpath                  13,297            15,611       +17.40%
free_rcu_sheaf          8,332,839,104    10,490,535,227       +25.89%
free_remove_partial         7,099,788           158,297       -97.77%
free_slab                   7,099,788           158,297       -97.77%
free_slowpath              10,969,156           782,851       -92.86%
objects                        15,295            14,849        -2.92%
objects_partial                15,295            14,849        -2.92%
partial                         1,604             2,336       +45.64%
sheaf_alloc               137,757,895       141,208,076        +2.50%
sheaf_flush             8,332,823,922     4,656,725,764       -44.12%
sheaf_free                137,757,883       141,208,072        +2.50%
sheaf_prefill_fast      3,337,502,163     4,196,506,116       +25.74%
sheaf_prefill_slow                685               400       -41.61%
sheaf_refill            8,343,794,364     4,657,509,724       -44.18%
sheaf_return_fast       3,337,502,411     4,196,506,382       +25.74%
sheaf_return_slow                 437               134       -69.34%
slabs                           1,604             2,336       +45.64%
total_objects                 102,656           149,504       +45.64%

Here is what the important metric changes mean.

barn_get and barn_put: refills now take full sheaves out of the barn,
and RCU sheaves are put into the barn again. Before, the barn's full
list was saturated once and hardly ever consumed.

barn_put_fail: more than half of the RCU sheaves are now put into the
barn instead of being flushed. The rest are still flushed because they
arrive while the barn's full list is at its limit.

sheaf_refill and free_add_partial: fewer objects are taken from partial
slabs to refill sheaves, and fewer slabs are added to the partial list,
by the same percentage.

alloc_slab and free_slab: the partial list is almost never empty when a
refill looks at it, so slabs are almost never allocated and freed again
only to serve refills.

After the test, the maple_node cache holds 1604 slabs without the patch
and 2336 with it. After a manual shrink
(echo 1 > /sys/kernel/slab/maple_node/shrink), it holds 485 without
the patch and 563 with it. So most of the extra slabs are held only by
objects sitting in sheaves and are returned by a shrink, and what
remains is a small difference, because objects handed out from the barn
come from many more slabs than a refill from partial slabs would use.

Link: https://lore.kernel.org/linux-mm/aqPlMzUIw-4g2iOX@fedora/ [1]
Link: https://lore.kernel.org/linux-mm/aq0ylDidEHa2kg4X@thinkstation/ [2]
Signed-off-by: Hao Li <hao.li@linux.dev>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Link: https://patch.msgid.link/20260921094521.141665-1-hao.li@linux.dev
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Original patch from v7.4-rc1 applies cleanly over stable 7.3.y.

In v7.0-rc1, per-CPU slabs and per-CPU partial lists were removed (see:
17c38c88294d, e323b52cf00f, 32c894c7274b). Therefore once barn->nr_full
hits MAX_FULL_SHEAVES, every refill_sheaf() and sheaf_flush_unused()
will compete for the node-wide n->list_lock. This patch fixes this.

In pre-7.0 kernels per-CPU slabs and per-CPU partial lists are still
there and refills use per-CPU c->freelist and per-CPU partial slabs
without taking n->list_lock. Similarly, do_slab_free() recycles freed
slabs through per-CPU c->slab and c->partial without taking n->list_lock.
Therefore this patch has no performance benefit on those older branches.

 mm/slub.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 544cff39762c..a0f0bdc1e30a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -422,6 +422,7 @@ struct node_barn {
 	spinlock_t lock;
 	struct list_head sheaves_full;
 	struct list_head sheaves_empty;
+	struct slab_sheaf *sheaf_partial;
 	unsigned int nr_full;
 	unsigned int nr_empty;
 };
@@ -3298,6 +3299,7 @@ static void barn_init(struct node_barn *barn)
 	spin_lock_init(&barn->lock);
 	INIT_LIST_HEAD(&barn->sheaves_full);
 	INIT_LIST_HEAD(&barn->sheaves_empty);
+	barn->sheaf_partial = NULL;
 	barn->nr_full = 0;
 	barn->nr_empty = 0;
 }
@@ -3315,6 +3317,10 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
 	barn->nr_full = 0;
 	list_splice_init(&barn->sheaves_empty, &empty_list);
 	barn->nr_empty = 0;
+	if (barn->sheaf_partial) {
+		list_add(&barn->sheaf_partial->barn_list, &full_list);
+		barn->sheaf_partial = NULL;
+	}
 
 	spin_unlock_irqrestore(&barn->lock, flags);
 
@@ -5073,12 +5079,87 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
+/*
+ * Refill @sheaf from the barn: from its partial sheaf first, then from its full
+ * sheaves. A sheaf that objects were copied from stays in the barn as the
+ * partial sheaf if it still holds objects, or goes on the empty list if it is
+ * empty.
+ *
+ * Returns true if the sheaf is now full, at s->sheaf_capacity.
+ * Returns false if the sheaf is still not full.
+ */
+static bool refill_sheaf_from_barn(struct kmem_cache *s,
+				   struct slab_sheaf *sheaf)
+{
+	struct node_barn *barn = get_barn(s);
+	struct slab_sheaf *src;
+	unsigned int to_move;
+	unsigned long flags;
+
+	if (!barn)
+		return false;
+
+	if (!data_race(barn->nr_full) && !data_race(barn->sheaf_partial))
+		return false;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	/*
+	 * The partial sheaf can hold fewer objects than @sheaf needs to
+	 * reach capacity, and a sheaf on the full list is not necessarily
+	 * full (see the comment in rcu_free_sheaf()), so keep taking from
+	 * the barn until @sheaf is full or nothing is left.
+	 */
+	while (sheaf->size < s->sheaf_capacity) {
+		src = barn->sheaf_partial;
+		barn->sheaf_partial = NULL;
+		if (!src) {
+			if (!barn->nr_full)
+				break;
+			src = list_first_entry(&barn->sheaves_full,
+					       struct slab_sheaf, barn_list);
+			list_del(&src->barn_list);
+			barn->nr_full--;
+		}
+
+		to_move = min(s->sheaf_capacity - sheaf->size, src->size);
+		src->size -= to_move;
+		memcpy(&sheaf->objects[sheaf->size], &src->objects[src->size],
+		       to_move * sizeof(void *));
+		sheaf->size += to_move;
+
+		if (src->size) {
+			barn->sheaf_partial = src;
+		} else {
+			/*
+			 * No empty-limit check: the sheaf put on the empty list
+			 * was already in the barn, so the barn holds no more
+			 * sheaves than before. barn_replace_empty_sheaf() skips
+			 * the check for the same reason.
+			 */
+			list_add(&src->barn_list, &barn->sheaves_empty);
+			barn->nr_empty++;
+		}
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	if (sheaf->size < s->sheaf_capacity)
+		return false;
+
+	stat(s, BARN_GET);
+	return true;
+}
+
 static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
 				      struct slab_sheaf *sheaf, gfp_t gfp)
 {
 	gfp_t gfp_nomemalloc;
 	int ret;
 
+	if (refill_sheaf_from_barn(s, sheaf))
+		return 0;
+
 	gfp_nomemalloc = gfp | __GFP_NOMEMALLOC;
 	if (gfp_pfmemalloc_allowed(gfp))
 		gfp_nomemalloc |= __GFP_NOWARN;
-- 
2.56.1.750.gf70dc682cf-goog

