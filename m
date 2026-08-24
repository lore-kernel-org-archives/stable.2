Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21C22264AB
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539287; cv=none; b=NIzemv3kTQhlEw4kk2Gz8X6bzvyCttoxJcTnKGtpyEPivxNoJfWKGn1332ikNB6GND+rCP+jvstF0ZAYpkuOCgBzYRjIBvulTgOdSBCBmDgiZ6TRlioAXfYTqUSDYklF+fOP8C03Pjdghlh8n67PhYChLyEmnbjMW8W0Lz6MIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539287; c=relaxed/simple;
	bh=SgYhmWBqzeB50hT1Vxf285rpR3+htGAeUJ/0a+EDtxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APlnZUv+vX/7mG+kjyi181xxuB5yoy6gmPoPVwL13GBinCf2oyzvR9MWRtNMTiEv5vG8Ywek5YumHR+qA5ZsKhVKl+fCPdLbVald6XAQ7dIcAMZN4UZusCz3/bOL77vS31o1hndSg2jUv95pNPMyP0nbmpowIhn/9ipZrwz+hBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E+jmJgas; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E+jmJgas"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52b6543169fso20161111cf.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787539281; x=1788144081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zMgUDKT62DeKeqlqvHdFsR2bI0aE5RkYkhomGJfRr0k=;
        b=E+jmJgasy7+9e0vBytdZCYCqlqaNNm53l9MEgqW+jMQM+mWrGSstfBhYETNPzFRuig
         +VxCbZHDIpbsLIK+lfOcgtQWfaw9ZhsWUIGsC8v+1cIMh91H6OA6WWRnAM8fEo68k/oO
         O8pgOzaheeqXIMwKAITcbN3rMvUMU+nIQvQl1uKEJr3tMsWB8fSjAd/9Tt4fA5XE41oa
         bgX76fwOIqVO+n+x+zqEuZJUYwqggXvrO6LpM+e5lDXZTJ3/bNQbJAset+vRNUWqXx7j
         pPKm5LV8ut9W3NUOGeiIQpexEdo6yA/E1ViCdG2w4bZ+EqcPxO5zw1jlXcDawrMQNa1f
         7Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787539281; x=1788144081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zMgUDKT62DeKeqlqvHdFsR2bI0aE5RkYkhomGJfRr0k=;
        b=JK51tl/UAmZhGu7XMRhqhkpB+9uhtMmeK1EDlBLPylq/S2OBicRdI4W+4TStHg5Y7r
         TuDjGKrs41J85UlopIP3C5vR0uK0+OjgqB7F499KG9dfozGWxbN6GXZIADIovfs7eRqG
         mKPuZhiAEsleqJ6cXJcowjNh1sDaarry5451D11rH6kezLbrXOmO08orjQeXBw0nLsdJ
         QqV39ht6ZFQrAAAjIErHI6OuxU7Lz+emPm9Q+Juho0rn7vq1Q81BmMHrDD2ISlSIzvjW
         QdA8D2O3PNRl+cDZD6B1dIrAaWj1gI2oD7vqfYSaKyv8t3XXPJciFbGOzlSTDV6KQe1N
         6Q4A==
X-Forwarded-Encrypted: i=1; AHgh+RoqC1Jlk0FM9c3xk162VGwe5U+I6byGTnFlL6fFkeVIuQ5D2FugwVebKqlVXxPblMG5LRKGVto=@vger.kernel.org
X-Gm-Message-State: AFuF++mvnMn/amKy155JrjNlL/vzAZCw60NwFlDFc0eoi+K0RlSjOde8
	ABtoq8M0Szl6NU3B8ql1g618UV+tUaQU4jwThA961zcpLbD4GsCToG/UWJBVhfbC4Dc=
X-Gm-Gg: AR+sD134JpuHfxpUzuUlXLkUQoZiHL/40gbemLN2Z8zCQrl9p0LOC3SBIa5x7pqnIdJ
	jdechEEy+JlQ8zhuElv0j70ByWR0STBdM2e934myRxsQbOANO9y0F9v4lnHeTzc9NH+t0EgKPWv
	wm0zye91mFs8arulduZKgANdIiJUKF4NiPf9Xm46a02DubkuDrdiFEQ9mJFIiX30k5LpIoKraiV
	nlPxz24JQi5bkTsaJ6uY7rDjVNtqUvHzmLqLFB+jBcpWp9dwAGJzUjrkh9Dl7Po/u5SVPWPAGuN
	rLI6vFgEQBAKZg/8j3uWGZQH1ISXIiRt40xCxW/8NQmNguHLPGberDiF2/v56Vyrx/ajyHBsPER
	9TNPfzwPdvZCUxz6Isj36eydpdTX4+919luwZhA1kGnEDfpMHS+i/R52dXlYQq3F7qAEJ9fO+rS
	QrXzWtRniWnK1lRfiaK5f12UqYjRMN4sCbGre1um0oeyFFNAckBkjTaIN3myS8Ap415vkbdWEAm
	+ig2uaXiQeMRyMCOOtHKoEJ6jm+WjVkDb5eyQkDPgWUerjX5Q==
X-Received: by 2002:ac8:584f:0:b0:52d:92c1:b7c2 with SMTP id d75a77b69052e-52df56eff97mr219376221cf.1.1787539281264;
        Sun, 23 Aug 2026 19:41:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c936183d0sm50926846d6.22.2026.08.23.19.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:41:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [PATCH] mm/mempolicy: refcount the weighted interleave state instead of copying it
Date: Sun, 23 Aug 2026 22:41:17 -0400
Message-ID: <20260824024117.1755899-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
References: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_pages_bulk_weighted_interleave() copies iw_table into a scratch
array on every call to get the table outside of RCU.

Refcount the weighted interleave state and cleanup with kfree_rcu().
Refcount and iw_table get their own cachelines to prevent false sharing.

This drops a kzalloc/memcpy/kfree per call and deals with a bug induced
by the scratch array's hardcoded GFP_KERNEL and the partial allocation it
returned when that failed.

Tested in VM (KASAN, PROVE_LOCKING and DEBUG_OBJECTS_RCU_HEAD) with a
udelay() injected between the rcu_dereference() and the refcount_inc
to stress the race. Six concurrent bulk allocators racing four threads
writing the sysfs weights took the retry path 2536 times with no splat,
and the published state was back to a count of one at rest.

Replacing the kfree_rcu() with a bare kfree() in that same test reports
a use-after-free immediately, so the test does exercise what the deferred
free protects.

Fixes: fa3bea4e1f82 ("mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving")
Cc: stable@vger.kernel.org
Reported-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/all/20260821170407.3721004-1-edumazet@google.com/
Reported-by: syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a88837e.ae6ddae5.3da009.0040.GAE@google.com/T/#u
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---

Hi Andrew - please consider this instead.

 mm/mempolicy.c | 76 ++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e5175f1c767..4a3722c63b31 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -112,6 +112,7 @@
 #include <linux/printk.h>
 #include <linux/leafops.h>
 #include <linux/gcd.h>
+#include <linux/refcount.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -156,7 +157,9 @@ static const int weightiness = 32;
  */
 struct weighted_interleave_state {
 	bool mode_auto;
-	u8 iw_table[];
+	refcount_t refcnt;
+	struct rcu_head rcu;
+	u8 iw_table[] ____cacheline_aligned_in_smp;
 };
 static struct weighted_interleave_state __rcu *wi_state;
 static unsigned int *node_bw_table;
@@ -167,6 +170,27 @@ static unsigned int *node_bw_table;
  */
 static DEFINE_MUTEX(wi_state_lock);
 
+/* Allow sleeping readers to pin the state to avoid taking copies */
+static struct weighted_interleave_state *wi_state_get(void)
+{
+	struct weighted_interleave_state *state;
+
+	rcu_read_lock();
+	while ((state = rcu_dereference(wi_state))) {
+		if (refcount_inc_not_zero(&state->refcnt))
+			break;
+	}
+	rcu_read_unlock();
+
+	return state;
+}
+
+static void wi_state_put(struct weighted_interleave_state *state)
+{
+	if (state && refcount_dec_and_test(&state->refcnt))
+		kfree_rcu(state, rcu);
+}
+
 static u8 get_il_weight(int node)
 {
 	struct weighted_interleave_state *state;
@@ -235,6 +259,7 @@ int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 		return -ENOMEM;
 	}
 	new_wi_state->mode_auto = true;
+	refcount_set(&new_wi_state->refcnt, 1);
 	for (i = 0; i < nr_node_ids; i++)
 		new_wi_state->iw_table[i] = 1;
 
@@ -265,10 +290,7 @@ int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 	rcu_assign_pointer(wi_state, new_wi_state);
 
 	mutex_unlock(&wi_state_lock);
-	if (old_wi_state) {
-		synchronize_rcu();
-		kfree(old_wi_state);
-	}
+	wi_state_put(old_wi_state);
 out:
 	kfree(old_bw);
 	return 0;
@@ -2632,7 +2654,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *weights, weight;
+	u8 *table, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2676,25 +2698,12 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	me->il_weight = 0;
 	prev_node = node;
 
-	/* create a local copy of node weights to operate on outside rcu */
-	weights = kzalloc(nr_node_ids, GFP_KERNEL);
-	if (!weights)
-		return total_allocated;
-
-	rcu_read_lock();
-	state = rcu_dereference(wi_state);
-	if (state) {
-		memcpy(weights, state->iw_table, nr_node_ids * sizeof(u8));
-		rcu_read_unlock();
-	} else {
-		rcu_read_unlock();
-		for (i = 0; i < nr_node_ids; i++)
-			weights[i] = 1;
-	}
+	state = wi_state_get();
+	table = state ? state->iw_table : NULL;
 
 	/* calculate total, detect system default usage */
 	for_each_node_mask(node, nodes)
-		weight_total += weights[node];
+		weight_total += table ? table[node] : 1;
 
 	/*
 	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
@@ -2706,10 +2715,10 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	rounds = rem_pages / weight_total;
 	delta = rem_pages % weight_total;
 	resume_node = next_node_in(prev_node, nodes);
-	resume_weight = weights[resume_node];
+	resume_weight = table ? table[resume_node] : 1;
 	for (i = 0; i < nnodes; i++) {
 		node = next_node_in(prev_node, nodes);
-		weight = weights[node];
+		weight = table ? table[node] : 1;
 		node_pages = weight * rounds;
 		/* If a delta exists, add this node's portion of the delta */
 		if (delta > weight) {
@@ -2735,7 +2744,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	}
 	me->il_prev = resume_node;
 	me->il_weight = resume_weight;
-	kfree(weights);
+	wi_state_put(state);
 	return total_allocated;
 }
 
@@ -3644,6 +3653,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	new_wi_state = kzalloc_flex(*new_wi_state, iw_table, nr_node_ids);
 	if (!new_wi_state)
 		return -ENOMEM;
+	refcount_set(&new_wi_state->refcnt, 1);
 
 	mutex_lock(&wi_state_lock);
 	old_wi_state = rcu_dereference_protected(wi_state,
@@ -3660,10 +3670,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 	rcu_assign_pointer(wi_state, new_wi_state);
 	mutex_unlock(&wi_state_lock);
-	if (old_wi_state) {
-		synchronize_rcu();
-		kfree(old_wi_state);
-	}
+	wi_state_put(old_wi_state);
 	return count;
 }
 
@@ -3696,6 +3703,7 @@ static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
 	new_wi_state = kzalloc_flex(*new_wi_state, iw_table, nr_node_ids);
 	if (!new_wi_state)
 		return -ENOMEM;
+	refcount_set(&new_wi_state->refcnt, 1);
 	for (i = 0; i < nr_node_ids; i++)
 		new_wi_state->iw_table[i] = 1;
 
@@ -3728,10 +3736,7 @@ static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
 update_wi_state:
 	rcu_assign_pointer(wi_state, new_wi_state);
 	mutex_unlock(&wi_state_lock);
-	if (old_wi_state) {
-		synchronize_rcu();
-		kfree(old_wi_state);
-	}
+	wi_state_put(old_wi_state);
 	return count;
 }
 
@@ -3775,10 +3780,7 @@ static void wi_state_free(void)
 	rcu_assign_pointer(wi_state, NULL);
 	mutex_unlock(&wi_state_lock);
 
-	if (old_wi_state) {
-		synchronize_rcu();
-		kfree(old_wi_state);
-	}
+	wi_state_put(old_wi_state);
 }
 
 static struct kobj_attribute wi_auto_attr =
-- 
2.55.0

